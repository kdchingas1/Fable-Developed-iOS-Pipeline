---
name: validate
description: Stage 1. Test demand for the chosen opportunity cheaply before building. Use after /discover to decide go or no-go with evidence.
argument-hint: <product-slug>
---

# /validate — prove someone wants this before building it

Working directory: `products/$0/01-validate/`. Templates: `pipeline/01-validate/templates/`.

## Procedure

1. **Hypotheses.** Copy `hypotheses.md`. Write the value hypothesis, the growth hypothesis,
   and the monetization hypothesis. Each is falsifiable with a numeric threshold, for example:
   "At least 5% of landing page visitors from r/<sub> join the waitlist."
2. **Pick the cheapest killing test** for the riskiest hypothesis. Options, cheapest first:
   - Review mining: quantify how many recent reviews of competitors ask for our angle.
   - Community post: describe the app in a relevant subreddit or Discord; measure replies and DMs.
   - Landing page smoke test: one page, one CTA (waitlist or "pre-order $X"), a small ad spend or organic post. Template: `landing-page-test.md`.
   - Customer interviews: 5 people who use a competitor. Script: `interview-script.md`.
   - Clickable prototype: only if the interaction itself is the risk.
3. **Run it.** Where Claude cannot run the test (spending money, talking to people), produce
   the exact assets (page copy, post text, interview script, ad copy) and a run sheet, then
   stop and ask the founder to run it and paste results.
4. **Decide.** Fill `go-no-go.md`: evidence per hypothesis, threshold met or not, one
   recommendation (GO, PIVOT with a specific new angle, or KILL). Pivots go back to Stage 0
   with the new angle recorded.
5. **Gate.** Complete `GATE.md`.

## Rules

- A GO with no numeric evidence is not a GO. Write PIVOT or KILL instead.
- Record willingness-to-pay signals verbatim; they feed Stage 2 pricing.
