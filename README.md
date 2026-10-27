# X450: an ArduPilot development quadcopter

A 450-class quadcopter I'm designing, building and validating from scratch. The goal is hands-on depth in the full UAV stack: airframe design, flight controller integration, tuning, autonomy, a companion computer, and GPS-denied navigation.

I run the project the way I run validation work in my day job. Each stage has requirements, a test plan, logged data, and a written report with pass/fail criteria.

## Status

| Milestone | Status |
|---|---|
| M0: Simulation (SITL) | ⬜ Not started |
| M1: Requirements & design | ⬜ Not started |
| M2: Procurement | 🟨 In progress |
| M3: Build & bench test | ⬜ |
| M4: First flight & tuning | ⬜ |
| M5: Autonomy & failsafe validation | ⬜ |
| M6: Companion computer (MAVLink) | ⬜ |
| M7: GPS-denied navigation | ⬜ |
| M8: Final report | ⬜ |

The exit criteria for each milestone are in [docs/roadmap.md](docs/roadmap.md), and the workflow (issues, branches, weekly review, definition of done) is in [docs/how-we-work.md](docs/how-we-work.md).

## The aircraft

| | |
|---|---|
| Frame | ~480 mm diagonal, 16 mm carbon arms, 3D-printed hub and mounts (own design, SolidWorks) |
| Flight controller | Holybro Pixhawk 6C Mini (STM32H743, dual IMU) running ArduPilot |
| GNSS | Holybro M10 + IST8310 compass |
| Propulsion | T-Motor AIR2216 II 920KV, 10×4.5" props, Holybro Tekko32 4in1 50A ESC (AM32, bidirectional DShot, telemetry) |
| Battery | 4S 5000 mAh LiPo |
| RC link | ExpressLRS 2.4 GHz (RadioMaster TX16S + Ranger, RP2 receiver) |
| Companion | Raspberry Pi, MAVLink over UART (TELEM2) |

The full bill of materials is in [docs/bom.md](docs/bom.md).

## Repository layout

```
docs/          requirements, roadmap, BOM, design decisions, test plans and reports
cad/           STEP / STL / drawings, versioned
params/        ArduPilot parameter snapshots, one commit per change
companion/     Raspberry Pi code (Python, MAVLink)
analysis/      log-analysis scripts and plots
logs/          selected flight logs (.bin), referenced from reports
checklists/    pre-power, pre-flight and post-flight checklists
templates/     flight log, test report and decision record templates
```

## How I work

- **Simulate first.** Every parameter change and script runs in ArduPilot SITL before it flies.
- **Parameters live in git.** I export the full `.param` file after every change, so any two flights can be diffed.
- **Every flight is logged.** Each flight gets a goal, the parameter version, its result and the issues found ([templates/flight-log.md](templates/flight-log.md)).
- **Decisions are written down.** Each design choice gets a short record of its options, trade-offs and outcome ([docs/decisions/](docs/decisions/)).

## A note on code

The software in this repository (companion scripts, analysis tools) is written with AI assistance (Cursor / Claude). I own the requirements, the architecture, the integration and the testing.

## Safety & regulation

Operated under Israeli CAAI rules, at an approved flying field. Props are never fitted on the bench. See [checklists/](checklists/).
