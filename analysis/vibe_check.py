#!/usr/bin/env python3
"""Plot ArduPilot vibration levels from a .bin log and check them against MECH-02.

Usage: python vibe_check.py <log.bin> [--limit 30] [--save plot.png]
"""
import argparse
import sys

import matplotlib.pyplot as plt
from pymavlink import mavutil


def read_vibe(path):
    log = mavutil.mavlink_connection(path)
    t, x, y, z, clip = [], [], [], [], []
    while True:
        msg = log.recv_match(type="VIBE", blocking=False)
        if msg is None:
            break
        # Only IMU 0 (the primary); IMU field missing in old logs
        if getattr(msg, "IMU", 0) != 0:
            continue
        t.append(msg.TimeUS / 1e6)
        x.append(msg.VibeX)
        y.append(msg.VibeY)
        z.append(msg.VibeZ)
        clip.append(getattr(msg, "Clip", getattr(msg, "Clip0", 0)))
    return t, x, y, z, clip


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("log")
    ap.add_argument("--limit", type=float, default=30.0, help="m/s^2 (MECH-02)")
    ap.add_argument("--save", help="save the plot instead of showing it")
    args = ap.parse_args()

    t, x, y, z, clip = read_vibe(args.log)
    if not t:
        sys.exit("No VIBE messages found in log.")

    peak = max(max(x), max(y), max(z))
    clips = clip[-1] - clip[0] if clip else 0
    passed = peak < args.limit and clips == 0

    print(f"Samples: {len(t)}")
    print(f"Peak vibration: {peak:.1f} m/s^2 (limit {args.limit})")
    print(f"New clipping events: {clips}")
    print("RESULT:", "PASS" if passed else "FAIL")

    fig, ax = plt.subplots(2, 1, sharex=True, figsize=(10, 6))
    ax[0].plot(t, x, label="X")
    ax[0].plot(t, y, label="Y")
    ax[0].plot(t, z, label="Z")
    ax[0].axhline(args.limit, color="r", ls="--", label=f"limit {args.limit}")
    ax[0].set_ylabel("Vibration (m/s²)")
    ax[0].legend()
    ax[0].grid(alpha=0.3)
    ax[1].plot(t, clip, color="k")
    ax[1].set_ylabel("Clip count")
    ax[1].set_xlabel("Time (s)")
    ax[1].grid(alpha=0.3)
    fig.suptitle(f"{args.log}: {'PASS' if passed else 'FAIL'}")
    fig.tight_layout()

    if args.save:
        fig.savefig(args.save, dpi=120)
    else:
        plt.show()
    sys.exit(0 if passed else 1)


if __name__ == "__main__":
    main()
