# CLAUDE.md: context for AI assistants

## Project
X450: a 450-class ArduPilot development quadcopter that Ziv is designing, building and validating from scratch. The goal is hands-on UAV experience (integration, tuning, autonomy, companion computer, GPS-denied navigation) to support a move into the drone and defense industry.

Ziv is a mechanical engineer (SolidWorks, 3D printing) working in validation and regulation for autonomous vehicles (SOTIF/FuSa, field testing, CAN, Raspberry Pi tooling). The project is run like a validation program: requirements → test plan → logged data → report with pass/fail.

## Key decisions (see docs/decisions/)
- FC: genuine Holybro Pixhawk 6C Mini + PM02 V3 (analog) + M10 GPS. **ArduPilot** (not PX4).
- RC: RadioMaster TX16S (OpenTX → upgrade to EdgeTX; internal MULTI, not ELRS) with an external RadioMaster Ranger ELRS 2.4 GHz module and an RP2 receiver over CRSF.
- Propulsion: T-Motor Air Gear 450 (2216 920KV, 20A ESCs, T1045 props), 4S 5000 mAh LiPo.
- Frame: own design, 16 mm carbon arms, PETG/PA-CF printed hub and mounts.
- Companion: Raspberry Pi on TELEM2, MAVLink2 @ 921600.
- No 5.8 GHz video (Israeli import and regulatory issues). Video comes later, from the Pi over Wi-Fi.

## Conventions
- Docs and code in **English** (this is a public portfolio repo).
- **SITL first**: any script or parameter change is proven in ArduPilot SITL before it flies.
- Parameters: export the full `.param` file to `params/` after every change; the commit message says what changed and why.
- Every flight gets an entry from `templates/flight-log.md`; every milestone ends with a report from `templates/test-report.md` in `docs/test-reports/`.
- Design decisions are recorded with `templates/decision-record.md` in `docs/decisions/NNNN-*.md`.
- Requirement IDs (SYS-, MECH-, ELEC-, SAFE-, SW-) in `docs/requirements.md`: reference them in tests and reports.
- Companion code: Python 3, **pymavlink or MAVSDK**. DroneKit is unmaintained, so don't use it for new code.
- Code is written with AI assistance; keep the README note about this honest and accurate.
- Safety first: never suggest bench tests with props fitted; failsafes are configured before the first flight.

## Background
**Read `docs/project-notes.md`** for the state of the owned equipment (TX16S details, battery recovery), purchasing notes and links, regulatory findings, the future upgrade path and the open items. Keep it updated as things change.

## Current status
- M2 procurement in progress (see `docs/bom.md`).
- Next: M0, SITL + Mission Planner setup on Windows; M1, requirements freeze + SolidWorks design.
