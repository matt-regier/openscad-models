debug=true;

shaft_depth=80;
shaft_inner_diameter=52;//2.0*2.54*10;
shaft_outer_diameter=65;//2.5*2.54*10;
shaft_thickness=(shaft_outer_diameter-shaft_inner_diameter)/2;

lip_inner_diameter=shaft_outer_diameter;
lip_outer_diameter=76;//3.0*2.54*10;
lip_depth=18;//10;
lip_thickness=(lip_outer_diameter-lip_inner_diameter)/2;

bolt_diameter=16;//15;
bolt_length=300;
bolt_radius=bolt_diameter/2;
// bolt1_depth=30+bolt_radius;
bolt2_depth=55+bolt_radius;

plate_height=10;

yoda_svg_scale=0.75;

if (debug) {
    echo("shaft_depth", shaft_depth);
    echo("shaft_inner_diameter", shaft_inner_diameter);
    echo("shaft_outer_diameter", shaft_outer_diameter);
    echo("shaft_thickness", shaft_thickness);
    echo("lip_inner_diameter", lip_inner_diameter);
    echo("lip_outer_diameter", lip_outer_diameter);
    echo("lip_depth", lip_depth);
    echo("lip_thickness", lip_thickness);
    echo("plate_height", plate_height);
}

module bolts () {
        translate([-bolt_length/2,shaft_outer_diameter/2,-bolt1_depth]) rotate([0,90,0]) cylinder(bolt_length,bolt_radius,bolt_radius);
        translate([-bolt_length/2,shaft_outer_diameter/2,-bolt2_depth]) rotate([0,90,0]) cylinder(bolt_length,bolt_radius,bolt_radius);
}

module autoHitch () {
  color("blue") {
    difference() {
        union() {
            difference() {
                translate([0,0,-shaft_depth]) cube([shaft_outer_diameter, shaft_outer_diameter, shaft_depth]);
                translate([shaft_thickness,shaft_thickness,-shaft_depth]) cube([shaft_inner_diameter, shaft_inner_diameter, shaft_depth]);
            }
            difference() {
                translate([-lip_thickness,-lip_thickness,-lip_depth]) cube([lip_outer_diameter, lip_outer_diameter, lip_depth]);
                translate([-lip_thickness+lip_thickness,-lip_thickness+lip_thickness,-lip_depth]) cube([lip_inner_diameter, lip_inner_diameter, lip_depth]);
            }
        }
        bolts();
    }
  }
}
// autoHitch();

module post() {
    translate([lip_thickness,lip_thickness,-shaft_depth]) roundedCube(shaft_inner_diameter,shaft_inner_diameter,shaft_depth,2);
}
module collar() {
    difference() {
        translate([-2*lip_thickness,-2*lip_thickness,-lip_depth]) cube([2*lip_thickness+lip_outer_diameter, 2*lip_thickness+lip_outer_diameter, lip_depth]);
        translate([-1*lip_thickness,-1*lip_thickness,-lip_depth]) cube([lip_outer_diameter, lip_outer_diameter, 2*lip_depth]);
    }
}
module yoda () {
    translate([0,0,plate_height*1])
        linear_extrude(height=plate_height)
            scale([yoda_svg_scale,yoda_svg_scale,1])
                import("toyoda.svg", center=true, dpi=96);

    translate([0,0,plate_height*0])
        linear_extrude(height=plate_height)
            scale([yoda_svg_scale,yoda_svg_scale,1])
                import("toyoda_solid.svg", center=true, dpi=96);
}
module hitchCover() {
    color("green") {
        difference() {
            union() {
                post();
                collar();
                translate([shaft_outer_diameter/2,shaft_outer_diameter/2,0]) yoda();
            }
            bolts();
        }
    }
}
hitchCover();

module ruler() {
    color ("red") {
        translate([-110+shaft_outer_diameter/2,0,0]) rotate([0,90,0]) cylinder(220,10,10);
    }
}
//ruler();

module roundedCube(xdim, ydim, zdim, rdim) {
  hull() {
    translate([rdim,rdim,rdim]) sphere(r=rdim);
    translate([xdim-rdim,rdim,rdim]) sphere(r=rdim);
    translate([rdim,ydim-rdim,rdim]) sphere(r=rdim);
    translate([xdim-rdim,ydim-rdim,rdim]) sphere(r=rdim);
    translate([rdim,rdim,zdim-rdim]) sphere(r=rdim);
    translate([xdim-rdim,rdim,zdim-rdim]) sphere(r=rdim);
    translate([rdim,ydim-rdim,zdim-rdim]) sphere(r=rdim);
    translate([xdim-rdim,ydim-rdim,zdim-rdim]) sphere(r=rdim);
  }
};
//roundedCube(40,30,20,2);
