# 0003: Propulsion and ESC

**Status:** Accepted · 2026-10

## Context
The project's goal is depth in **integration, troubleshooting and systems engineering**. The original choice, the T-Motor Air Gear 450 combo, includes four basic 20A ESCs: PWM/DShot in, no telemetry, no current sensing. That leaves nothing to integrate and no data to diagnose a motor or ESC fault with.

## Options
| Option | Cost | Pros | Cons |
|---|---|---|---|
| Air Gear 450 combo (4 separate basic ESCs) | ~₪300–515 | Matched set, simple | No telemetry; legacy approach |
| **AIR2216 II motors + Holybro Tekko32 F4 4in1 50A (AM32)** | ~₪570 | Open-source firmware, bidirectional DShot (per-motor RPM), ESC telemetry (temp, current, voltage), onboard current sensor, single power entry | One board = single point of failure; motor leads must be extended to the centre |
| ARK 4IN1 ESC (AM32, dev-oriented, debug port) | ~€280 | Built for PX4/ArduPilot dev platforms | Too expensive for this budget |

## Decision
AIR2216 II 920KV motors with T1045 props (the combo without ESCs), plus a **Holybro Tekko32 F4 4in1 50A ESC running AM32**.

## Consequences
- **Integration:** the ESC signals must go to the Pixhawk **FMU outputs**, because DShot isn't supported on the IO outputs. Check the 6C Mini pinout before wiring. Set the output protocol to DShot600 with bidirectional DShot enabled, and route ESC telemetry to a UART if it's used.
- **Tuning:** an RPM-based harmonic notch (`INS_HNTCH_MODE = 3`, ESC telemetry), instead of a throttle-based one.
- **Diagnostics:** per-motor RPM, temperature and current in the logs, so a failing motor or ESC can be found from data.
- **Mechanical:** the ESC sits in the hub on 30.5 mm soft mounts; the motor leads are extended with 18AWG silicone wire (each motor peaks at ~16 A, per the T-Motor data at 16 V).
- **Power:** the ESC has no BEC, which is fine because the PM02 powers the FC. Decide whether the ESC's current sensor or the PM02 is the battery monitor of record, and calibrate both.
- **FMEA item:** an ESC board failure means the loss of all four motors. Accepted for a development aircraft; recorded in the FMEA.
