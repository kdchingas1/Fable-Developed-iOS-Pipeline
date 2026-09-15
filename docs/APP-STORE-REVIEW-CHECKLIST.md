# App Store Review pre-check

Answer every row with evidence before submitting. Guideline numbers refer to the
App Store Review Guidelines. Re-read the current guidelines on each release; they change.

| # | Guideline | Check | Evidence |
|---|-----------|-------|----------|
| 1 | 2.1 Completeness | No placeholder content, dead links, or crashes on launch on min and latest OS | |
| 2 | 2.1 | Demo account or instructions in review notes for any gated feature | |
| 3 | 2.3 Accurate metadata | Screenshots show the actual app; description matches features | |
| 4 | 2.3.8 | App name and subtitle contain no unrelated keywords or competitor names | |
| 5 | 2.5.1 | Only public APIs; no private API usage | |
| 6 | 2.5.4 | Background modes declared only if genuinely used | |
| 7 | 3.1.1 IAP | All digital goods use IAP; no external purchase links unless entitled | |
| 8 | 3.1.2 Subscriptions | Paywall shows price, duration, auto-renew terms, Terms and Privacy links; restore visible | |
| 9 | 3.1.2 | Free trial length and post-trial price stated clearly before purchase | |
| 10 | 4.0 Design | Follows HIG; no broken layouts at large Dynamic Type; dark mode works | |
| 11 | 4.2 Minimum functionality | App is more than a web view or a repackaged website | |
| 12 | 5.1.1 Privacy | Privacy policy URL live; matches nutrition labels; permission prompts explain purpose strings | |
| 13 | 5.1.1(v) | Account deletion available in-app if accounts exist | |
| 14 | 5.1.2 | App Tracking Transparency prompt shown before any tracking; none if no tracking | |
| 15 | 5.1.1 | Data collection limited to what the feature needs | |
| 16 | 1.2 / 1.4 | User-generated content has reporting and blocking if applicable | |
| 17 | Export compliance | `ITSAppUsesNonExemptEncryption` set correctly | |
| 18 | Age rating | Questionnaire answered accurately | |
| 19 | iPad | If iPad supported, all orientations and split view work; if not, iPhone-only is set | |
| 20 | Localization | Every launched locale has complete, non-machine-translated metadata | |

## Common rejection causes for indie apps
1. Paywall missing subscription terms or restore (3.1.2).
2. Login required with no demo account (2.1).
3. Metadata mentions Android, "beta", or other platforms (2.3).
4. Crash on iPad even though iPad is "supported" (2.1).
5. Privacy labels do not match SDK behavior (5.1.1).
