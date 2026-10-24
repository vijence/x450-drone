# 0001: Flight controller and firmware

**Status:** Accepted · 2026-10

## Context
I need a flight controller that is standard in industry and well supported, and that has the processing headroom for companion-computer work.

## Options
| Option | Pros | Cons |
|---|---|---|
| Pixhawk 6C Mini (genuine) | FMUv6C standard, H7, dual IMU with isolation and heating, first-class ArduPilot/PX4 support | ~₪900 with GPS |
| Pixhawk 6X | Triple IMU, Ethernet | ~₪1,700, overkill for this aircraft |
| "Pixhawk 6C PRO" clone kit | Cheaper, many accessories | Unknown sensors, no isolation guarantee, no support |
| Matek H743 | Cheaper, runs ArduPilot | Less recognised, single IMU |

## Decision
Genuine Pixhawk 6C Mini running **ArduPilot**.

## Consequences
- Analog PM02 power module; voltage and current calibration required.
- Authenticity check on arrival (both IMUs detected).
