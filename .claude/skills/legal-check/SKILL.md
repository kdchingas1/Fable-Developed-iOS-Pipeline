---
name: legal-check
description: Cross-cutting legal, trademark, privacy, and compliance check for the product's current stage. Use at Stage 2 (trademark clearance), Stage 4 (licenses and privacy manifest), Stage 6 (launch legal checklist, privacy policy, terms), or whenever asked about legal, trademark, privacy, GDPR, COPPA, or licensing.
argument-hint: <product-slug> [2|4|6]
---

# /legal-check — run the legal work for the current stage

Reference: `docs/LEGAL.md`. Delegate to `legal-reviewer`. Stage defaults to the product's
current stage from `products/$0/STATUS.md`; only stages 2, 4, and 6 have legal work.

## Stage 2 — Trademark clearance

1. For every name in `02-define/naming.md`, complete `02-define/trademark-clearance.md`
   (copied from the template by `new-product.sh`).
2. Update `naming.md` so only CLEAR or CLEAR WITH MODIFIER names remain candidates.
3. Note the entity decision (individual vs organization enrollment) in `STATUS.md`.

## Stage 4 — Licenses and privacy manifest

1. Complete `04-build/licenses.md` from `Package.resolved` and `project.yml` dependencies.
2. Review `04-build/app/Sources/App/PrivacyInfo.xcprivacy` against the code and the
   analytics events actually sent. Fix the manifest, not the checklist.
3. If any license requires attribution, add an attributions entry to Settings.

## Stage 6 — Launch legal checklist

1. Complete `06-launch/legal-checklist.md`.
2. Draft `06-launch/privacy-policy.md` and, when accounts, UGC, or a service exist,
   `06-launch/terms-of-service.md`. The founder publishes them at the URLs used in
   `fastlane/metadata/<locale>/privacy_url.txt` and in the app's `Links.swift`.
3. Verify the paywall copy in the build matches the subscription disclosure requirements.
4. List "needs lawyer" items at the top of the checklist.

## Rules

- This skill never marks a stage gate on its own; it produces the evidence the gate cites.
- If a check finds a blocking issue (for example a live trademark conflict), write it into
  `STATUS.md` under decisions and stop so the founder can decide.
