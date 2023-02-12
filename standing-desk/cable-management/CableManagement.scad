$fn=36; // set to 360 for final render

showTable=true;

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

desk_mount_width=68.6;
desk_mount_height=5.5;
desk_mount_depth=50;
desk_back_panel_depth=10;
desk_back_panel_height=50;
screw_diameter=10;
screw_radius=screw_diameter/2;
screw_height=90;
knob_diameter=60;
knob_radius=knob_diameter/2;
knob_height=25;
spacing=2;
thickness=8;
radius=3;
open_height=knob_height;
connect_spacing=open_height+10;
connect_height=connect_spacing+10;
link_height=desk_mount_height+2*thickness;

module table() {

  color("Blue") {
    translate([0,desk_mount_depth,0]) cube([desk_mount_width,desk_back_panel_depth,desk_back_panel_height]);
    cube([desk_mount_width,desk_mount_depth,desk_mount_height]);
  }
  color("Green") {
    translate([desk_mount_width/2,3*screw_radius,-screw_height+screw_diameter]) cylinder(h = screw_height, r = screw_radius);
    translate([desk_mount_width/2,3*screw_radius,-screw_height-knob_height+screw_diameter]) cylinder(h = knob_height, r = knob_radius);
  }
}

if (showTable) {
  translate([thickness+spacing,-40,150]) table();
}

l_width=desk_mount_width+2*spacing+2*thickness;
module repeatableL() {
  roundedCube(l_width,thickness,thickness,radius);
  translate([thickness,0,0]) rotate([0,-90,0]) roundedCube(open_height,thickness,thickness,radius);
  translate([l_width,0,0]) rotate([0,-90,0]) roundedCube(connect_height,thickness,thickness,radius);
}
module flippedL() {
  translate([l_width,0,0]) mirror([1,0,0]) repeatableL();
}
module chainLink() {
  module topBar() {
    translate([0,0,thickness+desk_mount_height+spacing]) roundedCube(l_width,thickness,thickness,radius);
  }
  down_shift=2*thickness+desk_mount_height+spacing;
  module rung() {
    roundedCube(l_width,thickness,thickness,radius); // bottom bar
    roundedCube(thickness,thickness,down_shift,radius); // left side
    translate([desk_mount_width+2*spacing+thickness,0,0]) roundedCube(thickness,thickness,down_shift,radius); // right side
  }
  topBar();
  rung();
  translate([0,0,-down_shift+thickness]) rung();
  translate([0,0,2*(-down_shift+thickness)]) rung();
}

module mount() {
  color("Red") {
    // translate([0,0,connect_spacing*0]) repeatableL();
    // translate([0,0,connect_spacing*1]) flippedL();
    // translate([0,0,connect_spacing*2]) repeatableL();
    // translate([0,0,connect_spacing*3]) flippedL();
    translate([0,0,connect_spacing*2+5]) repeatableL();
    translate([0,0,connect_spacing*4]) chainLink();
  }
}
mount();
