# Roadmap

Each milestone ends with a short report in `docs/test-reports/` and a git tag (`m0-done`, `m1-done`, …).

## M0: Simulation (SITL)
Learn ArduPilot before risking hardware.
- [ ] Install ArduPilot SITL and Mission Planner (or QGroundControl)
- [ ] Fly Stabilize → AltHold → Loiter manually with the TX16S as a USB joystick
- [ ] Plan and fly a 5-waypoint Auto mission
- [ ] Trigger RC-loss and low-battery failsafes and observe the behaviour

**Exit criteria:** a full Auto mission completes in SITL, and RTL triggers correctly on simulated RC loss.

## M1: Requirements & design
- [ ] [requirements.md](requirements.md) reviewed and frozen (v1.0)
- [ ] Mass budget spreadsheet; predicted thrust-to-weight and hover time
- [ ] SolidWorks: hub, motor mounts, electronics tray with FC vibration isolation, GPS mast, landing gear
- [ ] Wiring diagram (draw.io) in `docs/`
- [ ] Interface control document complete ([icd.md](icd.md)); all TBDs resolved
- [ ] FMEA (`docs/fmea.md`): failure modes per component, effect, detection (log signal), mitigation (failsafe or design)
- [ ] Test-print critical parts; check fit against the actual carbon tubes

**Exit criteria:** the design meets every M1 requirement on paper, and the printed parts fit the tubes.

## M2: Procurement
- [ ] Order everything in [bom.md](bom.md)
- [ ] Incoming inspection for each package (photos, variant check, basic electrical test)
- [ ] Pixhawk authenticity check: both IMUs (ICM-42688-P, BMI088) detected

**Exit criteria:** all parts received and inspected.

## M3: Build & bench test
- [ ] Assemble the frame; solder the power harness
- [ ] Continuity and short checks with the multimeter; first power-up through a smoke stopper
- [ ] Flash ArduPilot; calibrate the accelerometer, compass, radio and ESCs
- [ ] Verify every interface in [icd.md](../docs/icd.md) (mark ✅)
- [ ] Motor order and direction test (**no props**)
- [ ] Failsafe bench test: RC off → expected action

**Exit criteria:** [pre-flight checklist](../checklists/pre-flight.md) passes end to end.

## M4: First flight & tuning
- [ ] Hover in Stabilize at a low height
- [ ] AltHold, then Loiter
- [ ] Vibration analysis (VIBE < 30 m/s², no clipping)
- [ ] Harmonic notch filter set up from FFT
- [ ] AutoTune

**Exit criteria:** stable Loiter for 2 min with good vibration levels, and AutoTune parameters saved.

## M5: Autonomy & failsafe validation
- [ ] Auto missions; RTL; geofence
- [ ] Execute the [failsafe test matrix](failsafe-test-matrix.md)

**Exit criteria:** every matrix scenario passes, or its deviation is understood and documented.

## M6: Companion computer
- [ ] Raspberry Pi on TELEM2; MAVLink heartbeat and telemetry in Python
- [ ] Guided-mode script: take off, fly a square, land (proven in SITL first)
- [ ] Video stream to the ground station over Wi-Fi

**Exit criteria:** a scripted mission flown on the real aircraft, with the RC as safety override.

## M7: GPS-denied navigation
- [ ] Optical flow + rangefinder: Loiter with GPS disabled
- [ ] Visual-inertial odometry on the Pi → `VISION_POSITION_ESTIMATE`
- [ ] Evaluation vs GPS ground truth: RMSE, drift as % of distance travelled

**Exit criteria:** an evaluation report with plots and a comparison of the methods.

## M8: Final report
- [ ] Technical summary, lessons learned, video
