debug=false;
echo("$fn", $fn);
$fn=180; // increase for rotational smoothness

spinner_height=8;
spinner_half_height=spinner_height/2;
spinner_quarter_height=spinner_height/4;
spinner_diameter=60;
spinner_radius=spinner_diameter/2;

bearing_outer_radius=6;
bearing_inner_radius=4;
housing_radius=bearing_outer_radius+0.4;

// function f(x) = (housing_radius + bearing_outer_radius) / 2;
// function g() = (housing_radius + bearing_outer_radius) / 2;
// hey=f(0);
// echo("hey", hey);
// hey2=g();
// echo("hey2", hey2);

// function spokeStart() = (housing_radius + bearing_outer_radius) / 2;
// function spokeStart() = bearing_outer_radius*(1+1/3);
function spokeStart() = 0;

if (debug) {
  echo("spokeStart()", spokeStart());
}

module bearing() {
  color("blue") {
    difference() {
      cylinder(h=spinner_height, r1=bearing_outer_radius, r2=bearing_outer_radius);
      translate([0,0,-1]) cylinder(h=spinner_height+2, r1=bearing_inner_radius, r2=bearing_inner_radius);
    }
    difference() {
      cylinder(h=spinner_height, r1=bearing_outer_radius-3, r2=bearing_outer_radius-3);
      translate([0,0,-1]) cylinder(h=spinner_height+2, r1=bearing_inner_radius-3, r2=bearing_inner_radius-3);
    }
  }
}

module bearingNegative() {
  color("green") {
    translate([0,0,-spinner_height]) cylinder(h=3*spinner_height, r1=bearing_outer_radius, r2=bearing_outer_radius);
  }
}

module rim() {
    rotate_extrude() {
        translate([spinner_radius-spinner_half_height,spinner_half_height,0]) circle(r=spinner_half_height);
    }
}

module ridges() {
  grooves=36;
  groove_radius=3;
  groove_depth=1;
  starting=0;
  for (angle = [starting : 360 / grooves : 360]) {
    rotate([0,0,angle]) translate([spinner_radius+groove_radius-groove_depth,0,0]) cylinder(h = spinner_height, r = groove_radius);
  }
}

module housing() {
    cylinder(h=spinner_height, r1=housing_radius, r2=housing_radius);
}

fat_spoke_height=spinner_height*1.075;
fat_spoke_midpoint=fat_spoke_height/2;
FatSpokePoints = [
  [fat_spoke_midpoint, spokeStart(), 0], // 0 bottom-right
  [-fat_spoke_midpoint, spokeStart(), 0], // 1 bottom-left
  [0, spinner_radius, fat_spoke_midpoint], // 2 apex
  [fat_spoke_midpoint, spokeStart(), fat_spoke_height], // 3 top-right
  [-fat_spoke_midpoint, spokeStart(), fat_spoke_height] // 4 top-left
];
FatSpokeFaces = [
  [0,2,1],  // bottom
  [3,2,0],  // right
  [1,2,4],  // left
  [4,2,3],  // top
  [3,0,1,4] // back
];
// translate([-7.5,0,0]) {
//   polyhedron(FatSpokePoints, FatSpokeFaces);
//   color("yellow") {
//     for (idx = [ 0 : len(FatSpokePoints) - 1 ] ) {
//       echo("FatSpokePoints", idx, FatSpokePoints[idx]);
//       translate(FatSpokePoints[idx]) rotate([90,0,0]) linear_extrude(height=0.2) text(text=str(idx), size=2);
//     }
//   }
// }
module fatSpokes() {
  spokes=4;
  starting=0;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) polyhedron(points=FatSpokePoints, faces=FatSpokeFaces);
  }
}

ThinSpokePoints = [
  [spinner_quarter_height, spokeStart(), spinner_quarter_height], // 0 bottom-right
  [-spinner_quarter_height, spokeStart(), spinner_quarter_height], // 1 bottom-left
  [0, spinner_radius-spinner_half_height, spinner_half_height], // 2 apex
  [spinner_quarter_height, spokeStart(), spinner_height-spinner_quarter_height], // 3 top-right
  [-spinner_quarter_height, spokeStart(), spinner_height-spinner_quarter_height] // 4 top-left
];
ThinSpokeFaces = [
  [0,2,1],  // bottom
  [3,2,0],  // right
  [1,2,4],  // left
  [4,2,3],  // top
  [3,0,1,4] // back
];
// translate([7.5,0,0]) {
//   polyhedron(ThinSpokePoints, ThinSpokeFaces);
//   color("yellow") {
//     for (idx = [ 0 : len(ThinSpokePoints) - 1 ] ) {
//       echo("ThinSpokePoints", idx, ThinSpokePoints[idx]);
//       translate(ThinSpokePoints[idx]) rotate([90,0,0]) linear_extrude(height=0.2) text(text=str(idx), size=2);
//     }
//   }
// }
module thinSpokes() {
  spokes=4;
  starting=45;
  // This is cool, too.
  // spokes=8;
  // starting=360/16;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) polyhedron(points=ThinSpokePoints, faces=ThinSpokeFaces);
  }
}

module spinner_positives() {
  union() {
    rim();
    housing();
    fatSpokes();
    thinSpokes();
  }
}

module spinner_negatives() {
  ridges();
  bearingNegative();
}
// ridges();
// bearingNegative();

module spinner() {
  difference() {
    spinner_positives();
    spinner_negatives();
  }
}
spinner();
// bearing();
