include <BOSL2/std.scad>
$fn = $preview ? 64 : 256;

// Parameters
magnet_diameter = 5;
magnet_height = 2;
tolerance = 0.1;
wall_thickness = 1.6;
small_delta = 0.0001;
inner_axis_length = 20;
// Computed dimensions
magnet_hole_height = magnet_height + tolerance;
magnet_hole_radius = magnet_diameter/2 + tolerance;
magnet_hole_outer_radius = magnet_hole_radius;

magnet_base_diameter = 2 * (magnet_hole_outer_radius + wall_thickness);
magnet_base_height = magnet_height + wall_thickness + tolerance;

module MagnetBase() {
    difference() {   
        cylinder(d=magnet_base_diameter, h=magnet_base_height, anchor=BOT);
        down(small_delta) 
            cylinder(h=magnet_hole_height + small_delta, r1=magnet_hole_radius, r2=magnet_hole_outer_radius, anchor=BOT);
    }
}

MagnetBase();
up(inner_axis_length) MagnetBase();
cylinder(h=inner_axis_length, d=magnet_base_diameter/2, anchor=BOT);