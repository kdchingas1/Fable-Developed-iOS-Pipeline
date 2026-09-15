# The pipeline, stage by stage

This document explains *why* each stage exists and what "good" looks like. The mechanics
(templates, gates, skills) live in `pipeline/` and `.claude/`.

## Philosophy

Most indie iOS apps fail before launch for one of three reasons: nobody wanted it, it took
too long to build, or nobody could find it. The pipeline attacks each one:

- **Stages 0 to 2** kill bad ideas in days, with evidence, before any code exists.
- **Stages 3 to 5** make the build predictable: a screen contract, a template with the
  boring parts done (purchases, onboarding, analytics, CI), and a fixed test procedure.
- **Stages 6 to 7** treat launch as the start of a measurement loop, not the finish line.

## Stage 0 — Discover

Find where demand, weak competition, and monetization overlap. The opportunity scorecard
forces a comparison between at least three candidates so the pick is relative, not
absolute. The riskiest assumption is named here so Stage 1 knows what to test.

Good output: a scorecard where the pick's evidence column has five or more source links and
the "why the others lost" section is convincing.

## Stage 1 — Validate

Spend the least money and time that can *kill* the idea. The test ladder is ordered by cost.
Claude produces the assets; the founder runs anything that requires money or conversations.
The go/no-go memo has one recommendation. "GO" without a met numeric threshold is a PIVOT.

## Stage 2 — Define

Write the PRD a developer reads once. Six Must-have stories maximum. Pricing is decided here
with concrete StoreKit product IDs because the paywall is designed in Stage 3 and built in
Stage 4. Naming is decided here because ASO depends on it and it takes time to confirm.

Stage 2 is re-entered for every post-launch increment, in `02-define/increments/<name>/`.

## Stage 3 — Design

The screen inventory is the contract. Every screen names its ViewModel, so Stage 4 has no
architectural decisions left. Empty, loading, and error states are designed for every fetch
because they are where apps feel cheap. The HIG checklist prevents the most common review
rejections (guideline 4.0 design, 2.1 completeness).

## Stage 4 — Build

Architecture first, then vertical slices. Slice 1 reaches TestFlight even if it is one screen,
because the signing, CI, and upload path is the riskiest technical step and should fail early.
The template ships with purchases, onboarding, settings, analytics events, a design token
enum, and tests, so engineering time goes into the product's core loop.

## Stage 5 — Test

QA is a separate stage with a separate agent so the person who wrote the code is not the
person deciding it is done. The App Review pre-check is answered with evidence, and a second
agent reads it adversarially as if it were App Review.

## Stage 6 — Launch

ASO and release mechanics run in parallel. Metadata is written straight into
`fastlane/metadata/` so uploading is one lane. External TestFlight runs for at least three
days. Phased release is on for v1.0 so a bad crash affects a fraction of users.

## Stage 7 — Grow

Weekly, one decision. Benchmarks in `docs/METRICS.md` say whether a number is good. If the
decision changes scope, it becomes an increment and goes through Stages 2 to 6 again in
miniature. Kill criteria exist so a dead app does not consume attention forever.

## Running it with Claude Code

```
claude
> /pipeline habit-tracker
```

`/pipeline` reads `products/habit-tracker/STATUS.md`, finds the first incomplete gate, runs
the matching stage skill, checks the gate, commits, and continues or stops. Each stage skill
can also be run alone. Research-heavy steps fan out to agents in `.claude/agents/`.
