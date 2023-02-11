$fn=360;

debug=true;
verbose=false;

shim_diameter=80;
shim_radius=shim_diameter/2;

/*
85.5 mm height(1) 
80 mm width
3 mm height(2)
*/
bracket_span=88.5;
table_span=2.54*10;
shim_height=bracket_span-table_span;

// hollow_ratio=1/16;
// hollow_ratio=2/16; // 1/8
// hollow_ratio=3/16;
// hollow_ratio=4/16; // 1/4
// hollow_ratio=5/16;
// hollow_ratio=6/16; // 3/8
hollow_ratio=7/16;
// hollow_ratio=8/16; // 1/2
// hollow_ratio=9/16;
// hollow_ratio=10/16; // 5/8
// hollow_ratio=11/16;
// hollow_ratio=12/16; // 3/4
// hollow_ratio=13/16;
// hollow_ratio=14/16; // 7/8
// hollow_ratio=15/16;

post_diameter=35;
post_radius=post_diameter/2;

brace_hollow=shim_radius*hollow_ratio;
brace_thickness=shim_radius-brace_hollow;

filament_saver=7.5;

if (debug) {
  echo("bracket_span", bracket_span);
  echo("table_span", table_span);
  echo("shim_height", shim_height);
  echo("shim_width", shim_diameter);  
  if (verbose) {
    old_shim_height=(2.5*2.54*10)-1;
    echo("old_shim_height", old_shim_height);
    echo("shim_height_inches", shim_height/10/2.54);
    echo("shim_width_inches", shim_diameter/10/2.54);
  }
  echo("brace_hollow", brace_hollow);
  echo("brace_thickness", brace_thickness);
  echo("post_radius", post_radius);
}

module shim() {
  difference() {
    union() { // base shape
      cylinder(shim_height, shim_radius, shim_radius);
      translate([-shim_radius,0,0]) cube([2*shim_radius,shim_radius,shim_height]);
    }
    { // post hole
      // translate([0,0,-1/2*shim_height]) cylinder(2*shim_height, shim_radius*hollow_ratio, shim_radius*hollow_ratio); // calculated on hollow_ratio=7/16 (which should match post_radius)
      translate([0,0,-1/2*shim_height]) cylinder(2*shim_height, post_radius, post_radius); // calculated on post_radius (which should match hollow_ratio=7/16)
    }
    { // filament saver
      translate([-post_radius-filament_saver,post_radius+filament_saver,-1]) cylinder(shim_height+2, filament_saver, filament_saver);
      translate([+post_radius+filament_saver,post_radius+filament_saver,-1]) cylinder(shim_height+2, filament_saver, filament_saver);
    }
  }  
}
shim();

module post() {
  color(c = "Blue") {
    translate([0,0,-1/2*shim_height]) cylinder(2*shim_height, post_radius, post_radius);  
  }
}
// post();
