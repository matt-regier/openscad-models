$fn=360;
test_radius=7.5*10;
test_height=0.6;
test_thickness=1;
module TestPattern() {
  difference() {
    cylinder(test_height,test_radius,test_radius);
    translate([0,-test_height/2,0]) cylinder(2*test_height,test_radius-test_thickness,test_radius-test_thickness);
  }
}
TestPattern();
