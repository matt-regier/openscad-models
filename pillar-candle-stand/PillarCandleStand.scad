$fn=72;
echo(version=version());

show3d=true;
candle_diameter=80;
candle_radius=candle_diameter/2;
candle_radius_with_spacing=candle_radius+1;

module CandleBase() {
  // rotate_extrude() {
    layer_elevation=45;
    translate([candle_radius_with_spacing,layer_elevation]) circle(5/2);

    translate([15, 0]) square(5);
    polygon( points=[
      [2,0],
      [4,0],
      [4,4],
      [2,4]
    ] );


  // }
}

if (show3d) {
  rotate_extrude() CandleBase();
} else
{
  CandleBase();
}

module AngleDemo() {
color("cyan")
  rotate_extrude(angle=90)
    text("Joanna");
  rotate([0,0,180])
    rotate_extrude(angle=-90)
      text("Matthew");
}
// translate([50,0,0]) AngleDemo();