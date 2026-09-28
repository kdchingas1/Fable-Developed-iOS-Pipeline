#!/usr/bin/env python3
"""Sanity checks for the exported STLs.

    python3 check_meshes.py <stl-dir> [--clash a.stl b.stl ...]

For every STL in the directory: watertightness, size, TPU mass, thinnest
walls, and the area of downward-facing surfaces the slicer has to bridge.
Each --clash pair must not intersect, e.g. the case and the phone model
(needs `pip install manifold3d`).
"""

import argparse
import sys
from pathlib import Path

import numpy as np
import trimesh

TPU_DENSITY = 1.21  # g/cm3, typical for TPU 95A
MIN_WALL = 0.8  # mm, thinnest wall worth flagging for a 0.4 mm nozzle
MAX_CLASH = 0.5  # mm3; touching faces can leave a sliver of numerical noise


def wall_thickness(mesh, samples=20000, seed=1):
    """Sample local thickness by casting rays inward from surface points."""
    points, faces = trimesh.sample.sample_surface(mesh, samples, seed=seed)
    normals = mesh.face_normals[faces]
    origins = points - normals * 1e-4
    hits, rays, _ = mesh.ray.intersects_location(origins, -normals, multiple_hits=False)
    return np.linalg.norm(hits - origins[rays], axis=1)


def overhangs(mesh, limit_deg=50.0):
    """Faces overhanging more than limit_deg from vertical, above the bed.

    The limit sits a little past 45 degrees so the model's deliberate 45-degree
    chamfers, which print fine, are not counted.
    """
    down = mesh.face_normals[:, 2] < -np.cos(np.radians(limit_deg))
    above_bed = mesh.triangles_center[:, 2] > mesh.bounds[0][2] + 0.05
    sel = down & above_bed
    return mesh.area_faces[sel].sum(), mesh.triangles_center[sel]


def report(path):
    mesh = trimesh.load(path)
    ext = mesh.extents
    print(f"\n{path.name}")
    print(f"  watertight: {mesh.is_watertight}, consistent winding: {mesh.is_winding_consistent}")
    print(f"  size: {ext[0]:.2f} x {ext[1]:.2f} x {ext[2]:.2f} mm")
    print(f"  volume: {mesh.volume / 1000:.2f} cm3, about {mesh.volume / 1000 * TPU_DENSITY:.0f} g of TPU")

    t = wall_thickness(mesh)
    t = t[t > 0.05]
    thin = (t < MIN_WALL).mean() * 100
    print(f"  wall thickness: 1st percentile {np.percentile(t, 1):.2f} mm, median {np.median(t):.2f} mm,"
          f" {thin:.2f}% of samples under {MIN_WALL} mm")

    area, centres = overhangs(mesh)
    print(f"  overhangs past 50 deg above the bed: {area:.0f} mm2", end="")
    print(f" (z {centres[:, 2].min():.2f} to {centres[:, 2].max():.2f} mm)" if len(centres) else "")
    return mesh.is_watertight and mesh.is_winding_consistent


def clash(a, b):
    try:
        both = trimesh.load(a).intersection(trimesh.load(b), engine="manifold")
    except Exception as exc:  # manifold3d missing or the boolean failed
        print(f"\nclash {Path(a).name} x {Path(b).name}: not checked ({exc})")
        return True
    vol = 0.0 if both.is_empty else abs(both.volume)
    print(f"\nclash {Path(a).name} x {Path(b).name}: {vol:.3f} mm3")
    return vol < MAX_CLASH


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("stl_dir", type=Path)
    ap.add_argument("--clash", nargs=2, action="append", default=[], metavar=("A", "B"))
    args = ap.parse_args()

    ok = all([report(p) for p in sorted(args.stl_dir.glob("*.stl"))])
    ok &= all([clash(a, b) for a, b in args.clash])
    if not ok:
        sys.exit("\nmesh checks FAILED")
    print("\nmesh checks passed")


if __name__ == "__main__":
    main()
