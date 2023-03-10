spinner_height=8;
spinner_half_height=spinner_height/2;
spinner_quarter_height=spinner_height/4;
spinner_diameter=60;
spinner_radius=spinner_diameter/2;

bearing_outer_radius=6;
bearing_inner_radius=4;

module bearing() {
  color("blue") {
    difference() {
      cylinder(h=spinner_height, r1=bearing_outer_radius, r2=bearing_outer_radius);
      translate([0,0,-1]) cylinder(h=spinner_height+2, r1=bearing_inner_radius, r2=bearing_inner_radius);
    }
  }
}

module rim() {
    rotate_extrude() {
        translate([spinner_radius-spinner_half_height,spinner_half_height,0]) circle(r=spinner_half_height);
    }
}

module housing() {
    cylinder(h=spinner_height, r1=8, r2=8);
}

FatSpokePoints = [
  [ spinner_half_height, 0, 0 ], // 0 bottom-right
  [ -spinner_half_height, 0, 0 ], // 1 bottom-left
  [ 0, spinner_radius, spinner_half_height ], // 2 apex
  [ spinner_half_height, 0, spinner_height ], // 3 top-right
  [ -spinner_half_height, 0, spinner_height ] // 4 top-left
];
FatSpokeFaces = [
  [0,2,1], // bottom
  [0,2,3], // right
  [1,2,4], // left
  [3,2,4]  // top
];
// translate([-10,0,0]) polyhedron( FatSpokePoints, FatSpokeFaces );
module fatSpokes() {
  spokes=4;
  for (angle = [0 : 360 / spokes : 360]) {
    rotate([0,0,angle]) translate([0,0,0]) polyhedron( FatSpokePoints, FatSpokeFaces );
  }
}

ThinSpokePoints = [
  [  spinner_quarter_height,  0,  spinner_quarter_height ],  // 0 bottom-right
  [ -spinner_quarter_height,  0,  spinner_quarter_height ],  // 1 bottom-left
  [  0, 24,  spinner_half_height ],  // 2 apex
  [  spinner_quarter_height,  0,  spinner_height-spinner_quarter_height ],  // 3 top-right
  [ -spinner_quarter_height,  0,  spinner_height-spinner_quarter_height ]   // 4 top-left
];
ThinSpokeFaces = [
  [0,2,1], // bottom
  [0,2,3], // right
  [1,2,4], // left
  [3,2,4]  // top
];
// translate([10,0,0]) polyhedron( ThinSpokePoints, ThinSpokeFaces );
module thinSpokes() {
  spokes=4;
  starting=45;
  // This is cool, too.
  // spokes=8;
  // starting=360/16;
  for (angle = [starting : 360 / spokes : 360]) {
    echo("angle", angle);
    rotate([0,0,angle]) translate([0,0,0]) polyhedron( ThinSpokePoints, ThinSpokeFaces );
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
  // ridges();
  // bearingSpace();
  // translate([0,0,-spinner_height]) cylinder(h=3*spinner_height, r1=bearing_outer_radius, r2=bearing_outer_radius);
}

module spinner() {
  difference() {
    spinner_positives();
    spinner_negatives();
  }
}
spinner();

// bearing();
