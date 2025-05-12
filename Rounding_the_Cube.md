# Rounding the Cube

One of the shape primitives you'll use most often in your OpenSCAD designs is the cube.  Rounding the edges of cube-like objects impacts both the visual appeal and functional aspects of the final design. The BOSL2 library provides a variety of methods for rounding edges and corners.

There are four different 3d shape primitives that you can use to make cube-like objects:

* [**cuboid()**](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid) - Creates a cube with chamfering and roundovers.

* [**cube()**](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-cube) -  An extended version of OpenSCAD's [cube()](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#cube) with anchors for attaching children. (See the [Attachments Tutorial](https://github.com/BelfrySCAD/BOSL2/wiki/Tutorial-Attachments)).

* [**prismoid()**](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid) - Creates a rectangular prismoid shape with optional roundovers and chamfering.

* [**rounded_prism()**](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism) - Makes a rounded 3d object by connecting two polygons with the same vertex count. Rounded_prism supports continuous curvature rounding. (See [Types of Roundovers](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#section-types-of-roundovers)).

BOSL2 provides two different methods for rounding the edges of these cube-like primitives.

* **Built-in Rounding** - The [cuboid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid), [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid), and [rounded_prism()](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism) all have built-in arguments for rounding some or all of their edges.

* **Masking** -  BOSL2 includes a number of options for masking the edges and corners of objects. Masking can accomplish rounding tasks that are not possible with the built-in rounding arguments. For example with masking you can have a cube with a different rounding radius on the top edges than the rounding radius on the bottom edges.

Cube-like objects have six named faces: **LEFT, RIGHT, TOP, BOT, FWD, BACK**.

![](https://github.com/BelfrySCAD/BOSL2/wiki/images/attachments/subsection-specifying-edges_fig2.png)

Each of those face names is a vector pointing to the face.  e.g. UP is [0,0,1], and FWD is [0,-1,0].  By adding two of those vectors we can specify an edge.  For example, TOP + RIGHT is the same as [0,0,1] + [0,1,0] = [0,1,1].

![](https://github.com/BelfrySCAD/BOSL2/wiki/images/attachments/subsection-specifying-edges_fig1.png)

See [Specifying Edges](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#subsection-specifying-edges) for more details.

## Cuboid Rounding

You can round the edges of a [cuboid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid) with the `rounding` argument by specifying the radius of curvature:

```openscad
include <BOSL2/std.scad>
cuboid(100, rounding=20);
```
![Figure 1](images/Rounding_the_Cube_1.png)

We can round the edges aligned with one of the axes, X, Y, or Z:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, edges = "Z");
```
![Figure 2](images/Rounding_the_Cube_2.png)

You can round all the edges on one of the faces. Here we're rounding only the top edges:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, edges = TOP);
```
![Figure 3](images/Rounding_the_Cube_3.png)

...or just the bottom edges.  Here we're using the `teardrop` argument to limit the overhang angle to enable 3d printing on FDM printers without requiring supports:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, teardrop = 45, edges = BOTTOM);
```
![Figure 4](images/Rounding_the_Cube_4.png)

It is possible to round one or more of the edges while leaving others unrounded:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, edges = TOP+FRONT);
```
![Figure 5](images/Rounding_the_Cube_5.png)

...or exclude the rounding of one or more edges while rounding all the others:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, except = TOP+FRONT);
```
![Figure 6](images/Rounding_the_Cube_6.png)

Multiple edges can be specified in the form of a list:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, edges=[FWD,TOP], except=[TOP+LEFT,FWD+RIGHT]);
```
![Figure 7](images/Rounding_the_Cube_7.png)

You can also specify which edges to round using a 3x4 array, where each entry corresponds to one of the 12 edges and is set to 1 if that edge is included and 0 if the edge is not. The edge ordering is:

[  
    [Y-Z-, Y+Z-, Y-Z+, Y+Z+],
    [X-Z-, X+Z-, X-Z+, X+Z+],  
    [X-Y-, X+Y-, X-Y+, X+Y+]  
]

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, edges = [[1,0,1,0],[0,1,0,1],[1,0,0,1]]);
```
![Figure 8](images/Rounding_the_Cube_8.png)

Similarly, you can use an array to exclude selected edges from rounding:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=20, except = [[1,0,1,0],[0,1,0,1],[1,0,0,1]]);
```
![Figure 9](images/Rounding_the_Cube_9.png)

### Negative Rounding

You can fillet top or bottom edges by using negative rounding values. Note that you cannot use negative rounding values on Z-aligned (side) edges.  If you need to add a fillet on a Z-aligned edge, use [fillet()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-fillet):

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], rounding=-20, edges = BOTTOM);
```
![Figure 10](images/Rounding_the_Cube_10.png)

### Chamfering

Chamfering the edges of the cuboid() can be done in a manner similar to rounding:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], chamfer=20);
```
![Figure 11](images/Rounding_the_Cube_11.png)

