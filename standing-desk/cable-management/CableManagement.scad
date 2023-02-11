$fn=36; // set to 360 for final render

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

module table() {
  desk_mount_width=68.6;
  desk_mount_depth=50;
  desk_mount_height=5.5;
  desk_back_panel_depth=10;
  desk_back_panel_height=50;
  screw_diameter=10;
  screw_radius=screw_diameter/2;
  screw_height=90;
  knob_diameter=60;
  knob_radius=knob_diameter/2;
  knob_height=25;

  color("Blue") {
    translate([0,desk_mount_depth,0]) cube([desk_mount_width,desk_back_panel_depth,desk_back_panel_height]);
    cube([desk_mount_width,desk_mount_depth,desk_mount_height]);
  }
  color("Green") {
    translate([desk_mount_width/2,3*screw_radius,-screw_height+screw_diameter]) cylinder(h = screw_height, r = screw_radius);
    translate([desk_mount_width/2,3*screw_radius,-screw_height-knob_height+screw_diameter]) cylinder(h = knob_height, r = knob_radius);
  }
}

translate([65,50,150]) table();

module mount() {
  color("Red") {

  }
}
mount();
