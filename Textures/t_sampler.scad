include <BOSL2/std.scad>
include <Vodicka.scad>

$fn = 144;
data = [
    [0,0,0,0,0,0,0,0,0,0],
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

mytex = "hills";

h = 6;
r = 10;
reps = [6,1];
depth = -1;

styles = ["default","alt","concave","convex","min_area","min_edge","flip1","flip2","quincunx"];

for (i = [0:len(styles)-1]) {
    style = styles[i];
    down(i*(h+2)) {
        cyl(h = h, r = r, texture = mytex, tex_depth = depth, tex_reps = reps, style = style );
        label(style);
    }
}

module label(label) {
    color("black") right(15) xrot(90) text(label, size = 4, valign = "center");}