// $fn = 180; // increase for rotational smoothness

nozzle_diameter = 0.4;
walls = 4;

spinner_height = 7.2;
spinner_half_height = spinner_height/2;
spinner_quarter_height = spinner_height/4;
spinner_diameter = spinner_height*10;
spinner_radius = spinner_diameter/2;

bearing_outer_diameter = 21.8;
bearing_inner_diameter = 8;
bearing_outer_radius = bearing_outer_diameter/2;
bearing_inner_radius = bearing_inner_diameter/2;
housing_radius = bearing_outer_radius+(nozzle_diameter*walls);

module bearing() {
  color("blue") {
    difference() {
      cylinder(h = spinner_height, r1 = bearing_outer_radius, r2 = bearing_outer_radius);
      translate([0,0,-1]) cylinder(h = spinner_height+2, r1 = bearing_inner_radius, r2 = bearing_inner_radius);
    }
  }
}

module bearingNegative() {
  color("green") {
    translate([0,0,-spinner_height]) cylinder(h = 3*spinner_height, r1 = bearing_outer_radius, r2 = bearing_outer_radius);
  }
}

module rim() {
  rotate_extrude() {
    translate([spinner_radius-spinner_half_height,spinner_half_height,0]) circle(r = spinner_half_height);
  }
}

module ridges() {
  color("green") {
    grooves = 48;
    groove_radius = 3;
    groove_depth = 1;
    starting = 0;
    for (angle = [starting : 360 / grooves : 360]) {
      rotate([0,0,angle]) translate([spinner_radius+groove_radius-groove_depth,0,0]) cylinder(h = spinner_height, r = groove_radius);
    }
  }
}

module housing() {
    cylinder(h = spinner_height, r1 = housing_radius, r2 = housing_radius);
}

fat_spoke_height = spinner_height*1.075;
fat_spoke_midpoint = fat_spoke_height/2;
FatSpokePoints = [
  [fat_spoke_midpoint, 0, 0], // 0 bottom-right
  [-fat_spoke_midpoint, 0, 0], // 1 bottom-left
  [0, spinner_radius, fat_spoke_midpoint], // 2 apex
  [fat_spoke_midpoint, 0, fat_spoke_height], // 3 top-right
  [-fat_spoke_midpoint, 0, fat_spoke_height] // 4 top-left
];
FatSpokeFaces = [
  [0,2,1],  // bottom
  [3,2,0],  // right
  [1,2,4],  // left
  [4,2,3],  // top
  [3,0,1,4] // back
];
// debug
// translate([-7.5,0,0]) {
//   polyhedron(FatSpokePoints, FatSpokeFaces);
//   color("yellow") {
//     for (idx = [ 0 : len(FatSpokePoints) - 1 ] ) {
//       echo("FatSpokePoints", idx, FatSpokePoints[idx]);
//       translate(FatSpokePoints[idx]) rotate([90,0,0]) linear_extrude(height = 0.2) text(text = str(idx), size = 2);
//     }
//   }
// }
module fatSpokes() {
  spokes = 8;
  starting = 0;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) polyhedron(points = FatSpokePoints, faces = FatSpokeFaces);
  }
}

ThinSpokePoints = [
  [spinner_quarter_height, 0, spinner_quarter_height], // 0 bottom-right
  [-spinner_quarter_height, 0, spinner_quarter_height], // 1 bottom-left
  // [0, spinner_radius-spinner_half_height, spinner_half_height], // 2 apex
  [0, spinner_radius, spinner_half_height], // 2 apex
  [spinner_quarter_height, 0, spinner_height-spinner_quarter_height], // 3 top-right
  [-spinner_quarter_height, 0, spinner_height-spinner_quarter_height] // 4 top-left
];
ThinSpokeFaces = [
  [0,2,1],  // bottom
  [3,2,0],  // right
  [1,2,4],  // left
  [4,2,3],  // top
  [3,0,1,4] // back
];
// debug
// translate([7.5,0,0]) {
//   polyhedron(ThinSpokePoints, ThinSpokeFaces);
//   color("yellow") {
//     for (idx = [ 0 : len(ThinSpokePoints) - 1 ] ) {
//       echo("ThinSpokePoints", idx, ThinSpokePoints[idx]);
//       translate(ThinSpokePoints[idx]) rotate([90,0,0]) linear_extrude(height = 0.2) text(text = str(idx), size = 2);
//     }
//   }
// }
module thinSpokes() {
  spokes = 8;
  starting = 45/2;
  // This is cool, too...
  // spokes = 8;
  // starting = 360/16;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) polyhedron(points = ThinSpokePoints, faces = ThinSpokeFaces);
  }
}

module spinner_positives() {
  rim();
  housing();
  fatSpokes();
  thinSpokes();
}

module spinner_negatives() {
  ridges();
  bearingNegative();
}
// ridges(); // debug
// bearingNegative(); // debug

module spinner() {
  difference() {
    spinner_positives();
    spinner_negatives();
  }
}
spinner();
// bearing(); // visualization
