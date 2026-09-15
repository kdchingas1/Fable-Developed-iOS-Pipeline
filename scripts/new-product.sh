#!/usr/bin/env bash
# Create products/<slug>/ with every stage folder, gate, and a copy of the app template.
# Usage: ./scripts/new-product.sh <slug> "<Display Name>" [bundle-id-prefix]
set -euo pipefail

SLUG="${1:-}"; NAME="${2:-}"; PREFIX="${3:-com.example}"
[[ -n "$SLUG" && -n "$NAME" ]] || { echo "usage: $0 <slug> \"<Display Name>\" [bundle-id-prefix]" >&2; exit 1; }
[[ "$SLUG" =~ ^_?[a-z0-9-]+$ ]] || { echo "slug must be lowercase letters, digits, and hyphens (leading _ marks an example)" >&2; exit 1; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/products/$SLUG"
[[ -e "$DEST" ]] && { echo "products/$SLUG already exists" >&2; exit 1; }

mkdir -p "$DEST"
for stage in "$ROOT"/pipeline/0*-*; do
  s="$(basename "$stage")"
  mkdir -p "$DEST/$s"
  cp "$stage/GATE.md" "$DEST/$s/GATE.md"
  if [[ -d "$stage/templates" ]]; then
    cp "$stage"/templates/*.md "$DEST/$s/" 2>/dev/null || true
  fi
done
mkdir -p "$DEST/00-discover/competitors" "$DEST/02-define/increments" "$DEST/07-grow/reviews" "$DEST/07-grow/data"

# App template copy for Stage 4
cp -R "$ROOT/app" "$DEST/04-build/app"
BUNDLE_ID="$PREFIX.$(echo "$SLUG" | tr -d '_-')"
sed -i.bak \
  -e "s/bundleIdPrefix: com.example/bundleIdPrefix: $PREFIX/" \
  -e "s/PRODUCT_BUNDLE_IDENTIFIER: com.example.app/PRODUCT_BUNDLE_IDENTIFIER: $BUNDLE_ID/" \
  -e "s/match AppStore com.example.app/match AppStore $BUNDLE_ID/" \
  -e "s/CFBundleDisplayName: App/CFBundleDisplayName: $NAME/" \
  "$DEST/04-build/app/project.yml"
sed -i.bak "s/com\.example\.app\./$BUNDLE_ID./g" \
  "$DEST/04-build/app/Sources/Core/Services/PurchaseService.swift" \
  "$DEST/04-build/app/Config/Products.storekit"
find "$DEST/04-build/app" -name "*.bak" -delete

cat > "$DEST/STATUS.md" <<STATUS
# $NAME (\`$SLUG\`)

| Field | Value |
|-------|-------|
| Current stage | 0 Discover |
| Bundle ID | $BUNDLE_ID |
| Name | $NAME (working) |
| Pricing model | TBD |
| Created | $(date +%Y-%m-%d) |

## Decisions log
| Date | Stage | Decision |
|------|-------|----------|
| $(date +%Y-%m-%d) | 0 | Product created |

## Next action
Run \`/discover $SLUG\`.
STATUS

cat > "$DEST/CHANGELOG.md" <<'CL'
# Changelog

## [Unreleased]
CL

# Replace placeholders in templates
find "$DEST" -name "*.md" -not -path "*/04-build/app/*" -exec sed -i.bak "s/<Product>/$NAME/g" {} \; -exec rm -f {}.bak \;

echo "Created products/$SLUG"
echo "  bundle id: $BUNDLE_ID"
echo "  next:      claude → /discover $SLUG"
