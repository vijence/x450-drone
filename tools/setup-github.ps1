# One-time GitHub project setup: labels, milestones (M0-M8) and the first wave of issues.
#
# Prerequisites:  winget install GitHub.cli   then   gh auth login
# Run from the repo root:
#   powershell -ExecutionPolicy Bypass -File tools\setup-github.ps1
#
# Safe to re-run: existing labels are updated, and existing milestones and issues (matched by title) are skipped.

$ErrorActionPreference = "Stop"
$repo = "vijence/x450-drone"

# ---------- Labels ----------
$labels = @(
    @{ n = "area:mech";        c = "8B5CF6"; d = "Airframe, CAD, 3D printing" },
    @{ n = "area:elec";        c = "F59E0B"; d = "Power, wiring, RC, batteries" },
    @{ n = "area:software";    c = "3B82F6"; d = "ArduPilot, SITL, companion, tools" },
    @{ n = "area:test";        c = "10B981"; d = "Test execution and reports" },
    @{ n = "area:docs";        c = "6B7280"; d = "Requirements, decisions, reports" },
    @{ n = "area:procurement"; c = "EC4899"; d = "Ordering and incoming inspection" },
    @{ n = "area:regulatory";  c = "EF4444"; d = "CAAI licence, registration, flying site" },
    @{ n = "blocked";          c = "000000"; d = "Waiting on something external" },
    @{ n = "issue";            c = "D73A4A"; d = "Unexpected behaviour found in test" }
)
foreach ($l in $labels) {
    gh label create $l.n --color $l.c --description $l.d --force -R $repo | Out-Null
}
Write-Host "Labels: done"

# ---------- Milestones ----------
$milestones = [ordered]@{
    "M0: Simulation (SITL)"               = "Exit: full Auto mission in SITL; RTL triggers on simulated RC loss."
    "M1: Requirements & design"           = "Exit: design meets all requirements on paper; printed parts fit the tubes."
    "M2: Procurement"                     = "Exit: all BOM items received and inspected; Pixhawk authenticity verified."
    "M3: Build & bench test"              = "Exit: pre-flight checklist passes end to end (props off)."
    "M4: First flight & tuning"           = "Exit: stable Loiter 2 min, VIBE < 30 m/s^2, AutoTune saved."
    "M5: Autonomy & failsafe validation"  = "Exit: failsafe test matrix all pass or deviations documented."
    "M6: Companion computer"              = "Exit: scripted Guided mission flown on the real aircraft."
    "M7: GPS-denied navigation"           = "Exit: evaluation report vs GPS ground truth (RMSE, drift %)."
    "M8: Final report"                    = "Exit: technical summary, lessons learned, video."
}
$existingMs = gh api "repos/$repo/milestones?state=all&per_page=100" --jq ".[].title"
foreach ($t in $milestones.Keys) {
    if ($existingMs -contains $t) { continue }
    gh api "repos/$repo/milestones" -f title="$t" -f description="$($milestones[$t])" | Out-Null
}
Write-Host "Milestones: done"

