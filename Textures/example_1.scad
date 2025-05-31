include <BOSL2/std.scad>
include <Vodicka.scad>

cyl(h = 20, r = 20, $fn = 72, 
    texture = image, tex_depth = 1, tex_reps = [4,1], style = min_edge);