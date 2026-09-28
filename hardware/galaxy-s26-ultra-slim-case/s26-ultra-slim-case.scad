// =============================================================================
//  Samsung Galaxy S26 Ultra - slim TPU case
//  Parametric OpenSCAD model (OpenSCAD 2021.01 or newer).
//  Prints back-down with no supports. README.md has print settings and the
//  source and confidence of every phone dimension below.
// =============================================================================
//
//  Axes match the print orientation:
//    X  across the phone. +X is the RIGHT edge as seen from the screen, the
//       edge with the volume and side keys.
//    Y  along the phone. +Y is the top edge.
//    Z  up from the bed. The case back lies on the bed, so looking down at the
//       print is the same as looking at the phone's screen.
//  Units are millimetres. Feature positions are entered the way you would
//  measure them on the phone with calipers.

/* [Output] */
// case: the printable case. camera_guard: optional clip-in lens guard (print the case with camera_guard = true). fit_test: quick skeleton print to check the fit. assembly and phone: previews, not for printing.
part = "case"; // [case, camera_guard, fit_test, assembly, phone]
// cutout: open slots with direct key feel. covered: flexible raised pads over the keys.
key_style = "cutout"; // [cutout, covered]
// Cut the camera opening and inner recess for the clip-in lens guard.
camera_guard = false;

/* [Phone body] */
phone_w = 78.1;           // official
phone_h = 163.6;          // official
phone_t = 7.9;            // official, excluding the camera
phone_corner_r = 7.0;     // plan-view corner radius, Samsung's "7R"
phone_front_edge_r = 1.1; // roll-off between the frame and the screen glass
phone_back_edge_r = 0.7;  // roll-off between the frame and the back glass

/* [Fit] */
// Gap between phone and wall, per side. Raise if the case is too tight, lower if loose.
fit_xy = 0.2;
// Gap between the screen glass and the underside of the lip. Keep back + phone_t + fit_z
// on a multiple of your layer height (9.4 mm at 0.2 mm layers) so the slicer prints it as drawn.
fit_z = 0.3;

/* [Shell] */
wall = 1.2;              // side wall thickness
back = 1.2;              // back plate thickness; 1.2 sits flush with the camera island
lip_rise = 1.3;          // how far the top of the lip stands proud of the screen
lip_over = 1.5;          // how far the lip reaches over the screen, from the phone's outer edge
lip_inner_chamfer = 0.4; // softens the inner top edge of the lip for edge swipes
lip_top_r = 0.7;         // rounding on the outer top edge of the lip
back_edge_r = 2.2;       // outer rounding between the back and the sides

/* [Camera, measured on the back of the phone] */
// Measure looking at the back: from the top edge, and from the long edge nearest
// the camera (the key edge). The island is the raised pill with the three big lenses.
island_from_top = 4.2;
island_from_side = 4.15;
island_w = 21.4;
island_h = 57.8;
island_rise = 1.2;   // island height above the back glass
lens_d = 16.4;       // big lens ring diameter
lens_rise = 4.5;     // top of the big lens rings above the back glass
lens_from_top = [14.85, 33.1, 51.3];
// The second column sits on the flat back glass: 3x telephoto, flash, laser AF.
col_from_side = 32.85; // column centre line
col_top = 10.15;       // top of the upper small ring
col_bottom = 37.8;     // bottom of the lower small ring
col_w = 9.4;           // small ring diameter
col_rise = 1.4;        // small ring height above the back glass
cam_clear = 0.6;       // gap around the island and the column
cam_chamfer = 0.6;     // chamfer on the outside edge of the camera opening

/* [Camera guard (optional clip-in part)] */
guard_wall = 1.2;
guard_above_lens = 0.4; // how far the guard rim stands above the lens rings
guard_flange_w = 1.2;   // flange trapped between the phone and the case back
guard_flange_t = 0.6;
guard_fit = 0.1;        // gap between the guard and the case

