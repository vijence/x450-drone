# How we work

## Planning
- **Milestones M0–M8** on GitHub, each with exit criteria (see [roadmap.md](roadmap.md)).
- **Rolling-wave planning:** only the current and next milestones are broken into detailed issues. Later milestones are detailed once we get close, because what we learn changes the plan.
- **Every piece of work is an issue**, labelled by area (`area:mech`, `area:elec`, `area:software`, `area:test`, `area:docs`, `area:procurement`, `area:regulatory`).

## Weekly cadence (30 min, Sunday)
1. Close what's done; move the BOM statuses along.
2. Pick the next 2–4 issues for the week.
3. Note any blockers (`blocked` label) and risks.

## Git workflow
- `main` is always in a consistent state.
- Small changes (docs, a checklist tweak) go straight to `main`.
- Bigger work goes on a branch per issue, e.g. `m1/motor-mount`, then a PR that references the issue (`Closes #12`) and gets merged.
- Commit messages say *what* and *why*. Parameter commits always say which flight or test motivated them.
- At the end of a milestone: report in `docs/test-reports/`, then the tag `mN-done`.

## Definition of done
An issue is done when its acceptance criterion is met **and** the evidence is in the repo (a file, plot, log, photo or report).
