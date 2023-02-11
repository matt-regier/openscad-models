// $fn=360;
$fn=180;

segment_height=50; // verified

pi=3.1415;

outer_diameter=35; // verified
outer_radius_bump=(
    2 /*mm*/
    / pi
    / 2 /* convert from diameter to radius */
    ); // I want the new mount point to be oversized by 2mm in circumference so that the bracket fits more snugly
outer_radius=outer_diameter/2+outer_radius_bump;

if (false) {
    echo("base_outer_circumference", outer_diameter*pi);
    echo("base_outer_diameter", outer_diameter);
    echo("base_outer_radius", outer_diameter/2);
    echo("outer_radius_bump", outer_radius_bump);
    echo("outer_circumference_bump", 2*outer_radius_bump*pi);
    echo("outer_radius", outer_radius);
    echo("outer_diameter", 2*outer_radius);
    echo("outer_circumference", 2*outer_radius*pi);
}

inner_diameter=32.5; // verified
inner_radius_shrink=(
    -1 /*mm*/
    / pi
    / 2 /* convert from diameter to radius */
    ); // Shrink the new tab by 1mm in circumference so that it should fit in the existing pipe
inner_radius=inner_diameter/2+inner_radius_shrink;
if (false) {
    echo("base_inner_circumference", inner_diameter*pi);
    echo("base_inner_diameter", inner_diameter);
    echo("base_inner_radius", inner_diameter/2);
    echo("inner_radius_shrink", inner_radius_shrink);
    echo("inner_circumference_shrink", 2*inner_radius_shrink*pi);
    echo("inner_radius", inner_radius);
    echo("inner_diameter", 2*inner_radius);
    echo("inner_circumference", 2*inner_radius*pi);
}

bevel_radius=inner_radius/4;
inset_radius=7.5;

inner_height_ratio=1;

// lip_height=3;
// lip_radius=outer_radius+3;

// module lipped_extension() {
//     translate([0,0,0]) cylinder(2*segment_height, inner_radius, inner_radius);
//     translate([0,0,2*segment_height]) cylinder(lip_height, lip_radius, lip_radius);
//     translate([0,0,2*segment_height+lip_height]) cylinder(segment_height, outer_radius, outer_radius);
// }
//lipped_extension();

module extension() {
    difference() {
        translate([0,0,0]) cylinder(segment_height, outer_radius, outer_radius); // mount point
        translate([0,0,0]) cylinder(0.5*segment_height, inset_radius, inset_radius); // mount point inset
    }
    translate([0,0,segment_height]) {
        difference() {
            cylinder(inner_height_ratio*segment_height, inner_radius, inner_radius); // tab
            translate([0,0,0.25*inner_height_ratio*segment_height]) cylinder(0.75*inner_height_ratio*segment_height, inset_radius, inset_radius); // tab inset
        }
    }

    //translate([0,0,segment_height+inner_height_ratio*segment_height]) sphere(inner_radius); // bevel A
    translate([0,0,segment_height+inner_height_ratio*segment_height]) // bevel B
        rotate_extrude()
            translate([inner_radius-bevel_radius,0,0])
                circle(r = bevel_radius);
}
extension();
