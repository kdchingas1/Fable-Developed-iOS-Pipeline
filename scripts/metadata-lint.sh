#!/usr/bin/env bash
# Enforce App Store metadata character limits for every locale under fastlane/metadata.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIMITS="name:30 subtitle:30 keywords:100 promotional_text:170 description:4000 release_notes:4000"
status=0
for dir in "$ROOT"/fastlane/metadata/*/; do
  [[ -d "$dir" ]] || continue
  locale="$(basename "$dir")"
  for pair in $LIMITS; do
    key="${pair%%:*}"; limit="${pair##*:}"
    f="$dir$key.txt"
    [[ -f "$f" ]] || continue
    len=$(tr -d '\n' < "$f" | wc -m | tr -d ' ')
    if (( len > limit )); then
      echo "FAIL $locale/$key.txt: $len > $limit" >&2; status=1
    fi
  done
  if [[ -f "$dir/keywords.txt" ]] && grep -q ' ' "$dir/keywords.txt"; then
    echo "WARN $locale/keywords.txt contains spaces; Apple ignores them, use commas only" >&2
  fi
done
[[ $status -eq 0 ]] && echo "metadata: within limits"
exit $status
