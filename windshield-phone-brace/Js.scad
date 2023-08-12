$fn=36; // set to 360 for final render

debug=true;
show_mount=true;

// @thejollygrimreaper's https://www.youtube.com/watch?v=gKOkJWiTgAY
module roundedTile(xdim, ydim, zdim, rdim) {
  hull() {
    translate([rdim,rdim,0]) cylinder(r=rdim,h=zdim);
    translate([xdim-rdim,rdim,0]) cylinder(r=rdim,h=zdim);
    translate([rdim,ydim-rdim,0]) cylinder(r=rdim,h=zdim);
    translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim,h=zdim);
  }
};
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

edge_radius=1;

inner_shaft_width=22.2;
inner_shaft_height=12.6;
inner_shaft_depth=55;
outer_shaft_width=29.6;
outer_shaft_height=20.2;
outer_shaft_depth=55;
outer_lip_depth=3.6;
outer_shaft_height_offset=(outer_shaft_height-inner_shaft_height)/2;
joint_depth=38;
joint_diameter=26;
joint_radius=joint_diameter/2;
back_plate_width=38;
back_plate_height=76;
back_plate_depth=10;
front_plate_width=58;
front_plate_height=96;
front_plate_depth=10;
coil_housing_diameter=28;
coil_housing_radius=coil_housing_diameter/2;
coil_housing_depth=15;
coil_housing_height=33.5;

if (debug && show_mount) {
  echo("inner_shaft_width", inner_shaft_width);
  echo("inner_shaft_height", inner_shaft_height);
  echo("inner_shaft_depth", inner_shaft_depth);
  echo("outer_shaft_width", outer_shaft_width);
  echo("outer_shaft_height", outer_shaft_height);
  echo("outer_shaft_depth", outer_shaft_depth);
  echo("outer_lip_depth", outer_lip_depth);
  echo("outer_shaft_height_offset", outer_shaft_height_offset);
  echo("joint_depth", joint_depth);
  echo("joint_diameter", joint_diameter);
  echo("joint_radius", joint_radius);
  echo("back_plate_width", back_plate_width);
  echo("back_plate_height", back_plate_height);
  echo("back_plate_depth", back_plate_depth);
  echo("front_plate_width", front_plate_width);
  echo("front_plate_height", front_plate_height);
  echo("front_plate_depth", front_plate_depth);
  echo("coil_housing_diameter", coil_housing_diameter);
  echo("coil_housing_radius", coil_housing_radius);
  echo("coil_housing_depth", coil_housing_depth);
  echo("coil_housing_height", coil_housing_height);
}

module mount() {
  // outer shaft
  translate([-outer_shaft_width/2,outer_shaft_depth*3/4,-outer_shaft_height_offset]) 
    cube([outer_shaft_width,outer_shaft_depth,outer_shaft_height]);
  // inner shaft
  translate([-inner_shaft_width/2, 0, 0]) 
    cube([inner_shaft_width,inner_shaft_depth,inner_shaft_height]);
  // outer front lip
  offset0 = -outer_lip_depth;
  translate([-outer_shaft_width/2,offset0,-outer_shaft_height_offset]) 
    cube([outer_shaft_width,outer_lip_depth,outer_shaft_height]);
  // ball joint placeholder
  offset1 = offset0-0;
  translate([0,offset1,inner_shaft_height/2])
    rotate([90, 0, 0])
      cylinder(h = joint_depth, r = joint_radius);
  // back plate
  offset2 = offset1 - joint_depth;
  translate([-back_plate_width/2,offset2,-back_plate_height*3/4])
    rotate([90, 0, 0])
      roundedTile(back_plate_width, back_plate_height, back_plate_depth, edge_radius);
  // front plate
  offset3 = offset2 - back_plate_depth;
  translate([-front_plate_width/2,offset3,-front_plate_height*11/16])
    rotate([90, 0, 0])
      roundedTile(front_plate_width, front_plate_height, front_plate_depth, edge_radius);
  // coil housing
  color("grey") translate([0,offset2+coil_housing_depth,-20.5-4.5])
    rotate([90, 0, 0])
      union() {
        cylinder(h = coil_housing_depth, r = coil_housing_radius);
        translate([0,coil_housing_depth-coil_housing_diameter,0])
          cylinder(h = coil_housing_depth, r = coil_housing_radius);
      }
}

strut_thickness=5;
top_plate_width=inner_shaft_width+2*strut_thickness;
top_plate_depth=25; // made up value, gl;hf
strut_height=60; // made up value, gl;hf
arm_width=strut_thickness;
arm_height=top_plate_depth; // made up transitively
arm_depth=top_plate_depth+outer_lip_depth+joint_depth;

if (debug) {
  echo("strut_thickness", strut_thickness);
  echo("top_plate_width", top_plate_width);
  echo("top_plate_depth", top_plate_depth);
  echo("strut_height", strut_height);
  echo("arm_width", arm_width);
  echo("arm_height", arm_height);
  echo("arm_depth", arm_depth);
}
module mount_brace() {
  module strut_plate() {
    translate([-top_plate_width/2, 0, 0])
      roundedCube(top_plate_width, top_plate_depth, strut_thickness, edge_radius);
  }
  // top plate
  translate([0,0,inner_shaft_height]) strut_plate();
  // mid plate
  translate([0,0,-strut_thickness]) strut_plate();
  // mid plate
  translate([0,0,-strut_height+inner_shaft_height+strut_thickness/2]) strut_plate();
  module strut() {
    translate([-strut_thickness/2,0,-strut_height+inner_shaft_height+strut_thickness])
      roundedCube(strut_thickness, top_plate_depth, strut_height, edge_radius);
  }
  // left strut
  translate([-inner_shaft_width/2-strut_thickness/2, 0, 0]) strut();
  // right strut
  translate([inner_shaft_width/2+strut_thickness/2, 0, 0]) strut();
  module arm() {
    translate([-arm_width/2, -arm_depth+top_plate_depth, inner_shaft_height-strut_height+strut_thickness/2])
      roundedCube(arm_width, arm_depth, arm_height, edge_radius);
  }
  // left arm
  translate([-coil_housing_diameter/2-strut_thickness/2, 0, 0]) arm();
  // left arm
  translate([coil_housing_diameter/2+strut_thickness/2, 0, 0]) arm();
}

if (show_mount) {
  mount();
}
mount_brace();

// intersection() {
//   mount();
//   mount_brace();
// }