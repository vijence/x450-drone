# Failsafe test matrix

Every scenario runs in SITL first, then on the bench (props off) where possible, and then in flight.

| ID | Scenario | Trigger | Expected behaviour | SITL | Bench | Flight | Notes |
|---|---|---|---|---|---|---|---|
| FS-01 | RC link loss in Loiter | Turn the TX off | RTL after the timeout | ⬜ | ⬜ | ⬜ | |
| FS-02 | RC link loss in Auto | Turn the TX off | Continue the mission or RTL (per `FS_THR_ENABLE`) | ⬜ | – | ⬜ | |
| FS-03 | RC link loss, no GPS fix | Turn the TX off, GPS disabled | Land | ⬜ | ⬜ | ⬜ | |
| FS-04 | Low battery (1st level) | Battery voltage falls to 3.5 V/cell | RTL | ⬜ | – | ⬜ | |
| FS-05 | Critical battery | Battery voltage falls to 3.3 V/cell | Land | ⬜ | – | ⬜ | |
| FS-06 | Geofence breach (radius) | Fly out past 100 m | RTL | ⬜ | – | ⬜ | |
| FS-07 | Geofence breach (altitude) | Climb above 50 m | RTL | ⬜ | – | ⬜ | |
| FS-08 | GCS telemetry loss | Disconnect the GCS | Per `FS_GCS_ENABLE` | ⬜ | ⬜ | ⬜ | |
| FS-09 | GPS loss in Loiter | Simulated GPS glitch | EKF failsafe → Land or AltHold | ⬜ | – | ⬜ | |
| FS-10 | Emergency motor stop | Kill switch | Motors stop immediately | ⬜ | ⬜ | ⬜ (low altitude only) | |
| FS-11 | Companion-computer crash in Guided | Kill the Pi process | Hold position / operator takes over | ⬜ | – | ⬜ | |
