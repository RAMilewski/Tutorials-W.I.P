include <BOSL2/std.scad>
$fn = 144;
image = [
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,0,0,0],
    [0,0,0,1,1,1,1,1,1,0,0],
    [0,0,1,1,0,0,0,0,1,1,0],
    [0,0,1,1,0,0,0,0,1,1,0],
    [0,0,1,1,0,0,0,0,1,1,0],
    [0,0,1,1,0,0,0,0,1,1,0],
    [0,0,0,1,1,1,1,1,1,0,0],
    [0,0,0,0,1,1,1,1,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0],
   
];


mytex = image;
h = 20;
style = "min_edge";
reps = [4,1];

shape = rect([20,20]);

linear_sweep(shape, h = h, texture = mytex, tex_reps = reps, tex_extra = 0, style = style);
label(style);


module label(label) {
    color("black") up(h * 1.2) xrot(90) text(label, size = 3, halign = "center", valign = "center");}