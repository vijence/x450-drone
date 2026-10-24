# Requirements (v0.1 draft)

| ID | Requirement | Rationale | Verification |
|---|---|---|---|
| SYS-01 | Take-off mass ≤ 1.8 kg with battery | Stays well inside the propulsion set's 1.5–2 kg envelope | Weigh |
| SYS-02 | Static thrust-to-weight ≥ 2.0 | Control authority margin for wind and payload | Analysis (motor data) + hover throttle ≤ 50% |
| SYS-03 | Hover time ≥ 12 min on 4S 5000 mAh, landing at 3.6 V/cell | Useful test sessions | Flight test |
| SYS-04 | Payload capacity 500 g (Pi + camera + sensors) | Companion computer phase | Flight test with dummy mass |
| SYS-05 | Operates in wind up to 8 m/s | Typical Israeli coastal conditions | Flight test |
| MECH-01 | Arms: 16 mm OD carbon tube | Stiffness; X500-compatible parts | Inspection |
| MECH-02 | FC on a vibration-isolated mount | IMU noise | VIBE log < 30 m/s² |
| MECH-03 | GPS mast ≥ 80 mm above the power wiring | Compass interference | Compass interference check (mag vs throttle) |
| MECH-04 | Printed parts in PETG or PA-CF, not PLA | Heat and impact | Inspection |
| MECH-05 | Survives a 0.5 m drop without structural damage | Landing mistakes during learning | Drop test |
| ELEC-01 | Battery voltage and current monitored by the FC | Battery failsafe | Calibrate against a multimeter |
| ELEC-02 | Single-point power disconnect (XT60) | Safety | Inspection |
| SAFE-01 | RC loss → RTL (or Land if no GPS) | Fly-away prevention | Failsafe matrix |
| SAFE-02 | Low battery → RTL at 3.5 V/cell, Land at 3.3 V/cell | Battery protection | Failsafe matrix |
| SAFE-03 | Geofence: 100 m radius, 50 m altitude | Stay within the field | Failsafe matrix |
| SAFE-04 | Dedicated arm and emergency motor-stop switches | Operator safety | Bench test |
| SW-01 | All parameter changes committed to `params/` | Traceability | Git history |
| SW-02 | Companion-computer code tested in SITL before flight | Risk reduction | Test report |
