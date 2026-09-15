#!/usr/bin/env bash
# Verify a stage gate for a product, or lint every GATE.md in the repo.
# Usage: ./scripts/gate-check.sh <slug> <stage-number>
#        ./scripts/gate-check.sh --lint-all
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [[ "${1:-}" == "--lint-all" ]]; then
  status=0
  while IFS= read -r gate; do
    if ! grep -qE '^- \[( |x)\] ' "$gate"; then
      echo "FAIL $gate: no checklist items" >&2; status=1
    fi
  done < <(find "$ROOT/pipeline" "$ROOT/products" -name GATE.md 2>/dev/null)
  [[ $status -eq 0 ]] && echo "All GATE.md files well formed"
  exit $status
fi

SLUG="${1:-}"; N="${2:-}"
[[ -n "$SLUG" && -n "$N" ]] || { echo "usage: $0 <slug> <stage-number> | --lint-all" >&2; exit 1; }

STAGE_DIR="$(find "$ROOT/products/$SLUG" -maxdepth 1 -type d -name "0${N}-*" | head -1)"
[[ -n "$STAGE_DIR" ]] || { echo "no stage 0$N under products/$SLUG" >&2; exit 1; }
GATE="$STAGE_DIR/GATE.md"
[[ -f "$GATE" ]] || { echo "missing $GATE" >&2; exit 1; }

total=$(grep -cE '^- \[( |x)\] ' "$GATE" || true)
done_count=$(grep -cE '^- \[x\] ' "$GATE" || true)
open=$(grep -E '^- \[ \] ' "$GATE" || true)

# Any file referenced in backticks inside the gate must exist in the stage folder.
missing=()
while IFS= read -r ref; do
  [[ -z "$ref" ]] && continue
  case "$ref" in
    *.md|*.txt|*.yml|*.swift)
      f="$STAGE_DIR/$ref"
      [[ -e "$f" || -e "$ROOT/products/$SLUG/$ref" || -e "$ROOT/$ref" ]] || missing+=("$ref");;
  esac
done < <(grep -oE '`[^`]+`' "$GATE" | tr -d '`' | sort -u)

echo "Gate $N for $SLUG: $done_count/$total checked"
if [[ -n "$open" ]]; then echo "Open items:"; echo "$open"; fi
if [[ ${#missing[@]} -gt 0 ]]; then echo "Referenced files missing:"; printf '  %s\n' "${missing[@]}"; fi

if [[ "$done_count" -eq "$total" && ${#missing[@]} -eq 0 && "$total" -gt 0 ]]; then
  echo "PASS"; exit 0
else
  echo "FAIL"; exit 2
fi
