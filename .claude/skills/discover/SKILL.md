---
name: discover
description: Stage 0. Identify and score iOS app market opportunities. Use when starting a new product, exploring a category, or asked "what app should I build".
argument-hint: <product-slug> [category or theme]
---

# /discover — find a market worth entering

Working directory: `products/$0/00-discover/`. Templates: `pipeline/00-discover/templates/`.

## Procedure

1. **Frame the search.** Write `brief.md`: the theme or category, the founder's constraints
   (solo dev? budget? existing audience? skills?), and the exclusion list (regulated
   categories, anything Apple ships natively, anything needing a backend team).
2. **Scan the market.** Copy `market-scan.md` and fill it. Spawn `market-researcher` agents
   in parallel, one per sub-category (3 to 5). Each returns: top 10 apps, rating/review
   distribution, pricing models in use, update cadence, and evidence of unmet needs.
3. **Tear down competitors.** For the 3 to 6 most relevant apps, copy
   `competitor-teardown.md` per app into `competitors/`. Parallelize with agents.
4. **Score opportunities.** Fill `opportunity-scorecard.md`. Score each candidate 1 to 5 on:
   demand evidence, competition weakness, monetization clarity, buildability by this team,
   platform tailwind (new iOS API, Apple feature potential), and defensibility. Weight and
   rank. Pick one. Write why the runners-up lost.
5. **Gate.** Complete `GATE.md`. Every claim links to a source.

## Output checklist

- `brief.md`, `market-scan.md`, `competitors/*.md`, `opportunity-scorecard.md`, `GATE.md`
- `STATUS.md` updated with the chosen opportunity in one sentence.

## Heuristics for a good pick

- Category has apps with 1k+ ratings averaging under 4.3 stars, so demand exists and quality is beatable.
- Users describe the job in their own words in reviews ("I just want to ...").
- A clear paid or subscription model already works in the category.
- Buildable to TestFlight in under 4 weeks by one engineer with this template.