/* [Side keys, measured from the phone's top edge] */
vol_from_top = 27.0;  // to the top end of the volume key
vol_len = 20.4;
side_from_top = 57.6; // to the top end of the side key
side_len = 13.5;
key_rise = 0.45;      // how far the keys stand out of the frame
key_h = 2.5;          // key height across the frame
key_z = 3.95;         // key centre above the back glass (phone_t / 2 is centred)
key_margin = 1.5;     // slot length past each end of a key
key_margin_h = 0.8;   // slot height above and below a key
pad_depth = 0.6;      // covered keys: pocket depth behind each pad

/* [Bottom edge, x from the centre line, + toward the key edge] */
spen_x = -33.0;   // S Pen centre; the pen sits in the bottom-left corner seen from the screen
spen_w = 5.0;     // S Pen cross-section, official
spen_t = 4.15;
spen_clear = 0.7;
spk_x = -19.1;    // speaker grille centre
spk_w = 10.4;
spk_h = 1.4;
usb_w = 17.0;     // USB-C opening, wide enough to take in the bottom microphone at x = +7.1
usb_h = 7.0;      // fits most USB-C plug overmoulds
port_z = 3.95;    // centre of the bottom openings above the back glass

/* [Top edge] */
// The top edge has a microphone and a pressure vent at unpublished positions. A channel
// inside the top wall joins anything within top_channel_len / 2 of centre to a row of vents.
top_channel_len = 52;
top_channel_h = 3.0;
top_channel_depth = 0.5;
top_vents = 9;
top_vent_d = 1.6;
// Width of the pocket under the lip that keeps the earpiece slit from being sealed.
earpiece_w = 18;

/* [Hidden] */
$fn = 48;
eps = 0.01;
corner_fn = 24; // facets per 90 degrees of plan-view corner

z_pb = back;                    // phone back glass
z_pt = back + phone_t;          // phone screen glass
z_mid = z_pb + phone_t / 2;     // phone mid-plane
z_lip_under = z_pt + fit_z;     // underside of the lip
z_top = z_pt + lip_rise;        // top of the case
o_wall = fit_xy + wall;         // outer wall, as an offset from the phone outline
x_in = phone_w / 2 + fit_xy;    // inner face of the side walls
y_in = phone_h / 2 + fit_xy;    // inner face of the end walls

assert(lip_over > phone_front_edge_r, "lip_over must exceed phone_front_edge_r or the lip will not hook over the screen");
assert(lip_over < phone_corner_r, "lip_over must be smaller than phone_corner_r");
assert(lip_rise >= fit_z + lip_inner_chamfer + 0.4, "lip_rise leaves the lip too thin; raise it or lower fit_z");

// ----------------------------------------------------------------------------
//  Profile sweep
// ----------------------------------------------------------------------------
// The shell is described by 2D profiles of [offset, z] points. Offset is how
// far a point sits outside (+) or inside (-) the phone's plan-view outline.
// Each point becomes a rounded-rectangle ring sharing the phone's corner
// centres, and neighbouring rings are stitched into one closed polyhedron:
// exact offset surfaces, far faster than minkowski().

function arc(cx, cz, rx, rz, a0, a1, n = 8) =
  [for (i = [0:n]) let (a = a0 + (a1 - a0) * i / n) [cx + rx * cos(a), cz + rz * sin(a)]];

function ring(o, z) =
  let (r = phone_corner_r + o,
       cx = phone_w / 2 - phone_corner_r,
       cy = phone_h / 2 - phone_corner_r)
  [for (q = [0:3], i = [0:corner_fn])
     let (a = 90 * q + 90 * i / corner_fn)
     [(q == 0 || q == 3 ? cx : -cx) + r * cos(a), (q < 2 ? cy : -cy) + r * sin(a), z]];

module loft(profile) {
  m = 4 * (corner_fn + 1);
  k = len(profile);
  polyhedron(
    points = [for (p = profile) each ring(p[0], p[1])],
    faces = concat(
      [[for (j = [0:m - 1]) j]],
      // Triangles, not quads: CGAL rejects quads that are planar only to rounding error.
      [for (i = [0:k - 2], j = [0:m - 1], t = [0:1])
         let (a = i * m + j, b = a + m, a1 = i * m + (j + 1) % m, b1 = a1 + m)
         t == 0 ? [a, b, b1] : [a, b1, a1]],
      [[for (j = [m - 1:-1:0]) (k - 1) * m + j]]),
    convexity = 6);
}

