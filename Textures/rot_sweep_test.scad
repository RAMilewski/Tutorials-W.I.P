include <BOSL2/std.scad>
$fn = 144;
image = [
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,0,0,0,0],
    [0,0,0,1,1,1,1,1,1,0,0,0],
    [0,0,1,1,0,0,0,0,1,1,0,0],
    [0,0,1,1,0,0,0,0,1,1,0,0],
    [0,0,1,1,0,0,0,0,1,1,0,0],
    [0,0,1,1,0,0,0,0,1,1,0,0],
    [0,0,0,1,1,1,1,1,1,0,0,0],
    [0,0,0,0,1,1,1,1,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
];

mytex = image;
h = 6;
r = 10;
style = "min_area";
depth = .1;
reps = [8,4];

shape = square([.001,10]);
path = arc(n = 12, r = 15, angle = 90, start = 225);




path_sweep(shape, path, 
    texture = mytex, tex_depth = depth, tex_reps = reps, tex_skip = 0, tex_extra = 0);

label(style);


module label(label) {
    color("black") up(h*2.2) fwd(r) xrot(90) text(label, size = 3, halign = "center", valign = "center");}