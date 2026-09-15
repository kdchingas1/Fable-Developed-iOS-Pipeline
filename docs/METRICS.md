# Metrics and benchmarks

Every product tracks these. Targets are set in the PRD; benchmarks below are rough
indie-app medians and should be replaced with category-specific numbers found in Stage 0.

## Required analytics events

| Event | When | Why |
|-------|------|-----|
| `app_opened` | every foreground | sessions, DAU |
| `onboarding_completed` | last onboarding step or skip | onboarding drop-off |
| `activated` | first time the user reaches the product's "first value" moment (defined in PRD) | activation rate |
| `core_action_completed` | every core loop completion | engagement depth |
| `paywall_viewed` | paywall appears | paywall reach |
| `purchase_started` / `purchase_completed` / `purchase_failed` | StoreKit flow | conversion, failures |
| `restore_completed` | restore tapped | support signal |

## Funnel

Impressions → Product page views → Downloads → Onboarding completed → Activated → Paywall viewed → Trial → Paid → Retained

## Benchmarks (replace per category)

| Metric | Weak | OK | Strong |
|--------|------|----|--------|
| Product page conversion | < 15% | 15 to 30% | > 30% |
| Onboarding completion | < 60% | 60 to 80% | > 80% |
| Activation (install → first value) | < 30% | 30 to 50% | > 50% |
| D1 retention | < 20% | 20 to 35% | > 35% |
| D7 retention | < 8% | 8 to 15% | > 15% |
| D30 retention | < 3% | 3 to 8% | > 8% |
| Install → trial | < 3% | 3 to 8% | > 8% |
| Trial → paid | < 25% | 25 to 45% | > 45% |
| Paid app install → purchase (freemium) | < 1% | 1 to 3% | > 3% |
| Crash-free sessions | < 99% | 99 to 99.7% | > 99.7% |
| Rating | < 4.3 | 4.3 to 4.6 | > 4.6 |

## Kill criteria

After 8 weeks live: D30 retention and conversion both under half of "OK" with no upward trend
in the last 4 weekly reviews → write a sunset or pivot recommendation in Stage 7.

## Sources of truth

- App Store Connect → Analytics (acquisition, retention, conversion)
- App Store Connect → Sales and Trends, or RevenueCat/Glassfy dashboards if used
- Xcode Organizer or crash vendor (crash-free rate)
- Your analytics vendor (activation, core action, paywall funnel)
