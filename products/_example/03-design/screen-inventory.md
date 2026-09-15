# Screen inventory — Example App

| Screen | Purpose | Container | Parent | Components | Data needed | ViewModel |
|--------|---------|-----------|--------|------------|-------------|-----------|
| Home | | NavigationStack root / Tab 1 | — | List, toolbar button | | HomeViewModel |
| Detail | | push | Home | | | DetailViewModel |
| Paywall | | sheet | any | plan cards, CTA, restore, legal | products | PaywallViewModel |
| Settings | | Tab N | — | Form | | SettingsViewModel |
| Onboarding | | fullScreenCover | root (first run) | pages, permission prompts | | OnboardingViewModel |