You can specify edges as with rounding:

```openscad
include <BOSL2/std.scad>
cuboid([100,80,60], chamfer=20, edges = "Z", except = FWD+RIGHT);
```
![Figure 12](images/Rounding_the_Cube_12.png)

## Prismoid Rounding

The [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid) differs from the cuboid and cube in that you can only round or chamfer the vertical(ish) edges using the built-in parameters. For those edges, you can specify rounding and/or chamfering for top and bottom separately:

```openscad
include <BOSL2/std.scad>
prismoid(size1=[35,50], size2=[20,30], h=20, rounding1 = 8, rounding2 = 1);
```
![Figure 13](images/Rounding_the_Cube_13.png)

You can also specify rounding of the individual vertical(ish) edges on an edge by edge basis by listing the edges in counter-clockwise order starting with the BACK+RIGHT (X+Y+) edge:

```openscad
include <BOSL2/std.scad>
prismoid(100, 80, rounding1=[0,50,0,50], rounding2=[40,0,40,0], h=50);
```
![Figure 14](images/Rounding_the_Cube_14.png)

## Masking Edges of the Cuboid, Cube and Prismoid

### 2D Edge Masking with [edge_profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile) and [edge_profile_asym()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile_asym)

One limitation of using rounding arguments in [cuboid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid) is that all the rounded edges must have the same rounding radius.  Using masking we have the flexibility to apply different edge treatments to the same cube.  Masking can also be used on the [cube()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-cube) and [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid) shapes.

2D edge masks are attached to edges using [edge_profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile). They have a default tag of "remove" to enable differencing them away from your cube using [diff()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-diff).

We can use a negative rounding value to fillet the bottom of a cuboid and [edge_profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile) to round the top.  Here [edge_profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile) applies a 2d roundover mask to the top edges of the cuboid.

```openscad
include <BOSL2/std.scad>
diff()
    cuboid([50,60,70], rounding = -10, edges = BOT)
        edge_profile(TOP)
            mask2d_roundover(r=10);
```
![Figure 15](images/Rounding_the_Cube_15.png)

