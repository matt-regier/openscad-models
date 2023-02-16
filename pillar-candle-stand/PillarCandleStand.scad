$fn=180;
echo(version=version());

show3d=false;
debug=true;
showCandle=false;

candle_height=9*2.54*10;
candle_diameter=74.5-2;
candle_radius=candle_diameter/2;
candle_radius_with_spacing=candle_radius+1;
if (debug) {
  echo("candle_radius_with_spacing", candle_radius_with_spacing);
}

module CreateLayer(radius, offset, height, zbase) {
  translate([0,zbase,0] ) {
    intersection() {
      translate([offset,0,0]) circle(radius);
      translate([0,-height/2,0]) square([100000, height]);
    }
  }
}

module CandleBase() {
  // rotate_extrude() {
    //layer_elevation=45;
    // translate([candle_radius_with_spacing+5/2,layer_elevation]) circle(5/2);

CreateLayer(radius=5, offset=40, height=10, zbase=0);
CreateLayer(radius=5, offset=30, height=10, zbase=10);
CreateLayer(radius=75, offset=-65, height=10, zbase=20);
  
    // translate([15, 0]) square(5);
    // polygon( points=[
    //   [2,0],
    //   [4,0],
    //   [4,4],
    //   [2,4]
    // ] );


  // }
}

if (show3d) {
  if (showCandle) color("White") cylinder(candle_height, candle_radius, candle_radius);
  rotate_extrude() CandleBase();
} else
{
  CandleBase();
}

module AngleDemo() {
color("cyan")
  rotate_extrude(angle=90)
    text("J");
  rotate([0,0,180])
    rotate_extrude(angle=-90)
      text("M");
}
// translate([50,0,0]) AngleDemo();