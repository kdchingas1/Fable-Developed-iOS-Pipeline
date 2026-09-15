---
name: define
description: Stage 2. Write the PRD, MVP scope, user stories, and pricing model for a validated idea. Use after a GO decision or when Stage 7 loops back with a new increment.
argument-hint: <product-slug> [increment-name]
---

# /define — turn a validated idea into a buildable spec

Working directory: `products/$0/02-define/`. Templates: `pipeline/02-define/templates/`.
For a post-launch increment, write to `02-define/increments/<name>/` instead.

## Procedure

1. **PRD** (`PRD.md`): problem, target user (one primary persona), job to be done, why now,
   success metrics for v1 (activation, D7 retention, conversion targets from `docs/METRICS.md`),
   non-goals, risks. Every "why" cites Stage 0 or 1 evidence.
2. **User stories** (`user-stories.md`): 8 to 20 stories with acceptance criteria and a
   MoSCoW priority. Include onboarding, the core loop, purchase, and settings/privacy.
3. **MVP scope** (`mvp-scope.md`): the Must-haves only. Then the explicit "not in v1" list
   with a reason for each cut. Estimate build effort per story (S/M/L) using the template's
   feature-module model.
4. **Pricing** (`pricing.md`): choose one model, set the price, define the free tier or trial,
   list the StoreKit products (product IDs, type, duration, price tier) that Stage 6 will create.
5. **Name candidates** (`naming.md`): 5 to 10 names with App Store, domain, and social handle
   availability. Run `/legal-check $0 2` to produce `trademark-clearance.md`; only CLEAR names
   go to the founder. Record the pick in `STATUS.md`.
6. **Gate.** Complete `GATE.md`.

## Rules

- If the MVP has more than 6 Must-have stories, cut until it does not, or split into v1 and v1.1.
- Use `product-strategist` for drafting and a fresh agent to critique the PRD against the evidence.