// The lower half of the back edge rounding is a 45-degree chamfer tangent to the
// arc: a full round would overhang ~1 mm on the second layer and droop in TPU.
outer_profile = concat(
  [[o_wall - back_edge_r + back_edge_r * tan(22.5), 0]],
  arc(o_wall - back_edge_r, back_edge_r, back_edge_r, back_edge_r, -45, 0, 6),
  arc(o_wall - lip_top_r, z_top - lip_top_r, lip_top_r, lip_top_r, 0, 90, 8));

// The phone's shape grown by the fit gaps, then the lip opening above it.
inner_profile = concat(
  arc(-phone_back_edge_r, z_pb + phone_back_edge_r,
      phone_back_edge_r + fit_xy, phone_back_edge_r, -90, 0, 8),
  arc(-phone_front_edge_r, z_pt - phone_front_edge_r,
      phone_front_edge_r + fit_xy, phone_front_edge_r + fit_z, 0, 90, 8),
  [[-lip_over, z_lip_under],
   [-lip_over, z_top - lip_inner_chamfer],
   [-lip_over + lip_inner_chamfer, z_top],
   [-lip_over + lip_inner_chamfer, z_top + 1]]);

phone_profile = concat(
  arc(-phone_back_edge_r, z_pb + phone_back_edge_r, phone_back_edge_r, phone_back_edge_r, -90, 0, 8),
  arc(-phone_front_edge_r, z_pt - phone_front_edge_r, phone_front_edge_r, phone_front_edge_r, 0, 90, 8));

// ----------------------------------------------------------------------------
//  Small shapes
// ----------------------------------------------------------------------------

module rrect(w, h, r) {
  r2 = min(r, w / 2, h / 2);
  hull() for (sx = [-1, 1], sy = [-1, 1])
    translate([sx * (w / 2 - r2), sy * (h / 2 - r2)]) circle(r = r2);
}

// Stadium (slot) of length l and height h in local XY, extruded along +Z.
module stadium(l, h, depth) {
  hull() for (s = [-1, 1])
    translate([s * max(l / 2 - h / 2, 0), 0, 0]) cylinder(d = h, h = depth);
}

// Opening through a wall. Local z = 0 is the wall's inner face and z = wall its
// outer face; the prism starts `inset` inside the cavity so it also clears walls
// that curve away, and the outside edge gets a 45-degree chamfer.
module wall_slot(l, h, ch, inset = 1) {
  translate([0, 0, -inset]) stadium(l, h, wall + inset + 1);
  hull() {
    translate([0, 0, wall - ch]) stadium(l, h, eps);
    translate([0, 0, wall]) stadium(l + 2 * ch, h + 2 * ch, 1);
  }
}

// Frames that put wall_slot() coordinates onto each wall of the case.
module on_right_wall(y, z) { translate([x_in, y, z]) rotate([90, 0, 90]) children(); }
module on_bottom_wall(x, z) { translate([x, -y_in, z]) rotate([90, 0, 0]) children(); }
module on_top_wall(x, z) { translate([x, y_in, z]) rotate([90, 0, 180]) children(); }

// ----------------------------------------------------------------------------
//  Camera
// ----------------------------------------------------------------------------

// A back-view measurement (from the key edge, from the top edge) in case XY.
// The camera is in the top corner on the key side, which is +X from the screen.
function back_xy(from_side, from_top) = [phone_w / 2 - from_side, phone_h / 2 - from_top];

module island_2d() {
  translate(back_xy(island_from_side + island_w / 2, island_from_top + island_h / 2))
    rrect(island_w, island_h, island_w / 2);
}

module column_2d() {
  translate(back_xy(col_from_side, (col_top + col_bottom) / 2))
    rrect(col_w, col_bottom - col_top, col_w / 2);
}

