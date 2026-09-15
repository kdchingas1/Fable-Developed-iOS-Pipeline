# Fable-Developed iOS Pipeline

A Claude Code project that runs the **entire lifecycle of an iOS app** as a repeatable,
stage-gated pipeline: from spotting a market opportunity, through validation, product
definition, design, build, test, App Store launch, and post-launch growth.

The repository is a *factory*, not a single app. Each app idea becomes a **product** under
`products/<slug>/` and moves through eight numbered stages. Every stage has:

- a **skill** (`/discover`, `/validate`, ...) that Claude runs to do the work,
- a **specialist agent** with the right tools and persona,
- **templates** for the artifacts that stage must produce,
- a **gate checklist** that must pass before the next stage begins.

```
 0 Discover ─▶ 1 Validate ─▶ 2 Define ─▶ 3 Design ─▶ 4 Build ─▶ 5 Test ─▶ 6 Launch ─▶ 7 Grow
 market scan   demand test    PRD/MVP     UX + HIG    SwiftUI    QA/perf   ASO/TestFlight  analytics
 competitors   go/no-go       pricing     flows       CI/CD      review    App Store       retention
 scorecard     interviews     stories     tokens      fastlane   readiness release        iterate ▶ loop
```

## Quick start

```bash
# 1. Install tooling (macOS): xcodegen, swiftlint, swiftformat, fastlane
./scripts/bootstrap.sh

# 2. Start a new product and run the pipeline with Claude Code
./scripts/new-product.sh "habit-tracker" "Habit Tracker"
claude
> /pipeline habit-tracker            # orchestrates all stages with gates
> /discover habit-tracker            # or run one stage at a time

# 3. Build the app template locally
cd app && xcodegen generate && xcodebuild -scheme App -destination 'platform=iOS Simulator,name=iPhone 16' test
```

## Layout

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Operating rules Claude follows in this repo |
| `.claude/skills/` | One skill per pipeline stage plus `/pipeline` orchestrator |
| `.claude/agents/` | Specialist subagents (market researcher, iOS architect, ASO specialist, ...) |
| `pipeline/` | Stage definitions, templates, and gate checklists |
| `products/` | One directory per app moving through the pipeline |
| `app/` | Production-grade SwiftUI app template (XcodeGen, MVVM, tests, lint) |
| `fastlane/` | Lanes for test, TestFlight beta, screenshots, and App Store release |
| `.github/workflows/` | CI on every PR, TestFlight on `beta-*` tags, App Store on `v*` tags |
| `scripts/` | Bootstrap, new-product, and gate-check helpers |
| `docs/` | Pipeline deep-dive, architecture, metrics, App Store review checklist, legal and trademark guide |

## Principles

1. **Kill early, kill cheap.** Stages 0 to 2 cost hours, not weeks. Most ideas should die there.
2. **Evidence over opinion.** Every gate asks for numbers: search volume, competitor ratings, conversion on a smoke test.
3. **One product per directory.** Everything about an app lives under `products/<slug>/` so context is never lost.
4. **Ship small, ship often.** The template ships to TestFlight from day one of Stage 4.
5. **The pipeline loops.** Stage 7 feeds back into Stage 2 with real usage data.
6. **Legal is a stage input, not an afterthought.** Trademark clearance before the name is final, license and privacy-manifest review before TestFlight, the legal checklist before submission. `/legal-check` runs it; `docs/LEGAL.md` explains it.

See [`docs/PIPELINE.md`](docs/PIPELINE.md) for the full stage-by-stage guide.
