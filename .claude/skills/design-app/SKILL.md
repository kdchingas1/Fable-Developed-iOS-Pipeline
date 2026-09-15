---
name: design-app
description: Stage 3. Produce user flows, a screen inventory, design tokens, onboarding and paywall design, and a HIG compliance checklist from the PRD. Use before any code is written.
argument-hint: <product-slug>
---

# /design-app — design the screens before building them

Working directory: `products/$0/03-design/`. Templates: `pipeline/03-design/templates/`.

## Procedure

1. **Flows** (`user-flows.md`): one flow per Must-have story from `02-define/user-stories.md`.
   Include empty, loading, error, and permission-denied states.
2. **Screen inventory** (`screen-inventory.md`): every screen, its navigation container,
   components, data it needs, and the ViewModel it maps to. This is the contract for Stage 4.
3. **Design tokens** (`design-tokens.md`): colors with dark variants, type scale on Dynamic
   Type styles, spacing, radii, iconography (SF Symbols first). Include the Swift `enum`
   sketch that `Sources/Core/DesignSystem/` will implement.
4. **Onboarding and paywall** (`onboarding-paywall.md`): first-run flow to first value in
   under 60 seconds; paywall placement, copy, plan display, restore purchases, and legal links.
5. **HIG checklist** (`hig-checklist.md`): complete it; each "no" needs a justification.
6. **App icon brief** (`app-icon-brief.md`): concept, 3 directions, constraints.
7. **Gate.** Complete `GATE.md`.

## Rules

- Delegate to `ux-designer`. Use the `design` skill if available to produce visual mockups
  of the 3 most important screens; otherwise describe them precisely in text.
- No screen without an empty and error state design.
- Match the pricing model from Stage 2 exactly in the paywall design.
