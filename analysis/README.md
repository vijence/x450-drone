# Log analysis

Python tools for ArduPilot `.bin` dataflash logs.

## Setup
```bash
python3 -m venv .venv && source .venv/bin/activate
pip install pymavlink matplotlib numpy
```

## Tools
- `vibe_check.py`: plots vibration and accelerometer clipping and checks them against the MECH-02 limit.
  ```bash
  python vibe_check.py ../logs/2026-11-20_01.bin
  ```

## Planned
- Battery sag under load (voltage vs current)
- EKF innovations and position estimate vs GPS (M7 evaluation)
- FFT of the gyro for the harmonic notch setup
