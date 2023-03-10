spinner_height=8;
spinner_half_height=spinner_height/2;
spinner_quarter_height=spinner_height/4;
spinner_diameter=60;
spinner_radius=spinner_diameter/2;

housing_radius=8;
bearing_outer_radius=6;
bearing_inner_radius=4;
// housing_radius=10;
// bearing_outer_radius=8;
// bearing_inner_radius=6;

// function f(x) = (housing_radius + bearing_outer_radius) / 2;
// function g() = (housing_radius + bearing_outer_radius) / 2;
// hey=f(0);
// echo("hey", hey);
// hey2=g();
// echo("hey2", hey2);

function spokeStart() = (housing_radius + bearing_outer_radius) / 2;
function moreStart() = bearing_outer_radius*(1+1/3);

echo("spokeStart()", spokeStart());
echo("moreStart()", moreStart());

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

module housing() {
    cylinder(h=spinner_height, r1=housing_radius, r2=housing_radius);
}

FatSpokePoints = [
  [spinner_half_height, spokeStart(), 0], // 0 bottom-right
  [-spinner_half_height, spokeStart(), 0], // 1 bottom-left
  [0, spinner_radius, spinner_half_height], // 2 apex
  [spinner_half_height, spokeStart(), spinner_height], // 3 top-right
  [-spinner_half_height, spokeStart(), spinner_height] // 4 top-left
] ;
FatSpokeFaces = [
  [0,2,1], // bottom
  [0,2,3], // right
  [1,2,4], // left
  [3,2,4], // top
  [1,3,4], // half back A
  [0,1,3]  // half back B
] ;
// translate([-10,0,0]) polyhedron(FatSpokePoints, FatSpokeFaces);
module fatSpokes() {
  spokes=4;
  starting=0;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) translate([0,0,0]) polyhedron(points=FatSpokePoints, faces=FatSpokeFaces);
  }
}

ThinSpokePoints = [
  [spinner_quarter_height, spokeStart(), spinner_quarter_height], // 0 bottom-right
  [-spinner_quarter_height, spokeStart(), spinner_quarter_height], // 1 bottom-left
  [0, 24, spinner_half_height], // 2 apex
  [spinner_quarter_height, spokeStart(), spinner_height-spinner_quarter_height], // 3 top-right
  [-spinner_quarter_height, spokeStart(), spinner_height-spinner_quarter_height] // 4 top-left
] ;
ThinSpokeFaces = [
  [0,2,1], // bottom
  [0,2,3], // right
  [1,2,4], // left
  [3,2,4], // top
  [1,3,4], // half back A
  [0,1,3]  // half back B
] ;
// translate([10,0,0]) polyhedron(ThinSpokePoints, ThinSpokeFaces);
module thinSpokes() {
  spokes=4;
  starting=45;
  // This is cool, too.
  // spokes=8;
  // starting=360/16;
  for (angle = [starting : 360 / spokes : 360]) {
    rotate([0,0,angle]) translate([0,0,0]) polyhedron(points=ThinSpokePoints, faces=ThinSpokeFaces);
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
  // bearingNegative(); // Why isn't this working?
}

module spinner() {
  difference() {
    spinner_positives();
    spinner_negatives();
  }
}
spinner();

// bearing();
