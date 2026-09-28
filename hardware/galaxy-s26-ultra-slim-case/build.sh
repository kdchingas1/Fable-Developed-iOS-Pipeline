#!/usr/bin/env bash
# Regenerates the STL files and preview renders from the OpenSCAD source, then
# checks the meshes. Needs OpenSCAD 2021.01+. On a headless Linux box the
# renders also need xvfb-run; the mesh checks need python3 with trimesh and
# manifold3d (pip install trimesh manifold3d rtree).
#
#   ./build.sh          # STLs, renders, checks
#   ./build.sh stl      # STLs only
set -euo pipefail
cd "$(dirname "$0")"

SCAD=s26-ultra-slim-case.scad
STL=stl
PNG=renders
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$STL" "$PNG"

stl() { # out.stl [-D name=value ...]
  local out=$1
  shift
  echo "==> $out"
  rm -f "$out"
  openscad --hardwarnings --export-format binstl -o "$out" "$@" "$SCAD" 2>&1 | grep -E "WARNING|ERROR|rendering time" || true
  [ -s "$out" ] || { echo "failed: $out" >&2; exit 1; }
}

CASE=$STL/s26-ultra-slim-case.stl
COVERED=$STL/s26-ultra-slim-case-covered-keys.stl
GUARD_CASE=$STL/s26-ultra-slim-case-for-camera-guard.stl
GUARD=$STL/s26-ultra-camera-guard.stl
FIT=$STL/s26-ultra-fit-test.stl

stl "$CASE" -D 'part="case"'
stl "$COVERED" -D 'part="case"' -D 'key_style="covered"'
stl "$GUARD_CASE" -D 'part="case"' -D 'camera_guard=true'
stl "$GUARD" -D 'part="camera_guard"'
stl "$FIT" -D 'part="fit_test"'
stl "$TMP/phone.stl" -D 'part="phone"'
stl "$TMP/guard-in-place.stl" -D 'part="guard_in_place"'

[ "${1:-}" = "stl" ] && exit 0

# --- Renders -----------------------------------------------------------------
RUN=()
if [ -z "${DISPLAY:-}" ] && command -v xvfb-run >/dev/null; then
  RUN=(xvfb-run -a -s "-screen 0 1920x1080x24")
fi

C='color("#3d6e9e") import'
P="color(\"#23272e\") import(\"$TMP/phone.stl\");"
G="color(\"#8a96a3\") import(\"$TMP/guard-in-place.stl\");"

view() { # out.png camera scad-source [extra openscad flags]
  echo "==> $1"
  rm -f "$1"
  printf '%s\n' "$3" > "$TMP/view.scad"
  "${RUN[@]}" openscad -o "$1" --imgsize=1600,1100 --camera="$2" ${4:-} \
    --colorscheme=Tomorrow --projection=p "$TMP/view.scad" 2>&1 | grep -E "WARNING|ERROR" || true
  [ -s "$1" ] || { echo "failed: $1" >&2; exit 1; }
}

view "$PNG/back.png" 0,0,4,128,0,212,300 "$C(\"$PWD/$CASE\");" "--viewall --autocenter"
view "$PNG/front.png" 0,0,4,52,0,28,300 "$C(\"$PWD/$CASE\");" "--viewall --autocenter"
view "$PNG/on-phone.png" 0,0,4,122,0,148,300 "$C(\"$PWD/$CASE\"); $P" "--viewall --autocenter"
view "$PNG/camera-guard.png" 18,52,0,125,0,160,150 "$C(\"$PWD/$GUARD_CASE\"); $P $G"
view "$PNG/bottom-edge.png" 0,-83,5,78,0,0,150 "$C(\"$PWD/$CASE\"); $P"
view "$PNG/top-edge.png" 0,83,5,78,0,180,150 "$C(\"$PWD/$CASE\"); $P"
view "$PNG/key-edge.png" 40,30,5,78,0,90,160 "$C(\"$PWD/$CASE\"); $P"
view "$PNG/key-edge-covered.png" 40,30,5,78,0,90,160 "$C(\"$PWD/$COVERED\"); $P"
view "$PNG/fit-test.png" 0,0,2,52,0,28,300 "$C(\"$PWD/$FIT\");" "--viewall --autocenter"

# --- Checks ------------------------------------------------------------------
if python3 -c "import trimesh" 2>/dev/null; then
  python3 check_meshes.py "$STL" \
    --clash "$CASE" "$TMP/phone.stl" \
    --clash "$COVERED" "$TMP/phone.stl" \
    --clash "$GUARD_CASE" "$TMP/phone.stl" \
    --clash "$GUARD_CASE" "$TMP/guard-in-place.stl" \
    --clash "$TMP/guard-in-place.stl" "$TMP/phone.stl"
else
  echo "skipping mesh checks (pip install trimesh manifold3d rtree)"
fi
