# Legal and trademark guide

This is a practical checklist for an indie iOS studio, not legal advice. Laws change and
vary by country; anything marked **(lawyer)** is worth an hour of a real attorney's time
before launch. Templates referenced here live under `pipeline/`, the reviewer is the
`legal-reviewer` agent, and `/legal-check <slug>` runs the checks for the current stage.

## Where legal work happens in the pipeline

| Stage | Legal work | Artifact |
|-------|------------|----------|
| 0 Discover | Exclude regulated categories or price in the cost of compliance | `brief.md` exclusions |
| 2 Define | Trademark clearance on the name; decide entity and Apple account type | `trademark-clearance.md`, `naming.md` |
| 3 Design | Consent and permission UX, paywall disclosures, age gate if needed | `onboarding-paywall.md` |
| 4 Build | Privacy manifest, third-party license inventory, data handling | `licenses.md`, `PrivacyInfo.xcprivacy` |
| 5 Test | Verify disclosures and privacy labels match the binary | `app-review-precheck.md` |
| 6 Launch | Privacy policy, terms, App Store agreements, tax forms, EU trader info | `legal-checklist.md`, `privacy-policy.md`, `terms-of-service.md` |
| 7 Grow | Re-check when adding SDKs, data types, locales, or pricing changes | weekly review |

## 1. Trademark

**Why it matters:** a name conflict after launch means renaming the app, losing rankings and
reviews, and possibly a demand letter. Clearing the name costs an afternoon.

**Clearance procedure** (`pipeline/02-define/templates/trademark-clearance.md`):

1. **Exact and near matches on the App Store.** Search the name, plural, common misspellings,
   and the name with generic words removed. Apple rejects names that are confusingly similar
   to existing apps and will remove an app on a valid trademark complaint.
2. **Registered marks.** Search the USPTO trademark search system (Nice classes 9 and 42),
   EUIPO eSearch, and the WIPO Global Brand Database for every market you will sell in.
   A live registration in class 9 or 42 with a similar name and similar goods is a stop sign.
3. **Common-law use.** Web search the name plus "app", "software", and your category. An
   unregistered but earlier user can still have rights in the US.
4. **Domains and handles.** Check the `.app` and `.com` domains and the handles on the social
   networks you will use. Availability is a signal, not clearance.
5. **Apple's marks.** Do not put "iPhone", "iOS", "App Store", "Siri", or other Apple marks in
   the app name, subtitle, or icon. "for iPhone" is allowed in descriptive text only, per
   Apple's trademark guidelines.
6. **Decide:** clear, clear with a modifier (add a distinctive word), or reject. Record it.

**Registering your own mark (lawyer):** consider filing once the app has traction. A US
application in class 9 costs a few hundred dollars per class; it deters copycats and gives you
a fast path with the App Store's dispute process. Use the name consistently with a TM symbol
until registered.

## 2. Copyright and content

- **App icon and artwork:** must be original or licensed for commercial use. SF Symbols may
  not be used as or in an app icon or logo. Check the license of every font, illustration,
  sound, and stock photo; keep receipts in `products/<slug>/legal/licenses/`.
- **Third-party code:** every Swift package goes in `04-build/licenses.md` with its license.
  MIT, BSD, Apache 2.0 are fine. GPL and LGPL are not compatible with App Store distribution.
  Apache 2.0 and BSD require attribution: ship a licenses screen or a text file in Settings.
- **User-generated content:** if users can upload or share, you need a takedown contact and a
  DMCA agent registration in the US, plus in-app reporting and blocking (App Review 1.2).
- **Scraped or API data:** read the source's terms. Most prohibit commercial use or caching.

## 3. Privacy and data protection

- **Privacy manifest:** `PrivacyInfo.xcprivacy` is required. It declares tracking status,
  data types collected, and the reason codes for required-reason APIs (UserDefaults, file
  timestamps, system boot time, disk space, active keyboards). Third-party SDKs on Apple's list
  must ship their own manifests and signatures. The template includes a manifest for UserDefaults.
- **Privacy nutrition labels** in App Store Connect must match what the binary and its SDKs
  actually collect. Mismatches are a common rejection and a regulatory risk.
- **App Tracking Transparency:** any linking of user or device data with third-party data for
  advertising or measurement is tracking and requires the ATT prompt. First-party analytics
  with no cross-app or cross-company linking does not.
