// Module instantiation
//LetterBlock("M");

frame_x = 140;
frame_y = 40;
frame_z = 10;
echo(frame_x=frame_x);
echo(frame_y=frame_y);
echo(frame_z=frame_z);

hollowsert = 5;
hollowsert_x = frame_x - (hollowsert * 2);
hollowsert_y = frame_y - (hollowsert * 2);
hollowsert_z = hollowsert;

echo(hollowsert_x=hollowsert_x);
echo(hollowsert_y=hollowsert_y);
echo(hollowsert_z=hollowsert_z);

module Frame() {
    difference() {
        cube([frame_x, frame_y, frame_z]);
        translate([hollowsert,hollowsert,frame_z-hollowsert_z])
            cube([hollowsert_x, hollowsert_y, hollowsert_z]);
        // punch a hole through the center
        //translate([55,10,0])
        //    cube([10, 10, 100]);
        // see what's underneath
        //translate([-200,-200,0])
        //    cube([400, 400, 5]);
    }
}

inset_x = 20;
inset_y = 2;
inset1_z = 6;
inset2_z = 3.5;

module Inset() {
//    translate([hollowsert,hollowsert,frame_z-hollowsert_z])
    cube([inset_x, inset_y, inset1_z]);
    translate([0,inset_y,0])
        cube([inset_x, inset_y, inset2_z]);
    for (a = [ 0.2 : 2.1 : 18 ])
        translate([a, inset_y, inset2_z])
            rotate([0,45,0])
                cube(2);
}

module Ridges() {
    translate([0,-20,0])
        cylinder(h=3,r=8);
}

difference() {
    Frame();
    translate([(frame_x/2)-(inset_x/2),(frame_y-8),inset_y*2])
        rotate([270,0,0])
                Inset();
}
    
echo(version=version());

// Functions can be defined to simplify code using lots of
// calculations.

module SimpleFunction() {
// Simple example with a single function argument (which should
// be a number) and returning a number calculated based on that.
function f(x) = 0.5 * x + 1;

color("red")
    for (a = [ -25 : 5 : 25 ])
        translate([a, f(a), 0]) cube(2, center = true);
}

module ComplexFunction() {
// Functions can call other functions and return complex values
// too. In this case a 3 element vector is returned which can
// be used as point in 3D space or as vector (in the mathematical
// meaning) for translations and other transformations.
//function g(x) = [ 5 * x + 20, f(x) * f(x) - 50, 0 ];

//color("green")
    //for (a = [ -200 : 10 : 200 ])
        //translate(g(a / 8)) sphere(1);
}

// Module definition.
// size=30 defines an optional parameter with a default value.
module LetterBlock(letter, size=30) {
    difference() {
        translate([0,0,size/4]) cube([size,size,size/2], center=true);
        translate([0,0,size/6]) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=size, convexity=4)
                text(letter, 
                     size=size*22/30,
                     font="Bitstream Vera Sans",
                     halign="center",
                     valign="center");
        }
    }
}
