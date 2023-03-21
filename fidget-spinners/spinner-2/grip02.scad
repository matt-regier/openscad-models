// $fn=360/2;

edge_radius=1;

nozzle_diameter=0.4;
walls=4;

grip_diameter=25-(nozzle_diameter*walls*2);
grip_radius=grip_diameter/2;
thumbprint=50;

bushing_diameter=12;
bushing_radius=bushing_diameter/2;
bushing_height=1;

bearing_inner_diameter=8;
bearing_inner_radius=bearing_inner_diameter/2;

tab_diameter=bearing_inner_diameter*3/4;//*1/2;
tab_radius=tab_diameter/2;

post_height=7.2;
bevel_factor=15/16;

module indent() {
  color("yellow") {
    translate([0,0,-thumbprint*0.98]) sphere(r=thumbprint);
  }
}

module grip_disc() {
  difference() {
    rotate_extrude() {
      translate([grip_radius-edge_radius,edge_radius,0]) circle(r=edge_radius);
      square([grip_radius-edge_radius,edge_radius*2]);
    }
    //indent();
  }
}

module planes() {
  linear_extrude(height=0.01)  square(size=100, center=true);
  translate([0,0,1]) linear_extrude(height=0.01)  square(size=100, center=true);
}

module bushing () {
  translate([0,0,edge_radius*2])
    cylinder(h=bushing_height, r=bushing_radius);
}

module slot() {
  translate([0,0,bushing_height+edge_radius*2]) {
    difference() {
        intersection() {
            cylinder(h=post_height, r=bearing_inner_radius); // slot
            cylinder(h=post_height, r1=bearing_inner_radius*2, r2=bearing_inner_radius*bevel_factor); // bevel
        }
        cylinder(h=post_height, r=tab_radius); // tab space
    }
  }
}

module tab() {
    translate([0,0,bushing_height+edge_radius*2]) {
        intersection() {
            cylinder(h=post_height, r=tab_radius); // tab
            cylinder(h=post_height, r1=tab_radius*2, r2=tab_radius*bevel_factor); // bevel
        }
    }
}

module upper_grip() {
  grip_disc();  
  bushing();
  slot();
}
translate([grip_diameter*0.51,0,0]) upper_grip();

module lower_grip() {
  grip_disc();  
  bushing();
  tab();
}
translate([-grip_diameter*0.51,0,0]) lower_grip();