We could also fillet the bottom of the cube using [edge_profile_asym()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile_asym) and [xflip()](https://github.com/BelfrySCAD/BOSL2/wiki/transforms.scad#functionmodule-xflip)

```openscad
include<BOSL2/std.scad>
cuboid(50)
 edge_profile_asym(BOT, corner_type="round")
  xflip() mask2d_roundover(10);
```
![Figure 16](images/Rounding_the_Cube_16.png)

The flip argumet in [edge_profile_asym()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile_asym) determines whether the fillet flares out or up.  The corner_type argument is used to shape the corners of external fillets.

```openscad
include<BOSL2/std.scad>
cuboid(50){
 edge_profile_asym(TOP, flip = true)
  xflip() mask2d_roundover(10);
   edge_profile_asym(BOT, corner_type="round")
  xflip() mask2d_roundover(10);
   } 
```
![Figure 17](images/Rounding_the_Cube_17.png)

See [mask2d_roundover()](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_roundover) for additional mask parameters.  Here we use the *inset* parameter to produce a bead.

```openscad
include <BOSL2/std.scad>
diff()
 cube([50,60,70],center=true)
     edge_profile(TOP, except=[BACK,TOP+LEFT])
        mask2d_roundover(h=12, inset=4);
```
![Figure 18](images/Rounding_the_Cube_18.png)

You can use [edge-profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile) to round the top or bottom of a [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid).  Because the side faces of a [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid) are not strictly vertical, it's is necessary to increase the length of the masks using the *excess* parameter in [edge_profile()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_profile), and to set the mask\_angle to $edge\_angle in [mask2d\_roundover()](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_roundover).

```openscad
include<BOSL2/std.scad>
diff()
 prismoid(size1=[35,50], size2=[30,30], h=20, rounding1 = 8, rounding2 = 0)
     edge_profile([TOP+LEFT, TOP+RIGHT], excess = 5)
        mask2d_roundover(r = 15, mask_angle = $edge_angle, $fn = 64);
```
![Figure 19](images/Rounding_the_Cube_19.png)

Instead of specifying the rounding radius, you can specify the height of edge rounding.

```openscad
include<BOSL2/std.scad>
diff()
   cube(30)
      edge_profile([TOP+LEFT, TOP+RIGHT])
         mask2d_roundover(h = 12, $fn = 64);
```
![Figure 20](images/Rounding_the_Cube_20.png)

Rounding heights larger than an adjacent edge/2 will produce a ridge line on the top surface.

```openscad
include<BOSL2/std.scad>
diff()
   cube(30)
      edge_profile([TOP+LEFT, TOP+RIGHT])
         mask2d_roundover(h = 20, $fn = 64);
```
![Figure 21](images/Rounding_the_Cube_21.png)

The [mask2d_teardrop()](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_teardrop) mask can be used to round the bottom of a cube-like object.  It limits the overhang angle to 45° or a value you specify in with the **angle** argument.

```
include<BOSL2/std.scad>
diff()
   prismoid([30,20], [40,30], rounding = 2, h = 20, $fn = 64)
      edge_profile(BOT, excess = 15)
         mask2d_teardrop(h = 5, angle = 50, mask_angle = $edge_angle, $fn = 64);
```

![Figure 22](images/Rounding_the_Cube_22.png)

In addition to the simple [roundover](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_roundover) mask, and the [teardrop](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_teardrop) mask, there are masks for [cove](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_cove), [chamfer](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_chamfer), [rabbet](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_rabbet), [dovetail](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_dovetail) and [ogee](https://github.com/BelfrySCAD/BOSL2/wiki/masks2d.scad#functionmodule-mask2d_ogee) edges.  

The mask2d_ogee() only works on [cube()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-cube) and [cuboid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid) shapes, or a [prismoid()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-prismoid) where size2 >= size1 in both the X and Y dimensions.

```openscad
include <BOSL2/std.scad>
diff()
 prismoid(size1 = [50,50],size2 = [80,80], rounding1 = 25, height = 80)
  edge_profile(TOP)
   mask2d_ogee([
            "xstep",8,  "ystep",5,  // Starting shoulder.
            "fillet",5, "round",5,  // S-curve.
            "ystep",3,  "xstep",3   // Ending shoulder.
        ]);
```
![Figure 23](images/Rounding_the_Cube_23.png)

Prismoids, espcecially prismoids with substantial shift, require careful selection of mask2d_roundover() arguments.  Here we're setting radius = 5 and mask_angle = $edge_angle.

```
include<BOSL2/std.scad>
diff()
   prismoid([30,20], [50,60], h=20, shift=[30,40])
      edge_profile(TOP, excess=35)
         mask2d_roundover(r=5, mask_angle=$edge_angle, $fn=128);
```

![Figure 24](images/Rounding_the_Cube_24.png)

Specifying rounding height rather than rounding radius produces a different shape.

![Figure 25](images/Rounding_the_Cube_25.png)

```
include<BOSL2/std.scad>
diff()
   prismoid([30,20], [50,60], h=20, shift=[30,40])
      edge_profile(TOP, excess=35)
         mask2d_roundover(h=5, mask_angle=$edge_angle, $fn=128);
```

The quarter_round argument works well for edges with acute angles, but leaves a ledge on the edges with obtuse angles.

![Figure 26](images/Rounding_the_Cube_26.png)

```
include<BOSL2/std.scad>
diff()
   prismoid([30,20], [50,60], h=20, shift=[30,40])
      edge_profile(TOP, excess=35)
         mask2d_roundover(r=5, mask_angle=$edge_angle, quarter_round = true, $fn=128);
```

A work-around is to use quarter_round only on the edges with acute angles.

![Figure 27](images/Rounding_the_Cube_27.png)

```
include<BOSL2/std.scad>
diff()
   prismoid([30,20], [50,60], h=20, shift=[30,40])
      edge_profile(TOP, excess=35)
         mask2d_roundover(r=5, mask_angle=$edge_angle, quarter_round = $edge_angle<90, $fn=128);
```

### 3D Edge and Corner Masking

BOSL2 contains a number of 3d edge and corner masks in addition to the 2d edge profiles shown above.

The 3d edge masks have the advantage of being able to vary the rounding radius along the edge.  3d edge masks, such as[rounding_edge_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-rounding_edge_mask), can be attached using [edge_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_mask). The 3D edge masks have a default tag of "remove" to enable differencing them away from your cube using [diff()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-diff).

```openscad
include <BOSL2/std.scad>
diff()
 cuboid(80)
  edge_mask(TOP+FWD)
   rounding_edge_mask(r1 = 40, r2 = 0, l = 80);
```
![Figure 28](images/Rounding_the_Cube_28.png)

While you can specify the length of the mask with the l or h argument, [edge_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_mask) sets a special variable, `$parent_size`, to the size of the parent object.  In the case where the parent is not a perfect cube, you need to mask each edge individually:

```openscad
include <BOSL2/std.scad>
diff()
 cuboid([60,80,40])  {
  edge_mask(TOP+FWD)
   rounding_edge_mask(r = 10, l = $parent_size.x + 0.1);
  edge_mask(TOP+RIGHT)
   rounding_edge_mask(r = 10, l = $parent_size.y + 0.1);
  edge_mask(RIGHT+FWD)
   rounding_edge_mask(r = 10, l = $parent_size.z + 0.1);
 } 
```
![Figure 29](images/Rounding_the_Cube_29.png)

As you can see above, using only [rounding\_edge_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-rounding_edge_mask) to round the top of the cube leaves the corners unrounded.  Use [corner_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-corner_mask) and [rounding\_corner_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-rounding_corner_mask) for a smoother corner.

```openscad
include <BOSL2/std.scad>
diff()
 cuboid([60,80,40]) {
  edge_mask(TOP+FWD)
   rounding_edge_mask(r = 10, l = $parent_size.x + 0.1);
  edge_mask(TOP+RIGHT)
   rounding_edge_mask(r = 10, l = $parent_size.y + 0.1);
  edge_mask(RIGHT+FWD)
   rounding_edge_mask(r = 10, l = $parent_size.z + 0.1);
        corner_mask(TOP+RIGHT+FWD)
            rounding_corner_mask(r = 10);
 }
 
```
![Figure 30](images/Rounding_the_Cube_30.png)

As with the built-in rounding arguments, you can use [edge\_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-edge_mask) and [corner\_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/attachments.scad#module-corner_mask) to apply teardrop roundings using [teardrop\_edge_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-teardrop_edge_mask) and [teardrop\_corner_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-teardrop_corner_mask) to limit the overhang angle for better printing on FDM printers. Note that the vertical mask on the RIGHT_FWD edge is a [rounding\_edge\_mask()](https://github.com/BelfrySCAD/BOSL2/wiki/masks3d.scad#module-rounding_edge_mask).

```openscad
include <BOSL2/std.scad>
diff()
 cuboid([60,80,40]) {
  edge_mask(BOT+FWD)
   teardrop_edge_mask(r = 10, l = $parent_size.x + 0.1, angle = 40);
  edge_mask(BOT+RIGHT)
   teardrop_edge_mask(r = 10, l = $parent_size.y + 0.1, angle = 40);
  edge_mask(RIGHT+FWD)
   rounding_edge_mask(r = 10, l = $parent_size.z + 0.1);
        corner_mask(BOT+RIGHT+FWD)
            teardrop_corner_mask(r = 10, angle = 40);
 }
 
```
![Figure 31](images/Rounding_the_Cube_31.png)

## Rounded Prism

You can construct cube-like objects, as well as a variety of other prisms using [rounded_prism()](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism). In this tutorial we're concentrating on rounding cubes, but [rounded_prism()](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism) has capabilities that extend well beyond cube-like objects.  See the [rounded_prism()](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism) examples to learn more.

A feature unique to [rounded_prism()](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#functionmodule-rounded_prism) is that it uses continuous curvature rounding. Rather than using constant radius arcs, continuous curvature rounding uses 4th-order Bezier curves. For complete details on how this works see [Types of Roundovers](https://github.com/BelfrySCAD/BOSL2/wiki/rounding.scad#section-types-of-roundovers).

Two parameters control the roundover, k and joint.  The joint parameter is the distance from where the rounding starts to the unrounded edge. The k parameter ranges from 0 to 1 with a default of 0.5. Larger values give a more abrupt transition and smaller ones a more gradual transition.

A smooth roundover with a joint length of 18 and the value of k set to 0.75.
![](https://github.com/BelfrySCAD/BOSL2/wiki/images/rounding/figure_1_3.png)

A smooth roundover, with the value of k set to 0.15.  The transition is so gradual that it appears that the roundover is much smaller than specified.  The cut length is much smaller for the same joint length.  
![](https://github.com/BelfrySCAD/BOSL2/wiki/images/rounding/figure_1_4.png)

The joint parameter is specified separately for the top, bottom and side edges; joint\_top, joint\_bot, and joint_sides.

 If you want a very smooth roundover, set the joint parameter as large as possible and then adjust the k value down low enough to achieve a sufficiently large roundover.  Joint parameters usually need to be < side/2.

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect(20), height=20, 
    joint_top=9.99, joint_bot=9.99, joint_sides=9.99, k = 0.5);
```
![Figure 32](images/Rounding_the_Cube_32.png)

Here we're using the same cube size and joint sizes, but varying the k parameter.

![Figure 33](images/Rounding_the_Cube_33.png)

Alternatively, we can keep k constant at k=0.5 and vary the joint length:

![Figure 34](images/Rounding_the_Cube_34.png)

You can match the cicrular roundover of cuboid() by setting the joint values to the rounding used in cuboid() and setting the k value to 0.93:

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
left(15) 
    rounded_prism(rect(20), height=20, joint_top=4, joint_bot=4, joint_sides=4, k = 0.93);
right(15)  
    cuboid(20, rounding = 4, $fn = 72);
```
![Figure 35](images/Rounding_the_Cube_35.png)

Unlike other cube-like objects, the rounded prism smoothness is not affected by the special variable $fn, but by the splinesteps argument. Splinesteps defaults to 16.

![Figure 36](images/Rounding_the_Cube_36.png)

The joint size can be set to different values for each side of the prism:

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect(20), height=20, 
    joint_top=4, joint_bot=3, joint_sides=[2, 10, 5, 10], k = 0.5);
```
![Figure 37](images/Rounding_the_Cube_37.png)

Likewise, k can be set to different values for each side of the prism:

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect(20), height=20, 
    joint_top=3, joint_bot=3, joint_sides=8, 
    k_top=0.5, k_bot=0.1, k_sides=[0,0.7,0.3,0.7]);
```
![Figure 38](images/Rounding_the_Cube_38.png)

You can specify a 2-vector for the joint distance to produce asymmetric rounding which is different on the two sides of the edge. This may be useful when one one edge in your polygon is much larger than another.

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect([50.1,20.1]), height=6.1, 
   joint_top=[15,3], joint_bot=[15,3],
   joint_sides=[[10,25],[25,10],[10,25],[25,10]], 
   k_sides=0.3);
```
![Figure 39](images/Rounding_the_Cube_39.png)

For the top and bottom you can specify negative joint distances. If you give a scalar negative value then the roundover will flare outward.

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect(20), height=20, 
    joint_top=5, joint_bot=-5, joint_sides=8, k=0.5);
```
![Figure 40](images/Rounding_the_Cube_40.png)

If you give a 2-vector then if joint\_top[0] is negative the shape will flare outward, but if joint\_top[1] is negative the shape will flare upward. At least one value must be non-negative. The same rules apply for joint\_bot. The joint\_sides parameter must be entirely nonnegative.

Flaring the top upward. The bottom has an asymmetric rounding with a small flare but a large rounding up the side.

```openscad
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
rounded_prism(rect(20), height=20, 
joint_top=[3,-3], joint_bot=[-3,10], joint_sides=8, k=0.5);
```
![Figure 41](images/Rounding_the_Cube_41.png)
