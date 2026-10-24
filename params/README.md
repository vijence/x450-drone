# ArduPilot parameter snapshots

After **every** parameter change, export the full set and commit it here, so any two flights can be compared with a plain `git diff`.

**Naming:** `YYYY-MM-DD_<short-description>.param`, e.g. `2026-11-20_autotune.param`

**How to export:** Mission Planner → Config → Full Parameter List → *Save to file*.

The commit message says **what** changed and **why**, e.g. `INS_HNTCH_*: enable harmonic notch at 85 Hz from FFT (flight 2026-11-18 #2)`.