- **GDPR / UK GDPR** (EU and UK users): lawful basis for each data use, a privacy policy that
  names the controller, data subject rights, retention, and processors (your analytics and crash
  vendors). Non-essential analytics in the EU generally needs consent. Sign each vendor's Data
  Processing Agreement.
- **CCPA / CPRA** (California) and other US state laws: apply above revenue or user thresholds
  most indie apps do not hit at launch, but the privacy policy should still include the
  disclosures; it costs nothing.
- **Children:** if the app is directed at children under 13 (US COPPA) or under 16 (parts of
  the EU), or is in the Kids category, you need verifiable parental consent for data collection,
  no third-party analytics or ads without a compliant provider, and no external links without a
  parental gate. Simplest path: do not target children unless the product requires it. (lawyer)
- **Health data:** HealthKit data may not be used for advertising or sold; store it only on
  device or in iCloud unless the user explicitly consents. Avoid diagnostic or treatment claims;
  they can make the app a regulated medical device.
- **Account deletion:** if the app has accounts, in-app account deletion is mandatory (5.1.1(v)).
- **Data minimization:** collect nothing you do not use in a metric or feature. Every data
  type in the privacy labels needs a reason you can state in one sentence.

## 4. Terms, subscriptions, and consumer law

- **EULA:** Apple's standard EULA applies by default and is enough for most apps. A custom EULA
  is needed only for unusual terms; it must be at least as protective of users as Apple's.
- **Terms of service:** needed if you have accounts, UGC, or a service component. Template in
  `pipeline/06-launch/templates/terms-of-service.md`.
- **Subscription disclosures** on the paywall and in metadata: price, billing period, what is
  included, that it auto-renews, how to cancel, and links to terms and privacy policy. Free
  trials must state the length and the price after. This is both App Review 3.1.2 and consumer
  law in many jurisdictions (for example California's auto-renewal law and EU consumer rights).
- **Refunds:** Apple handles them; do not promise refunds you cannot issue. Point users to
  Apple's refund process in Settings and support docs.
- **Pricing changes:** subscription price increases require notice and, above thresholds, opt-in
  consent handled by Apple; plan them in Stage 7, never silently.
- **Marketing claims:** "best", "#1", "guaranteed" need substantiation. Testimonials must be real.

## 5. Business, Apple agreements, and tax

- **Entity (lawyer or accountant):** a sole proprietorship is fine to start. An LLC or
  equivalent limits liability and lets you enroll as an Organization, which shows a company
  name on the App Store instead of your personal name. Organization enrollment needs a D-U-N-S
  number and a legal entity that matches it.
- **Apple Developer Program License Agreement** and the **Paid Applications Agreement** must be
  accepted by the Account Holder in App Store Connect before paid apps or IAP work. Renewals
  and updates to these agreements block releases until accepted.
- **Tax and banking:** complete the tax forms (W-9 in the US, W-8BEN or W-8BEN-E elsewhere) and
  banking info in App Store Connect. Apple collects and remits VAT and sales tax in most
  territories; you still owe income tax on proceeds.
- **EU Digital Services Act:** to distribute in the EU you must declare trader or non-trader
  status; traders must provide a verified address, phone, and email that Apple displays on the
  product page. Anyone selling IAP is a trader.
- **EU Accessibility Act:** from mid-2025, certain consumer-facing digital services sold in the
  EU must meet accessibility requirements; the Stage 5 accessibility audit is your evidence.
- **Export compliance:** if the app uses only Apple's standard encryption (HTTPS, CryptoKit) set
  `ITSAppUsesNonExemptEncryption` to `NO`. Custom or proprietary encryption needs an ERN or
  self-classification report. (lawyer if custom crypto)
- **Age rating:** answer the questionnaire honestly; understating gets apps removed.
- **Insurance:** general and professional liability insurance is cheap once revenue exists and
  is worth it if the app touches health, finance, or safety.

## 6. When to pay a lawyer

An hour with an app-savvy attorney before launch is worth it if any of these are true:
children are a target audience; the app touches health, finance, location tracking, or
biometrics; you use a custom EULA; the trademark search found anything borderline; you have
a co-founder or contractor (get IP assignment agreements signed); or you are raising money.
