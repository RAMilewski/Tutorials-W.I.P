# Textures from Images

Some operations are able to add texture to the objects they create. A texture can be any regularly repeated variation in the height of the surface. You can apply texture to objects made with  [sweep()](https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#functionmodule-sweep),  [linear_sweep](https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#functionmodule-linear_sweep), [rotate_sweep](https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#functionmodule-rotate_sweep) and [path_sweep()](https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#functionmodule-path_sweep), and [cyl()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-cyl).  You can use [textured_tile()](https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#functionmodule-textured_tile) to add textures to any other flat surface.

To define a texture you need to specify how the height should vary over a rectangular block that is repeated to tile the object.

Because textures are based on rectangular tiling, this means adding textures to curved shapes may result in distortion of the basic texture unit. For example, if you texture a cone, the scale of the texture is larger at the wide end of the cone and smaller at the narrower end of the cone.

You can specify a texture using two methods: a height field or a VNF.  This tutorial confines itself to heightfield textures.  See [VNF Textures] (https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#subsection-vnf-textures) for more about VNF textures.

The texture() function enables you to create 16 built-in height field textures and 5 VNF textures. 
It also allows you to control the roughness used on the surface of some height field textures. See the examples in [texture()](https://github.com/BelfrySCAD/BOSL2/wiki/skin.scad#function-texture).

The simplest way to specify a texture map is to give a 2d array of height values that specify the height of the texture on a grid. Values in the height field should generally range from 0 to 1. A zero height in the height field corresponds to the height of the surface and 1 the highest point in the texture above the surface being textured.

```openscad-2d;VPR=[0,0,0];VPD=150;FOV = 50;NoScales
include <BOSL2/std.scad>

array = [
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

left(20)  textured_tile(array, [30,30], tex_reps = [1,1]);
right(20) textured_tile(array, [30,15], tex_reps = [1,1]);
```

Notice that while our texture array is square, the aspect ratio of the design on the tile is determined by the height and width of tile, how many times we repeat the design in each direction.  It is not possible to define margins around the design. They must be included in the texture array.

To make a textured surface from an image, we need to convert the image file into an array similar to the one above, albeit much larger. The scripts folder in BOSL2 contans 3 utilities that enable the creation of height field textures from images:

- **image2scad.html** - a javascript program that runs in your browser to make texture arrays from any image format your browser can open. 
- **image2scad.py** for processing  `.jpg`, `.gif`, `.png`, or `.bmp` image files into data arrays suitable for use as textures.
- **geotiff2scad.py** - a python script for processing geotiffs containing elevation data into texture arrays.

## img2scad.html

The BOSL2 scripts folder contains **img2scad.html** page with a javascript program that will create a texture array from any image your browser can render. Open this with the **File** menu of your browser.

![img2scad.html](images/img2scad/img2scad.html.png)

To create a texture array first select an image file by clicking on the **Browse...** button or pasting an image from your clipboard.  A grayscale images scaled to 100 pixels wide will appear to the right of the Appearance block.

### Transformations

In the Transformations block you can rescale the image by choosing a new width.  The rescaling will preserve the aspect ratio of your image.

There are buttons in this block to rotate the image by 90˚ in either direction and to flip the image horizontally or vertically.

You can also crop the image on any edge by a number of pixels you select.  This is a valuable feature for making repeating texture arrays where exact matching of pixels along the edges is necessary.

#### Appearance

In the Apperance block you can choose between the NTSC (RGB) formula, and the sRGB linear luminance formula for converting color images to the greyscale image from which the data array is generated.

##### NTSC

The NTSC greyscale formula uses the ITU-R 601-2 luma transform, the standard for convertng RGB to luminance:

```text
L = 0.299 * R + 0.587 * G + 0.114 * B
```

This means:

- Red contributes 29.9% to brightness,
- Green contributes 58.8%,
- Blue contributes 11.4%.

##### sRGB

The sRGB color space is defined in terms of the CIE 1931 linear luminance formula:

```text
L = 0.2126 * R + 0.7152 * G + 0.0722 * B
```

This means:

- Red contributes 21.26% to brightness,
- Green contributes 71.52%,
- Blue contributes 7.22%.

For more information on these conversions see the wikipedia entries for [luma](https://en.wikipedia.org/wiki/luma) and [greyscale](https://en.wikipedia.org/wiki/Grayscale).

#### Filters

There are three filters in the Appearance block that let you modify the image from which the data array is created.

##### Blur

The Blur filter applies a gaussian blur to the image.  Blurring the image will make a smoother texture. 







## img2scad.py

The Python script named [img2scad.py](https://github.com/BelfrySCAD/BOSL2/blob/master/scripts/img2scad.py) in the BOSL2 scripts folder that can process `.jpg`, `.gif`, `.png`, or `.bmp` image files into data arrays suitable for use as textures.

The script converts RGB color images to [greyscale](https://en.wikipedia.org/wiki/Grayscale) using the ITU-R 601-2 luma transform, the standard for convertng RGB to luminance.  The formula is:

    L = 0.299 * R + 0.587 * G + 0.114 * B

This means:

- Red contributes 29.9% to brightness,
- Green contributes 58.8%,
- Blue contributes 11.4%.

The alpha channel is ignored and transparent backgrounds and areas are treated as black.

Because most image files produce very large data arrays, the `img2tex.py` script includes the ability to downscale the output, resulting in data arrays that render as textures in less time, but at the cost of a loss of resolution.

usage: img2scad.py [-h] [-o OUTFILE] [-v VARNAME] [-i] [-r RESIZE] 
    [-R {-270,-180,-90,0,90,180,270}] [--mirror-x] [--mirror-y]
    [--blur BLUR] [--minout MINOUT] [--maxout MAXOUT] [--range {dynamic,full}]
    infile

| **Positional Argument**     | **Description**          |
|------------------------|-------------------------|
| `infile`              | Input image file.  |
|      |      |
| **Option**            | **Description**                                                         |
| `-h, --help`          | Show the help message and exit.                                          |
| `-o OUTFILE`          | Specify the output `.scad` file.                                         |
| `-v VARNAME`          | Set the variable name to use in the `.scad` file.                       |
| `-i, --invert`        | Invert luminance values.                                                |
| `-r RESIZE`           | Resample the image to `WIDTHxHEIGHT`.                                   |
| `-R {degrees}`        | Rotate the output by the specified degrees (`-270, -180, -90, 0, 90...`).|
| `--mirror-x`          | Mirror the output in the X direction.                                   |
| `--mirror-y`          | Mirror the output in the Y direction.                                   |
| `--blur BLUR`         | Apply a box blur with the given radius.                                 |
| `--minout MINOUT`     | Set the output value for the minimum luminance.                         |
| `--maxout MAXOUT`     | Set the output value for the maximum luminance.                         |
| `--range {dynamic}`   | Scale luminances dynamically (`0-1`) or use the full range (`0-255`).           |




