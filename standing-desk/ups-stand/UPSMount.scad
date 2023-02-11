module Base() {
translate(v = [1, 0, 2])
color("Pink")
//roundedcube([4, 2, 2], false, 0.6, "zmax");   
cube([4, 2, 2]);   
}
//Base();

//minkowski(3);
//border=5;
//minkowski(){
//cube([10,20,5],center=false);
//rotate([90,90,90]) cylinder(h=10,r=border);
//cylinder(h=0.1,r=border);
//}

$fn=64;
module roundedTile(xdim, ydim, zdim, rdim) {
  hull() {
    translate([rdim,rdim,0]) cylinder(r=rdim,h=zdim);
    translate([xdim-rdim,rdim,0]) cylinder(r=rdim,h=zdim);
    translate([rdim,ydim-rdim,0]) cylinder(r=rdim,h=zdim);
    translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim,h=zdim);
  }
};
//roundedTile(20,20,10,3);

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

table_foot_width=70+3;//test print done at 70
table_foot_depth=600;//test print done at 600
table_foot_height=20+3;//test print done at 20

table_leg_width=50;
table_leg_depth=80;
table_leg_height=900;

bracket_thickness=10;

radius=3;
battery_width=83+3;//test print done at 83
battery_depth=146+1;//test print done at 146
battery_height=245;//test print done at 245
battery_brace=170;

print_height=250-1;

//echo("print_height",print_height);
bracket_height=table_foot_height+2*bracket_thickness;
//echo("bracket_height",bracket_height);
overlap_amount=bracket_thickness;
//echo("overlap_amount",overlap_amount);
bucket_height=print_height-bracket_height+overlap_amount;
//echo("bucket_height",bucket_height);

// echo("table_foot_width",table_foot_width);
// echo("battery_width",battery_width);
width_delta=battery_width-table_foot_width;
// echo("width_delta",width_delta);
half_width_delta=(battery_width-table_foot_width)/2;
// echo("half_width_delta",half_width_delta);

module battery() {
  color("Black") {
      translate([bracket_thickness,bracket_thickness,table_foot_height+2*bracket_thickness])
        cube([battery_width,battery_depth,battery_height]);
  }
}

module table() {
    translate([bracket_thickness+half_width_delta,-1/8*table_foot_depth,bracket_thickness]) {
    color("Blue") {
      cube([table_foot_width,table_foot_depth,table_foot_height]);
      translate([bracket_thickness,(table_foot_depth/2)-(table_leg_depth/2),0])
        cube([table_leg_width,table_leg_depth,table_leg_height]);
    }
  }
}

module bracket() {
  module bracketside() {
    roundedCube(
      bracket_thickness,
      battery_depth+2*bracket_thickness,
      table_foot_height+2*bracket_thickness,
      radius);
  }
  module bracketface() {
    roundedCube(
      table_foot_width+2*bracket_thickness,
      battery_depth+2*bracket_thickness,
      bracket_thickness,
      radius);
  }
  translate([half_width_delta,0,0]){
    bracketside();
    translate([bracket_thickness+table_foot_width,0,0]) bracketside();
    bracketface();
    translate([0,0,bracket_thickness+table_foot_height]) bracketface();
  }
}

module bucket() {
  module longside() {
    roundedCube(
      battery_width+2*bracket_thickness,
      bracket_thickness,
      bucket_height,
      radius);
  }
  module solidface() {
    roundedCube(
      bracket_thickness,
      battery_depth+2*bracket_thickness,
      bucket_height,
      radius);
  }  
  color("Red") {
    translate([0,0,table_foot_height+bracket_thickness]) {
      longside();
      translate([0,battery_depth+bracket_thickness,0]) longside();
      solidface();
      translate([battery_width+bracket_thickness,0,0]) solidface();
    }
  }
}

module openbucket() {
  module shortside() {
    roundedCube(
      battery_width+bracket_thickness,
      bracket_thickness,
      bucket_height,
      radius);
  }  
  module solidface() {
    roundedCube(
      bracket_thickness,
      battery_depth+2*bracket_thickness,
      bucket_height,
      radius);
  }
  module frontbracket() {
    roundedCube(
      bracket_thickness,
      battery_depth+2*bracket_thickness,
      2*bracket_thickness,
      radius);
    translate([-bracket_thickness,0,0])
      roundedCube(
        2*bracket_thickness,
        bracket_thickness,
        2*bracket_thickness,
        radius);
    translate([-bracket_thickness,battery_depth+bracket_thickness,0])
      roundedCube(
        2*bracket_thickness,
        bracket_thickness,
        2*bracket_thickness,
        radius);
  }
  
  color("Yellow") {
    translate([0,0,table_foot_height+bracket_thickness]) {
      shortside();
      translate([0,battery_depth+bracket_thickness,0]) shortside();
      solidface();
      translate([battery_width+bracket_thickness,0,0]) frontbracket();
      translate([battery_width+bracket_thickness,0,battery_brace]) frontbracket();
    }
  }
}

//table();
//battery();
bracket();
openbucket();

//translate([0,battery_depth*2,0]) battery();
//translate([0,battery_depth*2,0]) bracket();
//translate([0,battery_depth*2,0]) bucket();
