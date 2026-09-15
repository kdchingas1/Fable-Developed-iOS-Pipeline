---
name: launch
description: Stage 6. App Store Optimization, App Store Connect setup, TestFlight beta, submission, and release. Use when Stage 5 returns GO.
argument-hint: <product-slug>
---

# /launch — get the app live on the App Store

Working directory: `products/$0/06-launch/`. Templates: `pipeline/06-launch/templates/`.

## Procedure

1. **ASO.** Invoke `aso-specialist`: `keyword-research.md`, then write metadata into
   `fastlane/metadata/<locale>/` (name, subtitle, keywords, description, promotional_text,
   release_notes) and `screenshot-storyboard.md`.
2. **Screenshots.** Generate with `bundle exec fastlane screenshots` (uses the UI test
   `ScreenshotTests`) and frame per the storyboard.
3. **App Store Connect.** Invoke `release-manager` to complete `asc-setup.md`: app record,
   privacy labels, age rating, IAP products from `02-define/pricing.md`, review notes with demo
   account, export compliance.
4. **Beta.** `bundle exec fastlane beta` to an external TestFlight group; collect feedback
   for at least 3 days; fix P0/P1 via `/build`.
5. **Submit.** Tag `v<version>`; the `release.yml` workflow runs `fastlane release` with
   phased release on. Record submission date in `RELEASE.md`.
6. **Review.** If rejected, follow the `release-manager` rejection procedure; log each round
   in `RELEASE.md`.
7. **Launch day** (`launch-checklist.md`): press kit, Product Hunt/Reddit posts, social,
   review prompt enabled, analytics dashboards verified.
8. **Gate.** `RELEASE.md` has the live App Store URL. Complete `GATE.md`.

## Rules

- Metadata must be accurate to the build. No feature in screenshots that is not in the app.
- Secrets never enter the repo; verify `git diff` before every commit.
