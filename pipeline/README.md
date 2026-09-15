# Pipeline stages

Each stage directory contains:

- `README.md` — purpose, inputs, outputs, who does the work, typical duration
- `templates/` — artifact templates copied into `products/<slug>/<stage>/`
- `GATE.md` — the checklist that must be fully checked to advance

Stages are numbered so directory listings read in pipeline order. `scripts/new-product.sh`
copies this structure into a product folder. `scripts/gate-check.sh` verifies a gate.

| Stage | Question it answers | Typical duration |
|-------|---------------------|------------------|
| 00-discover | Where is there money and unmet need on the App Store? | 1 to 3 days |
| 01-validate | Will people in that market want *this*? | 3 to 10 days |
| 02-define | What exactly are we building for v1, and how does it make money? | 1 to 2 days |
| 03-design | What does every screen look like and do? | 2 to 5 days |
| 04-build | Does it work, end to end, on TestFlight? | 2 to 6 weeks |
| 05-test | Is it ready for strangers and for App Review? | 2 to 5 days |
| 06-launch | Is it live and findable? | 1 to 2 weeks incl. review |
| 07-grow | Is it working, and what next? | weekly, ongoing |
