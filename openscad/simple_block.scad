include <BOSL2/std.scad>
$fn = $preview ? 64 : 256;

// Parameters
magnet_diameter = 5;
magnet_height = 2;
tolerance = 0.1;
wall_thickness = 1.6;
small_delta = 0.0001;


block_length = 27;
block_width = 17;
block_height = 45;


// Computed dimensions
magnet_hole_height = magnet_height + tolerance;
magnet_hole_radius = magnet_diameter/2 + tolerance;


module Block() {
    difference() {
        cuboid([block_height, block_length, block_width], anchor=BOT, chamfer=1);
        union() {left(block_length/2 - magnet_hole_radius) down(small_delta) 
            cylinder(h=magnet_hole_height + small_delta, r=magnet_hole_radius, anchor=BOT);
        right(block_length/2 - magnet_hole_radius) down(small_delta) 
            cylinder(h=magnet_hole_height + small_delta, r=magnet_hole_radius, anchor=BOT);}
    }
}

tilt(BACK) Block();