include <BOSL2/std.scad>
$fn = $preview ? 64 : 256;

// Parameters
magnet_diameter = 5;
magnet_height = 2;
tolerance = 0.1;
wall_thickness = 1.6;
small_delta = 0.0001;

// Computed dimensions
magnet_hole_height = magnet_height + tolerance;
magnet_hole_radius = magnet_diameter/2 + tolerance;
magnet_hole_outer_radius = magnet_hole_radius;

magnet_base_diameter = 2 * (magnet_hole_outer_radius + wall_thickness);
magnet_base_height = magnet_height + wall_thickness + tolerance;

cable_holder_radius = 5;
cable_holder_outer_radius = cable_holder_radius + wall_thickness;

module MagnetBase(right=false) {
    tilt(BACK) difference() {   
        union() {
            cylinder(d=magnet_base_diameter, h=magnet_base_height, anchor=BOT);
            if (right) {
                cube([magnet_base_diameter/2, magnet_base_diameter, magnet_base_height], anchor=RIGHT+BOT);
            } else {
                cube([magnet_base_diameter/2, magnet_base_diameter, magnet_base_height], anchor=LEFT+BOT);
            }
        }
        down(small_delta) 
            cylinder(h=magnet_hole_height + small_delta, r1=magnet_hole_radius, r2=magnet_hole_outer_radius, anchor=BOT);
    }
}

module CableHolder() {
    difference() {
        back(magnet_base_height) difference() {
            union() {
                cylinder(h=magnet_base_diameter, r1=cable_holder_outer_radius, r2=cable_holder_outer_radius, center=true);
                cuboid([2 * cable_holder_outer_radius, 2 * magnet_base_height, magnet_base_diameter], anchor=BACK);

            }
            union() {
                cylinder(h=magnet_base_diameter + 2 * small_delta, r=cable_holder_radius, center=true);
                cube([2 * cable_holder_radius, 2 * magnet_base_height, magnet_base_diameter + 2 * small_delta], anchor=BACK);
            }
        }
        cube(200, anchor=BACK);
    }
}

module shirt_base() {
    difference() {
        union() {
            right(cable_holder_radius + magnet_base_diameter/2) cylinder(d=magnet_base_diameter, h=magnet_base_height, anchor=BOT);
            left(cable_holder_radius + magnet_base_diameter/2) cylinder(d=magnet_base_diameter, h=magnet_base_height, anchor=BOT);
            cube([magnet_base_diameter + 2 * cable_holder_radius, magnet_base_diameter, magnet_base_height], anchor=BOT);
        }
        union() {
            down(small_delta) right(cable_holder_radius + magnet_base_diameter/2)
                cylinder(h=magnet_hole_height + small_delta, r1=magnet_hole_radius, r2=magnet_hole_outer_radius, anchor=BOT);
            down(small_delta) left(cable_holder_radius + magnet_base_diameter/2)
                cylinder(h=magnet_hole_height + small_delta, r1=magnet_hole_radius, r2=magnet_hole_outer_radius, anchor=BOT);
            }
    }
}

// Actual model
union() {
    right(cable_holder_radius + magnet_base_diameter/2) MagnetBase(right=true);
    left(cable_holder_radius + magnet_base_diameter/2) MagnetBase();
    CableHolder();
}

fwd(10) tilt(FWD) shirt_base();