// Island and sensor column plus clearance, merged into a single opening (the
// offset pair closes the thin strip between them and rounds the joins), then
// grown by g.
module camera_2d(g = 0) {
  merge = 3.5;
  offset(r = g) offset(r = -merge) offset(r = merge + cam_clear) {
    island_2d();
    column_2d();
  }
}

module camera_cut() {
  g = camera_guard ? guard_wall + guard_fit : 0;
  translate([0, 0, -1]) linear_extrude(back + 2) camera_2d(g);
  if (camera_guard) {
    // Recess on the inside of the back plate for the guard's flange.
    translate([0, 0, back - guard_flange_t])
      linear_extrude(guard_flange_t + 1) camera_2d(guard_wall + guard_flange_w + guard_fit);
  } else {
    // 45-degree chamfer on the outside edge, in 0.1 mm steps the slicer cannot see.
    n = max(1, round(cam_chamfer / 0.1));
    for (i = [0:n - 1])
      translate([0, 0, i == 0 ? -1 : i * cam_chamfer / n])
        linear_extrude((i == 0 ? 1 : 0) + cam_chamfer / n + eps)
          camera_2d(cam_chamfer * (n - i) / n);
  }
}

// Clip-in lens guard, modelled flange-down as it prints. It passes through the
// case's camera opening from the inside; the flange sits in the recess and the
// phone's back glass holds it there, so it needs no glue.
module camera_guard_part() {
  rim = lens_rise + guard_above_lens;
  ch = 0.5; // chamfer round the outer top edge of the rim, built in n steps
  n = 5;
  difference() {
    union() {
      linear_extrude(guard_flange_t) camera_2d(guard_wall + guard_flange_w);
      linear_extrude(rim - ch + eps) camera_2d(guard_wall);
      for (i = [0:n - 1])
        translate([0, 0, rim - ch + i * ch / n])
          linear_extrude(ch / n + eps) camera_2d(guard_wall - ch * (i + 1) / n);
    }
    translate([0, 0, -1]) linear_extrude(rim + 2) camera_2d(0);
  }
}

// ----------------------------------------------------------------------------
//  Keys, ports and openings
// ----------------------------------------------------------------------------

// [distance from the phone's top edge to the key's top end, key length]
keys = [[vol_from_top, vol_len], [side_from_top, side_len]];
function key_y(k) = phone_h / 2 - k[0] - k[1] / 2;
function key_slot(k) = [k[1] + 2 * key_margin, key_h + 2 * key_margin_h];

module key_slots() {
  for (k = keys)
    on_right_wall(key_y(k), z_pb + key_z)
      wall_slot(key_slot(k)[0], key_slot(k)[1], 0.5);
}

// Covered keys: the wall bulges outward by pad_depth over each key and keeps
// its full thickness, so the key sits in a pocket instead of under the wall.
// Both the pad and the pocket have 45-degree sides, so neither needs support.
module key_pads() {
  for (k = keys) on_right_wall(key_y(k), z_pb + key_z) {
    s = key_slot(k);
    hull() {
      translate([0, 0, wall - eps]) stadium(s[0] + 2 * pad_depth, s[1] + 2 * pad_depth, eps);
      translate([0, 0, wall + pad_depth - eps]) stadium(s[0], s[1], eps);
    }
  }
}

module key_pockets() {
  for (k = keys) on_right_wall(key_y(k), z_pb + key_z) {
    s = key_slot(k);
    hull() {
      translate([0, 0, -1]) stadium(s[0] + 2 * pad_depth, s[1] + 2 * pad_depth, 1 + eps);
      translate([0, 0, pad_depth]) stadium(s[0], s[1], eps);
    }
  }
}

module bottom_cuts() {
  z = z_pb + port_z;
  // The pen's end sits on the curve of the corner, where the wall bends away
  // from the prism, so this opening starts deeper inside the cavity.
  on_bottom_wall(spen_x, z) wall_slot(spen_w + 2 * spen_clear, spen_t + 2 * spen_clear, 0.8, 4);
  on_bottom_wall(spk_x, z) wall_slot(spk_w + 2, spk_h + 1.6, 0.5);
  on_bottom_wall(0, z) wall_slot(usb_w, usb_h, 0.5);
}

