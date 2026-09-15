---
name: test-app
description: Stage 5. Execute the test plan, accessibility and performance audits, and the App Store Review pre-check, ending with a release readiness verdict.
argument-hint: <product-slug>
---

# /test-app — decide whether this build is ready for the public

Working directory: `products/$0/05-test/`. Templates: `pipeline/05-test/templates/`.

## Procedure

1. **Automated suite.** Run unit and UI tests on the minimum and latest supported OS
   simulators. Record results and coverage in `test-report.md`.
2. **Test plan.** Copy `test-plan.md`; one row per user story with device matrix
   (smallest iPhone, largest iPhone, iPad if supported). Execute or, if no macOS, hand the
   plan to the founder with exact steps and collect results.
3. **Accessibility audit** (`accessibility-audit.md`): VoiceOver golden path, Dynamic Type
   at AX5, contrast, Reduce Motion, Bold Text.
4. **Performance** (`performance.md`): cold launch, memory on heaviest screen, scroll
   performance, network and battery hygiene, app size.
5. **App Review pre-check** (`app-review-precheck.md`): every item in
   `docs/APP-STORE-REVIEW-CHECKLIST.md` answered with evidence.
6. **Bugs.** File each in `bugs.md` with severity. P0 and P1 go back to `/build`.
7. **Verdict** at the top of `test-report.md`: GO, GO WITH P1 FIXES, or NO GO.
8. **Gate.** Complete `GATE.md` only on GO.

## Rules

- Delegate to `qa-engineer`. Use a second agent to review the pre-check adversarially as
  if it were App Review.
- Do not mark a test passed that you did not run or see evidence for.
