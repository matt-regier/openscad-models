$fn = 36; // increase for rotational smoothness

nozzle_diameter = 0.4;
walls = 4;

spinner_height = 7.2;
spinner_half_height = spinner_height/2;
spinner_quarter_height = spinner_height/4;
spinner_diameter = spinner_height*10;
spinner_radius = spinner_diameter/2;

bearing_outer_diameter = 21.9;
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
    groove_depth = 0.75;
    starting = 0;
    for (angle = [starting : 360 / grooves : 360]) {
      rotate([0,0,angle]) translate([spinner_radius+groove_radius-groove_depth,0,0]) cylinder(h = spinner_height, r = groove_radius);
    }
  }
}

module housing() {
    cylinder(h = spinner_height, r1 = housing_radius, r2 = housing_radius);
}

module spinner_positives() {
  rim();
  housing();
  fins();
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
bearing(); // visualization

internal_offset=30;
fin_height=60;
fin_width=40;

module splint() {
  rotate_extrude() {
    translate([internal_offset+spinner_half_height,0,0]) square([spinner_height,spinner_height]);
    translate([internal_offset+spinner_half_height,spinner_half_height,0]) circle(r = spinner_half_height);
  }
}
// splint();

module fin() {
  rotate([0,0,-90])
  translate([0,1/2*fin_height,0]) 
  intersection() {
    union() {
      translate([internal_offset*1.25,0,0]) splint();
      translate([-internal_offset*1.25,0,0]) splint();
    }
    translate([-1/2*fin_width,-1/2*fin_height,0]) cube([fin_width,fin_height,spinner_height]);
  }
}
// fin();

module fins() {
  fins = 4;
  starting = 0;
  for (angle = [starting : 360 / fins : 360]) {
    rotate([0,0,angle]) fin();
  }
}
// fins();
