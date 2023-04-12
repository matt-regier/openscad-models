$fn = 16;
debug=true;

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

if (debug) {
    echo(base_x=base_x);
    echo(base_y=base_y);
    echo(base_z=base_z);
    echo(back_plate_x=back_plate_x);
    echo(phone_y=phone_y);
    echo(back_plate_y=back_plate_y);
    echo(back_plate_z=back_plate_z);
}

rounded_corners=0.5;

base_x=45;
base_y=50;
base_z=21;
module baseTab() {
    // baseTab
    translate([-base_x/2,0,0]) roundedCube(base_x, base_y, base_z, rounded_corners);
}

wall=2;
wiggle=1;
phone_x=75.5;
phone_y=151;
phone_z=11;

back_plate_x=phone_x+wiggle+2*wall;
back_plate_y=phone_y/2+wall;
back_plate_z=wall;
module backPlate() {
    back_plate_z_offset=base_z-wall;
    // backPlate
    translate([-back_plate_x/2,base_y,back_plate_z_offset]) roundedCube(back_plate_x, back_plate_y, back_plate_z, rounded_corners);
    // overlap between baseTab and backPlate
    translate([-base_x/2,base_y-1,back_plate_z_offset]) roundedCube(base_x, 2, back_plate_z, rounded_corners);
}

shelf_plate_x=2/5*phone_x;
shelf_plate_y=wall;
shelf_plate_z=phone_z+wiggle+2*wall;
module shelfPlate() {
    shelf_plate1_x_offset=back_plate_x/2-shelf_plate_x;
    shelf_plate2_x_offset=-back_plate_x/2;
    shelf_plate_y_offset=base_y;
    shelf_plate_z_offset=base_z-wall;
    translate([shelf_plate1_x_offset,shelf_plate_y_offset,shelf_plate_z_offset]) roundedCube(shelf_plate_x, shelf_plate_y, shelf_plate_z, rounded_corners);
    translate([shelf_plate2_x_offset,shelf_plate_y_offset,shelf_plate_z_offset]) roundedCube(shelf_plate_x, shelf_plate_y, shelf_plate_z, rounded_corners);
}

side_plate_x=wall;
side_plate_y=phone_y/4+wall;
side_plate_z=phone_z+wiggle+2*wall;
module sidePlates() {
    side_plate1_x_offset=-back_plate_x/2;
    side_plate2_x_offset=back_plate_x/2-wall;
    side_plate_y_offset=base_y;
    side_plate_z_offset=base_z-wall;
    translate([side_plate1_x_offset,side_plate_y_offset,side_plate_z_offset]) roundedCube(side_plate_x, side_plate_y, side_plate_z, rounded_corners);
    translate([side_plate2_x_offset,side_plate_y_offset,side_plate_z_offset]) roundedCube(side_plate_x, side_plate_y, side_plate_z, rounded_corners);
}

thumb_plate_x=5;
thumb_plate_y=phone_y/4+wall;
thumb_plate_z=wall;
module fauxThumbs() {
    thumb_plate1_x_offset=-back_plate_x/2;
    thumb_plate2_x_offset=back_plate_x/2-thumb_plate_x;
    thumb_plate_y_offset=base_y;
    thumb_plate_z_offset=base_z+phone_z+wiggle;
    translate([thumb_plate1_x_offset,thumb_plate_y_offset,thumb_plate_z_offset]) roundedCube(thumb_plate_x, thumb_plate_y, thumb_plate_z, rounded_corners);
    translate([thumb_plate2_x_offset,thumb_plate_y_offset,thumb_plate_z_offset]) roundedCube(thumb_plate_x, thumb_plate_y, thumb_plate_z, rounded_corners);
}

module phoneGrip() {
    backPlate();
    shelfPlate();
    sidePlates();
    fauxThumbs();
}

module complete() {
    baseTab();
    phoneGrip();
}

complete();