# ---------- Issues (rolling wave: only near-term milestones get detailed issues) ----------
$issues = @(
    # M0
    @{ t = "Install Mission Planner and run built-in SITL (copter)"; m = "M0: Simulation (SITL)"; l = "area:software"
       b = "Mission Planner -> Simulation tab -> Multirotor. Arm, take off in Guided, land.`n`nDone when: a simulated copter flies from Mission Planner." },
    @{ t = "Set up WSL2 + ArduPilot SITL from source (sim_vehicle.py)"; m = "M0: Simulation (SITL)"; l = "area:software"
       b = "Ubuntu on WSL2, clone ArduPilot, install-prereqs, build copter, run sim_vehicle.py and connect Mission Planner over UDP.`n`nNeeded later for companion scripts (M6) and testing parameter changes." },
    @{ t = "Fly Stabilize / AltHold / Loiter in SITL with TX16S as USB joystick"; m = "M0: Simulation (SITL)"; l = "area:test"
       b = "Blocked until the TX16S battery is revived.`n`nDone when: a 5-minute manual flight in each mode without crashing." },
    @{ t = "Plan and fly a 5-waypoint Auto mission in SITL"; m = "M0: Simulation (SITL)"; l = "area:test"
       b = "Takeoff, 5 WPs, RTL. Save the mission file to docs/missions/." },
    @{ t = "SITL failsafe rehearsal: FS-01, FS-04, FS-06"; m = "M0: Simulation (SITL)"; l = "area:test"
       b = "Run the scenarios from docs/failsafe-test-matrix.md in SITL and fill in the SITL column." },
    @{ t = "M0 test report"; m = "M0: Simulation (SITL)"; l = "area:docs"
       b = "From templates/test-report.md, in docs/test-reports/. Tag m0-done." },

    # M1
    @{ t = "Review and freeze requirements v1.0"; m = "M1: Requirements & design"; l = "area:docs"
       b = "Go through docs/requirements.md, adjust numbers, and set the version to v1.0." },
    @{ t = "Mass budget and thrust / endurance estimate"; m = "M1: Requirements & design"; l = "area:mech"
       b = "Spreadsheet in docs/: every component's mass, total AUW, predicted hover throttle and hover time from the T-Motor 2216 data. Verifies SYS-01..03." },
    @{ t = "CAD: centre hub + electronics tray with FC vibration isolation"; m = "M1: Requirements & design"; l = "area:mech"
       b = "SolidWorks. Pixhawk 6C Mini footprint, PM02, RP2, space for the Pi. MECH-02." },
    @{ t = "CAD: motor mounts for 16 mm tube"; m = "M1: Requirements & design"; l = "area:mech"
       b = "Clamp onto the 16 mm OD tube; motor pattern of the AIR2216. Wait for the real tubes to measure the OD." },
    @{ t = "CAD: GPS mast, landing gear, battery mount"; m = "M1: Requirements & design"; l = "area:mech"
       b = "GPS >= 80 mm above the power wiring (MECH-03). Gear survives a 0.5 m drop (MECH-05)." },
    @{ t = "Wiring diagram"; m = "M1: Requirements & design"; l = "area:elec"
       b = "draw.io in docs/: battery -> PM02 -> ESCs; PM02 -> FC POWER1; RP2 -> FC UART (CRSF); GPS1; TELEM2 -> Pi; Pi BEC." },
    @{ t = "Test-print critical parts and fit-check on carbon tubes"; m = "M1: Requirements & design"; l = "area:mech"
       b = "PETG. Record the clearances that worked." },

    # M2
    @{ t = "Order AliExpress batch: charger, propulsion, props, tubes, hardware, safety"; m = "M2: Procurement"; l = "area:procurement"
       b = "See docs/bom.md items 2,3,4,6,7,8,10. Check the variants: 4 motors + 4 ESC; charger WITH ADP100." },
    @{ t = "Order Pixhawk 6C Mini + PM02 V3 + M10"; m = "M2: Procurement"; l = "area:procurement"
       b = "Compare the AliExpress and ZDrone (IL) prices." },
    @{ t = "Order RadioMaster Ranger (JR) + RP2"; m = "M2: Procurement"; l = "area:procurement"
       b = "Ranger = full JR size (not Micro/Nano)." },
    @{ t = "Buy locally: 4S 5000 mAh LiPo + PETG"; m = "M2: Procurement"; l = "area:procurement"
       b = "Just before the build (M3), so the LiPo doesn't sit in storage." },
    @{ t = "Incoming inspection + Pixhawk authenticity check"; m = "M2: Procurement"; l = "area:test"
       b = "Photos, variant check, basic electrical test. Pixhawk: both IMUs (ICM-42688-P, BMI088) detected in Mission Planner." },
    @{ t = "Revive TX16S battery and upgrade OpenTX -> EdgeTX"; m = "M2: Procurement"; l = "area:elec"
       b = "M7 charger, LiIon 2S, 0.3 A until > 3.3 V/cell, then normal. Back up the models before flashing EdgeTX." },

    # Regulatory (no milestone - runs in parallel)
    @{ t = "CAAI: confirm current licence requirements by phone"; m = ""; l = "area:regulatory"
       b = "03-9774504. VLOS multirotor up to 25 kg: practical test needed? Air operator needed? Medical? Write the answer here." },
    @{ t = "CAAI theory study and exam booking"; m = ""; l = "area:regulatory"
       b = "Law & regs, NOTAM, METAR/TAF, aerodynamics. Question bank (e.g. Drone Options)." },
    @{ t = "Find a flying field (model club) and register the aircraft"; m = ""; l = "area:regulatory"
       b = "Needed before M4." }
)

$existingIssues = gh issue list -R $repo --state all --limit 500 --json title --jq ".[].title"
foreach ($i in $issues) {
    if ($existingIssues -contains $i.t) { continue }
    $ghArgs = @("issue", "create", "-R", $repo, "--title", $i.t, "--body", $i.b, "--label", $i.l)
    if ($i.m) { $ghArgs += @("--milestone", $i.m) }
    & gh @ghArgs | Out-Null
    Write-Host "  + $($i.t)"
}
Write-Host "Issues: done"
Write-Host ""
Write-Host "Optional project board (needs project scope):"
Write-Host "  gh auth refresh -s project"
Write-Host "  gh project create --owner vijence --title 'X450'"
Write-Host "Then in the board settings, link the repo and add 'Milestone' as a column/group."
