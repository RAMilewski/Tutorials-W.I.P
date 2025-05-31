include <BOSL2/std.scad>
$fn = 144;
image = [
   
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,1,1,1,1,0,0,0],
    [0,0,1,1,1,1,1,1,0,0],
    [0,1,1,0,0,0,0,1,1,0],
    [0,1,1,0,0,0,0,1,1,0],
    [0,1,1,0,0,0,0,1,1,0],
    [0,1,1,0,0,0,0,1,1,0],
    [0,0,1,1,1,1,1,1,0,0],
    [0,0,0,1,1,1,1,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
];


mytex = image;
h = 6;
r = 10;
style = "min_area";
reps = [6,1];

cyl(h = h, r = r, texture = mytex, tex_reps = reps, style = style);
label(style);


module label(label) {
    color("black") up(h) xrot(90) text(label, size = 3, halign = "center", valign = "center");}