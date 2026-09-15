---
name: grow
description: Stage 7. Weekly post-launch review of acquisition, activation, retention, revenue, and quality, ending in one prioritized decision. Use weekly after launch, or when asked "how is <app> doing".
argument-hint: <product-slug> [YYYY-WW]
---

# /grow — measure, learn, and decide what to build next

Working directory: `products/$0/07-grow/`. Templates: `pipeline/07-grow/templates/`.

## Procedure

1. **Collect.** Ask the founder for (or read from `07-grow/data/`) the week's App Store
   Connect analytics export, subscription report, crash-free rate, and new reviews.
2. **Review.** Invoke `growth-analyst` to fill `reviews/<YYYY-WW>.md` from
   `weekly-review.md`: funnel, retention curve vs benchmarks, revenue, quality, review themes.
3. **Experiments.** Update `experiments.md`: results of running experiments, and the one new
   experiment to start (hypothesis, metric, MDE, duration).
4. **Decide.** Write the single highest-leverage decision for next week. If it changes scope,
   create `02-define/increments/<name>/` and invoke `/define` for it, then `/build`.
5. **Housekeeping.** Reply to reviews needing a response; update `CHANGELOG.md`; refresh
   keywords if ranking dropped.

## Rules

- One decision per week. Many small experiments beat one big rewrite.
- Kill criteria: if after 8 weeks D30 retention and conversion are both under half the
  benchmark with no upward trend, write a sunset or pivot recommendation.
