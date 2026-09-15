# CLAUDE.md — iOS App Pipeline

This repository is a stage-gated factory for iOS apps. You (Claude) drive apps through the
pipeline. Read this file before doing any work here.

## What lives where

- `products/<slug>/` — everything about one app. Stage folders `00-discover` ... `07-grow`
  hold that product's artifacts. **Never write product artifacts anywhere else.**
- `pipeline/<NN-stage>/` — stage definition (`README.md`), `templates/`, and `GATE.md`.
  These are read-only references; copy templates into the product folder, do not edit them
  for a single product.
- `app/` — the SwiftUI template. When a product enters Stage 4, copy it to
  `products/<slug>/04-build/app/` (`scripts/new-product.sh` does this) and build there.
- `.claude/skills/` — one skill per stage. Skills are the *procedure*; agents are the *people*.
- `.claude/agents/` — specialist subagents. Delegate to them for research-heavy or
  parallelizable work.

## The stage gate rule

A product may only enter stage N+1 when `products/<slug>/<stage N>/GATE.md` has every box
checked and the evidence links resolve. Run `./scripts/gate-check.sh <slug> <N>` to verify.
If a gate fails, say so plainly and stop. Do not "provisionally" continue.

Stages and the skill that runs each one:

| # | Stage | Skill | Primary agent | Output that gates the next stage |
|---|-------|-------|---------------|----------------------------------|
| 0 | Discover | `/discover` | market-researcher | Opportunity scorecard with a top pick |
| 1 | Validate | `/validate` | product-strategist | Go/no-go memo with demand evidence |
| 2 | Define | `/define` | product-strategist | PRD, MVP scope, pricing model |
| 3 | Design | `/design-app` | ux-designer | Flows, screen inventory, HIG checklist |
| 4 | Build | `/build` | ios-architect, swift-engineer | Green CI, TestFlight build |
| 5 | Test | `/test-app` | qa-engineer | Test report, release readiness |
| 6 | Launch | `/launch` | aso-specialist, release-manager | Live on App Store |
| 7 | Grow | `/grow` | growth-analyst | Weekly metrics review, next iteration |

`/pipeline <slug>` orchestrates all of them in order and stops at the first failing gate.

## Engineering conventions (Stage 4+)

- Swift 6 language mode, strict concurrency. SwiftUI only; UIKit only via `UIViewRepresentable` when unavoidable.
- Architecture: feature modules under `Sources/Features/<Feature>/` with `View`, `ViewModel`
  (`@Observable`), and `Service` protocol. Dependencies are injected through `AppEnvironment`.
- Minimum deployment target is set in `app/project.yml` (`IOS_DEPLOYMENT_TARGET`). Do not
  lower it without updating `docs/ARCHITECTURE.md`.
- Every feature ships with a unit test for its ViewModel. UI tests cover the golden path only.
- Run before every commit: `swiftformat . && swiftlint --strict && xcodebuild test ...`
  (the `/build` skill has the exact command). CI runs the same.
- Never commit secrets. App Store Connect API keys, Match passwords, and analytics keys come
  from environment variables listed in `fastlane/.env.example`.
- Commit messages: `<stage>(<slug>): <imperative summary>`, e.g. `build(habit-tracker): add streak view`.

## Research conventions (Stages 0 to 2, 6, 7)

- Cite sources. Every market claim in a scorecard links to where the number came from
  (App Store listing, Sensor Tower/Appfigures estimate, Google Trends, Reddit thread, survey).
- Prefer ranges and confidence levels to false precision.
- When you cannot find evidence, write "unknown" and add it to the risks list. Do not guess.
- Competitor teardowns must include: pricing, rating, review count, top 3 complaints from
  1-star reviews, top 3 praises from 5-star reviews, last update date.

## How to behave

- Start each session by reading `products/<slug>/STATUS.md` for the product you are working on.
  Update it when you finish a stage or make a decision.
- Prefer the stage skill over improvising. If a skill is missing something, improve the skill.
- Use subagents for parallel research (for example three competitor teardowns at once).
- When a decision is genuinely the founder's (pricing tier, app name, whether to kill an
  idea), record the recommendation and options in the relevant artifact and stop.
- Do not create pull requests unless asked. Do push the working branch after each stage.
