# 0002: RC link

**Status:** Accepted · 2026-10

## Context
I already own a RadioMaster TX16S running OpenTX. Its internal module is a 4-in-1 MULTI (MPM v1.3.1.36, no ELRS), and its JR bay is empty but already configured for CRSF.

## Options
| Option | Cost | Pros | Cons |
|---|---|---|---|
| Internal MULTI + FlySky/FrSky receiver (iBUS/SBUS) | ~₪50 | Cheapest | Legacy protocols, short range, little telemetry |
| **External ELRS (Ranger, JR) + RP2** | ~₪300 | Current industry standard, long range, full telemetry, 2.4 GHz | More cost |

## Decision
External ExpressLRS 2.4 GHz module plus an RP2 receiver connected to the Pixhawk over CRSF on a UART.

## Consequences
- Upgrade the TX16S from OpenTX to EdgeTX (better ELRS support and Lua scripts).
- Transmit power set within the legal limit.
- Keep the Wi-Fi (companion) and ELRS antennas physically apart, since both use 2.4 GHz.
