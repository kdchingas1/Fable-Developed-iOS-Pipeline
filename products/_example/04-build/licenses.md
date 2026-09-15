# Third-party licenses and privacy manifest — Example App

## Dependencies

| Package / SDK | Version | License | Attribution required? | Apple privacy-manifest list? | Manifest + signature present? | Data it collects |
|---------------|---------|---------|-----------------------|------------------------------|-------------------------------|------------------|

Rejected (GPL/LGPL or incompatible terms):
| Package | Reason | Alternative |
|---------|--------|-------------|

## Assets
| Asset | Source | License | Receipt / proof |
|-------|--------|---------|-----------------|
| App icon | | | |
| Fonts | | | |
| Illustrations / photos | | | |
| Sounds | | | |

## Privacy manifest review (`Sources/App/PrivacyInfo.xcprivacy`)
| Item | Value in manifest | Matches code? | Note |
|------|-------------------|---------------|------|
| NSPrivacyTracking | false | | |
| Tracking domains | none | | |
| Required-reason APIs | UserDefaults CA92.1 | | add others as used |
| Collected data types | | | must match App Store privacy labels |

## Attributions screen
<Present in Settings? Which licenses are listed?>