// A groove in the inner face of the top wall, with a 45-degree ceiling, joins
// the phone's top microphone and vent to a row of small vents. Each vent only
// bridges its own diameter, so the row prints cleanly where one long slot
// would sag.
module top_cuts() {
  on_top_wall(0, z_mid) {
    hull() {
      translate([-top_channel_len / 2, -top_channel_h / 2, -1])
        cube([top_channel_len, top_channel_h, 1]);
      translate([-top_channel_len / 2, -top_channel_h / 2 + top_channel_depth, top_channel_depth - eps])
        cube([top_channel_len, top_channel_h - 2 * top_channel_depth, eps]);
    }
    end = 2; // first and last vents sit this far in from the channel ends
    pitch = (top_channel_len - 2 * end) / (top_vents - 1);
    for (i = [0:top_vents - 1])
      translate([-top_channel_len / 2 + end + i * pitch, 0, -1]) cylinder(d = top_vent_d, h = wall + 2);
  }
}

// Lifts the lip off the glass over the earpiece slit, which sits where the
// frame rim meets the glass, so the lip cannot seal it.
module earpiece_relief() {
  lift = 0.4;      // extra gap under the lip
  from_edge = 0.8; // start of the pocket, measured in from the phone's edge
  translate([-earpiece_w / 2, phone_h / 2 - lip_over - 1, z_lip_under - 1])
    cube([earpiece_w, lip_over + 1 - from_edge, 1 + lift]);
}

// ----------------------------------------------------------------------------
//  Parts
// ----------------------------------------------------------------------------

module case() {
  difference() {
    union() {
      loft(outer_profile);
      if (key_style == "covered") key_pads();
    }
    loft(inner_profile);
    camera_cut();
    if (key_style == "covered") key_pockets(); else key_slots();
    bottom_cuts();
    top_cuts();
    earpiece_relief();
  }
}

// Walls and lip at full height, but only a 6 mm border of the back plate plus
// a band round the camera: checks outline, lip, keys, ports and camera in about
// half the time and filament of the full case.
module fit_test() {
  band = 6;
  intersection() {
    case();
    union() {
      // Starts just above the floor so no film of back plate survives; the
      // border region below overlaps it to keep the walls attached.
      translate([-100, -100, z_pb + 0.01]) cube([200, 200, 50]);
      translate([0, 0, -1]) linear_extrude(z_pb + 1.5) {
        difference() {
          square([200, 300], center = true);
          rrect(phone_w - 2 * band, phone_h - 2 * band, phone_corner_r);
        }
        camera_2d(camera_guard ? guard_wall + guard_flange_w + 3 : 3);
      }
    }
  }
}

// Simplified phone for previews and interference checks.
module phone() {
  loft(phone_profile);
  translate([0, 0, z_pb - island_rise]) linear_extrude(island_rise + eps) island_2d();
  for (y = lens_from_top)
    translate(concat(back_xy(island_from_side + island_w / 2, y), z_pb - lens_rise))
      cylinder(d = lens_d, h = lens_rise + eps);
  for (y = [col_top + col_w / 2, col_bottom - col_w / 2])
    translate(concat(back_xy(col_from_side, y), z_pb - col_rise))
      cylinder(d = col_w, h = col_rise + eps);
  for (k = keys)
    translate([phone_w / 2 - eps, key_y(k), z_pb + key_z])
      rotate([90, 0, 90]) stadium(k[1], key_h, key_rise + eps);
}

if (part == "case") case();
else if (part == "camera_guard") camera_guard_part();
else if (part == "fit_test") fit_test();
else if (part == "phone") phone();
else if (part == "guard_in_place") translate([0, 0, z_pb]) mirror([0, 0, 1]) camera_guard_part();
else if (part == "assembly") {
  color("SteelBlue") case();
  color("#23272e") phone();
  if (camera_guard)
    color("LightSlateGray") translate([0, 0, z_pb]) mirror([0, 0, 1]) camera_guard_part();
}
