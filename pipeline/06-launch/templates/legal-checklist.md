# Launch legal checklist — <Product>

Not legal advice. Items marked (lawyer) need an attorney if answered "unsure".

## Needs a lawyer before launch
- <none | list>

## Trademark and brand
- [ ] `02-define/trademark-clearance.md` verdict is CLEAR for the final name
- [ ] Name, subtitle, icon contain no Apple marks or third-party brands
- [ ] Domain and handles registered to the entity that owns the app

## Entity and Apple agreements
- [ ] Developer account type decided (Individual | Organization with D-U-N-S)
- [ ] Developer Program License Agreement accepted (current version)
- [ ] Paid Applications Agreement accepted; banking and tax forms complete
- [ ] EU Digital Services Act trader status declared with verified contact details
- [ ] Contractors and co-founders have signed IP assignment (lawyer)

## Privacy
- [ ] Privacy policy published at the URL in `fastlane/metadata/<locale>/privacy_url.txt` and `Links.swift`
- [ ] Privacy policy names the controller, data types, purposes, retention, processors, user rights, contact
- [ ] App Store privacy labels match `04-build/licenses.md` data inventory
- [ ] `PrivacyInfo.xcprivacy` reviewed; SDK manifests and signatures present
- [ ] ATT prompt implemented if tracking; otherwise no tracking SDK configured
- [ ] Consent for non-essential analytics in EU/UK handled (or analytics is essential-only)
- [ ] Data Processing Agreements signed with analytics, crash, and backend vendors
- [ ] Account deletion in-app if accounts exist
- [ ] Children: not targeted, or COPPA/GDPR-K measures in place (lawyer)
- [ ] Health / financial / location / biometric data: purpose strings, on-device storage, no ad use (lawyer)

## Terms and purchases
- [ ] Apple standard EULA, or custom EULA reviewed and uploaded (lawyer)
- [ ] Terms of service published if accounts, UGC, or service exist
- [ ] Paywall shows price, period, auto-renewal, trial length and post-trial price, cancel path, Terms and Privacy links
- [ ] Metadata description repeats subscription terms
- [ ] No unsubstantiated claims ("best", "#1", "guaranteed") in metadata or app
- [ ] Support URL live and monitored

## Content and IP
- [ ] All fonts, icons, images, sounds licensed for commercial use with receipts filed
- [ ] Attribution screen present for licenses that require it
- [ ] UGC: reporting, blocking, takedown contact, DMCA agent registered (if applicable)
- [ ] Third-party data sources' terms permit this use

## Compliance settings
- [ ] Export compliance answered; `ITSAppUsesNonExemptEncryption` correct
- [ ] Age rating questionnaire accurate
- [ ] Accessibility audit passed (EU Accessibility Act evidence)
