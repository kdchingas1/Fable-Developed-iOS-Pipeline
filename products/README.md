# Products

One directory per app. Create with `./scripts/new-product.sh <slug> "<Name>"`.

`_example/` shows the structure that script creates: stage folders `00-discover` through
`07-grow`, each with its templates and `GATE.md`, plus `STATUS.md`, `CHANGELOG.md`, and a
copy of the app template under `04-build/app/`.

Product directories that start with `_` are ignored by CI path filters.
