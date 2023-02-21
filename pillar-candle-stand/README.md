# pillar-candle-stand

## purity

You can pass so many points into benjaminwand's `b_curv` that it will effectively never return.
Hacked this to generate just half the pillar and then flip it on top itself; which is fine cause I'm a fan of symmetry.

However in the future, we may have to split a long array into several `b_curv` calls and eyeball stitching them together?

Or maybe pursue a windowed approach through the input points (variable name `set_1_points`) where we consider previous 2,current,next 2 as inputs for _this_ curve point generation.

`PillarBuilding.xlsx` is what I used to generate my desired list of input points.

I also had to split the generation of `curve_1_points` from the render of `rotate_extrude` because together it was time prohibitive.

## feasibility

DO NOT print the full model in an upright position while generating supports.

This will encase the center of the pillar in an immovable shield of support material. I eventually got it chiselled off, but not before breaking the base off the pillar. I'm super gluing it back together now.

It will probably be better in the future to rotate_extrude(angle=180) rotate 90 degrees and print two halves to be glued together later. However I wanted to use a dual-tone filament and that would not produce the effect I was looking for.

This whole concept still needs some brainstorming.