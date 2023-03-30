echo(version=version());

//echo(hey=74/2);

module CupBase() {
color("gray")
    rotate_extrude($fn = 360)
        polygon( points=[
[0,0], // center bottom
[37,0], // outer bottom edge
//[39,50], // under lip (original)
[46-4,50-6], // under lip (angled)
[46,50], // outer bottom lip
[46,55], // outer top lip
[37,55], // inner top lip
[37,53], // notch 1

//[39,53], // notch 2 attempt 1
//[39,51], // notch 3 attempt 1

[39,52], // notch 2&3 attempt 2

[37,51], // notch 4
[35,2], // inner bottom edge
[0,2], // center top
[0,2] // end
        ] );
}
CupBase();

gap = 0.2;

inside_bottom_x = 37;
inside_bottom_y = 0;
echo(inside_bottom_x=inside_bottom_x);
echo(inside_bottom_y=inside_bottom_y);

inside_midpoint_x = ((37+42)/2);
inside_midpoint_y = ((0+44)/2);
echo(inside_midpoint_x=inside_midpoint_x);
echo(inside_midpoint_y=inside_midpoint_y);

factor = 1.25;
outside_midpoint_x = inside_midpoint_x+(2*factor);
outside_midpoint_y = inside_midpoint_y-(3*factor);
echo(outside_midpoint_x=outside_midpoint_x);
echo(outside_midpoint_y=outside_midpoint_y);

outside_bottom_x = 84/2;
outside_bottom_y = 0;
echo(outside_bottom_x=outside_bottom_x);
echo(outside_bottom_y=outside_bottom_y);

module CupShim() {
color("red")
    rotate_extrude($fn = 360)
        polygon( points=[
[inside_bottom_x+gap,inside_bottom_y],
[inside_midpoint_x+gap,inside_midpoint_y],
[outside_midpoint_x,outside_midpoint_y],
[outside_bottom_x,outside_bottom_y],
        ] );
}
CupShim();


// rotate_extrude() rotates a 2D shape around the Z axis. 
// Note that the 2D shape must be either completely on the 
// positive or negative side of the X axis.
module basicExample() {
color("red")
    rotate_extrude()
        translate([15, 0])
            square(5);
}

// rotate_extrude() uses the global $fn/$fa/$fs settings, but
// it's possible to give a different value as parameter.
module renderingOptions() {
color("cyan")
    translate([40, 0, 0])
        rotate_extrude($fn = 80)
            text("  J");
}

// Using a shape that touches the X axis is allowed and produces
// 3D objects that don't have a hole in the center.
module SolidObjects() {
color("green")
    translate([0, 30, 0])
        rotate_extrude($fn = 80)
            polygon( points=[[0,0],[8,4],[4,8],[4,12],[12,16],[0,20]] );
}


// By default rotate_extrude forms a full 360 degree circle, 
// but a partial rotation can be performed by using the angle parameter.
// Positive angles create an arc starting from the X axis, going counter-clockwise.
// Negative angles generate an arc in the clockwise direction.
module ReverseRotation () {
color("magenta") 
  translate([40,40]){
    rotate_extrude(angle=180)
      translate([12.5,0])
        square(5);
    translate([7.5,0])
      rotate_extrude(angle=180)
        translate([5,0])
          square(5);
    translate([-7.5,0])
      rotate_extrude(angle=-180)
        translate([5,0])
          square(5);
  }
 }


// Written in 2015 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
