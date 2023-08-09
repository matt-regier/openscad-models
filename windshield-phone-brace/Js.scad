$fn=36; // set to 360 for final render

show_mount=true;

// my extension of the concept
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

// mount_foot_width=70+3;//test print done at 70
// mount_foot_depth=600;//test print done at 600
// mount_foot_height=20+3;//test print done at 20

// mount_leg_width=50;
// mount_leg_depth=80;
// mount_leg_height=900;

bracket_thickness=10;

radius=1;

inner_shaft_width=22.2;
inner_shaft_height=12.6;
inner_shaft_depth=55;
outer_shaft_width=29.6;
outer_shaft_height=20.2;
outer_shaft_depth=55;
outer_lip_depth=3.6;

module mount() {
  translate([-inner_shaft_width/2,0,0]) 
  {
    cube([inner_shaft_width,inner_shaft_depth,inner_shaft_height]);
  }
  translate([-outer_shaft_width/2,outer_shaft_depth*3/4,0]) 
  {
    cube([outer_shaft_width,outer_shaft_depth,outer_shaft_height]);
  }
  translate([-outer_shaft_width/2,-outer_lip_depth,0]) 
  {
    cube([outer_shaft_width,outer_lip_depth,outer_shaft_height]);
  }
    //cube([outer_shaft_width,outer_shaft_depth,outer_shaft_height]);
  //   translate([bracket_thickness+half_width_delta,-1/8*table_foot_depth,bracket_thickness]) {
  //   color("Blue") {
  //     cube([table_foot_width,table_foot_depth,table_foot_height]);
  //     //translate([bracket_thickness,(table_foot_depth/2)-(table_leg_depth/2),0])
  //     //  cube([table_leg_width,table_leg_depth,table_leg_height]);
  //   }
  // }
}

module bracket() {
  // module bracketside() {
  //   roundedCube(
  //     bracket_thickness,
  //     //battery_depth+2*bracket_thickness,
  //     2.5*bracket_thickness,
  //     table_foot_height+2*bracket_thickness,
  //     radius);
  // }
  // module bracketface() {
  //   roundedCube(
  //     table_foot_width+2*bracket_thickness,
  //     //battery_depth+2*bracket_thickness,
  //     2.5*bracket_thickness,
  //     bracket_thickness,
  //     radius);
  // }
  // /*translate([half_width_delta,0,0])*/{
  //   bracketside();
  //   translate([bracket_thickness+table_foot_width,0,0]) bracketside();
  //   bracketface();
  //   translate([0,0,bracket_thickness+table_foot_height]) bracketface();
  // }
}

if (show_mount) {
  mount();
}
module brace() {
  //bracket();
}
brace();
//cube([inner_shaft_width,inner_shaft_depth,inner_shaft_height]);
