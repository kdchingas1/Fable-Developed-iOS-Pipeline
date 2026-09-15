# Performance — Example App build <N>

| Metric | Target | Measured | Tool |
|--------|--------|----------|------|
| Cold launch to first frame | < 1.0 s | | Instruments App Launch |
| Memory on heaviest screen | < 150 MB | | Xcode Memory gauge |
| Scroll hitches on main list | 0 | | Instruments Animation Hitches |
| Download size | < 50 MB | | App Store Connect / thinning report |
| Network: no polling, backoff on failure | | | proxy log |
| Energy: no background CPU unless feature requires | | | Energy gauge |
