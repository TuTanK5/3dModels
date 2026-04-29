include <BOSL2/std.scad>
$fn = $preview ? 64 : 256;

length = 250;
width = 15;
height = 15;
hook_length = 50;
wall_thickness = 4;

union() {
    cuboid([length, width, height], anchor=LEFT, rounding=2)
    position(RIGHT) cuboid([height, width, hook_length], anchor=RIGHT+BOT, rounding=2);
    up(width/2) tilt(RIGHT) cylinder(h = length-3, r = width/2);
}