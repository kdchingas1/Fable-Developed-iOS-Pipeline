# App Store metadata

`fastlane deliver` reads this directory. One folder per locale (`en-US`, `de-DE`, ...).

| File | Limit |
|------|-------|
| name.txt | 30 chars |
| subtitle.txt | 30 chars |
| keywords.txt | 100 chars, comma-separated, no spaces |
| promotional_text.txt | 170 chars |
| description.txt | 4000 chars |
| release_notes.txt | 4000 chars |

Run `./scripts/metadata-lint.sh` to check limits before uploading.
