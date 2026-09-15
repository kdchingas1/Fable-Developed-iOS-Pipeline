---
name: pipeline
description: Orchestrate the full iOS app pipeline for one product, stage by stage with gate checks. Use when asked to "run the pipeline", "take <idea> end to end", or to resume a product from wherever it stopped.
argument-hint: <product-slug> [--from N] [--to N]
---

# /pipeline — run the stage-gated iOS app pipeline

Arguments: `$ARGUMENTS` → `<slug>` plus optional `--from N` and `--to N` (default 0 to 7).

## Procedure

1. If `products/<slug>/` does not exist, run `./scripts/new-product.sh <slug> "<Display Name>"`
   (ask for the display name only if it cannot be derived from the slug).
2. Read `products/<slug>/STATUS.md`. Determine the current stage: the first stage whose
   `GATE.md` is not fully checked. If `--from` is given, start there instead.
3. For each stage N from start to end:
   a. Announce: "Stage N: <name> for <slug>".
   b. Invoke the stage skill (`/discover`, `/validate`, `/define`, `/design-app`, `/build`,
      `/test-app`, `/launch`, `/grow`) with the slug.
   c. Run `./scripts/gate-check.sh <slug> N`.
   d. If the gate passes, update `STATUS.md` (stage, date, one-line summary) and commit
      with `stage<N>(<slug>): pass gate`. Push the branch.
   e. If the gate fails, list the unchecked items and stop. Do not continue.
   f. If the stage produced a founder decision (kill, pivot, pricing, name), stop and surface it.
4. Stage 7 never "passes"; it produces a weekly review and either loops to Stage 2 with a
   scoped increment or stops.

## Stage map

| N | Name | Skill | Gate artifact |
|---|------|-------|---------------|
| 0 | Discover | `/discover` | `00-discover/opportunity-scorecard.md` |
| 1 | Validate | `/validate` | `01-validate/go-no-go.md` |
| 2 | Define | `/define` | `02-define/PRD.md`, `mvp-scope.md`, `pricing.md` |
| 3 | Design | `/design-app` | `03-design/screen-inventory.md`, `hig-checklist.md` |
| 4 | Build | `/build` | green CI + TestFlight build number in `04-build/BUILD.md` |
| 5 | Test | `/test-app` | `05-test/test-report.md` with GO verdict |
| 6 | Launch | `/launch` | `06-launch/RELEASE.md` with App Store URL |
| 7 | Grow | `/grow` | `07-grow/reviews/<week>.md` |

## Rules

- One product per invocation.
- Never skip a gate. Never mark a gate item checked without the evidence file existing.
- Keep the user informed with one line per stage; put detail in the artifacts.
