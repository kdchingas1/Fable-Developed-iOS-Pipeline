# Stage 4 — Build

**Question:** Does it work end to end on TestFlight, with tests and CI green?

**Inputs:** screen inventory, tokens, pricing products.
**Outputs:** `ARCHITECTURE.md`, `app/` (from the template), `BUILD.md`, TestFlight builds.
**Who:** `/build` with `ios-architect` then `swift-engineer` agents per slice.
**Duration:** 2 to 6 weeks.

Slice 1 always goes to TestFlight, even if it is one screen. Everything after is incremental.
