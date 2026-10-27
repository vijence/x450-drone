# Interface control document (draft)

Every electrical and data interface on the aircraft in one place. Verify each one on the bench (M3) and mark it ✅.

| ID | From | To | Type / protocol | Connector | Parameters / notes | Verified |
|---|---|---|---|---|---|---|
| IF-01 | Battery 4S | PM02 V3 | Power 14.8–16.8 V | XT60 | Main disconnect (ELEC-02) | ⬜ |
| IF-02 | PM02 V3 | Pixhawk POWER1 | 5.2 V supply + analog V/I sense | 6-pin GH | `BATT_MONITOR=4`; calibrate V and I against the multimeter (ELEC-01) | ⬜ |
| IF-03 | PM02 V3 | Tekko32 ESC | Power | Solder pads / XT60 | ≤ 4×16 A peak | ⬜ |
| IF-04 | Pixhawk **FMU** outputs | Tekko32 ESC | DShot600, bidirectional | 8-pin 1 mm (adapter to Pixhawk header) | `SERVO_BLH_*`, `SERVO_DSHOT_ESC`; FMU outputs only | ⬜ |
| IF-05 | Tekko32 ESC | Pixhawk UART (TBD) | ESC telemetry (serial) | 8-pin TLM pin | `SERIALx_PROTOCOL=16`, optional if bidirectional DShot RPM is enough | ⬜ |
| IF-06 | Tekko32 current sensor | Pixhawk ADC (POWER2?) | Analog current | 8-pin CUR pin | Secondary battery monitor (TBD) | ⬜ |
| IF-07 | ESC | Motors 1–4 | 3-phase | 3.5 mm bullets, 18AWG extensions | Motor order and direction per ArduPilot Quad-X | ⬜ |
| IF-08 | RP2 receiver | Pixhawk UART (TELEM1 or GPS2) | CRSF (ELRS) | 4-pin | `SERIALx_PROTOCOL=23`, `RSSI_TYPE=3` | ⬜ |
| IF-09 | M10 GPS | Pixhawk GPS1 | UART (GNSS) + I2C (compass) + switch, buzzer, LED | 10-pin GH | Mast ≥ 80 mm above power wiring (MECH-03) | ⬜ |
| IF-10 | Raspberry Pi | Pixhawk TELEM2 | MAVLink2 @ 921600 | 6-pin GH → Pi GPIO | `SERIAL2_PROTOCOL=2`, `SERIAL2_BAUD=921`; Pi on its own 5 V / 3 A BEC | ⬜ |
| IF-11 | TX16S + Ranger | RP2 | ELRS 2.4 GHz RF | – | Binding phrase; TX power within the legal limit | ⬜ |
| IF-12 | Pixhawk | GCS (laptop) | MAVLink over USB / Wi-Fi (via Pi) | USB-C | Bench only via USB | ⬜ |
