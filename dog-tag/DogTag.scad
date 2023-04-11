$fn=36; // increase for rotational smoothness
font_height=4;
font_depth=1;
friend_name="Puppers";
phone_number_1="xxx-";
phone_number_2="xxx-";
phone_number_3="xxxx";
text_y_offset=4;
rim_radius=2;
plate_radius=0.5/*in*/*2.54/*cm/in*/*10/*mm/cm*/;

collar_diameter=9;
collar_radius=collar_diameter/2;

loop_radius=2;
loop_width=10;

// https://www.reddit.com/r/openscad/comments/3jwobs/comment/cvg5iro/?utm_source=reddit&utm_medium=web2x&context=3
module multiLine(lines, size){
  union(){
    for (i = [0 : len(lines) - 1])
      translate([0, -i * (size + 1), 0])
        text(
            text=lines[i],
            size=size,
            halign="center",
            font="Arial:style=Bold"
    );
  }
}
//multiLine(["one", "two"], 20);

//linear_extrude(height = font_depth)
//    text("MNOPQRS",
//     size=font_height,
//     font="Bitstream Vera Sans",
//     halign="center",
//     valign="center"
//     );

module lines() {
  color("blue")
    linear_extrude(height = font_depth)
      multiLine([friend_name, phone_number_1, phone_number_2, phone_number_3], font_height);
}
// lines();

module rim() {
  rotate_extrude() {
    translate([plate_radius+rim_radius,rim_radius,0]) circle(rim_radius);
  }
}
// rim();

module plate() {
  cylinder(rim_radius, plate_radius+rim_radius, plate_radius+rim_radius);
}
// plate();

module loop() {
  translate([-loop_radius-loop_width/2,collar_radius+plate_radius+rim_radius+loop_radius,rim_radius]) {
    rotate([90,0,90]) {
      rotate_extrude() {
        union() {
          translate([collar_radius+loop_radius,loop_radius,0]) circle(loop_radius);
          translate([collar_radius+loop_radius,loop_radius+loop_width,0]) circle(loop_radius);
          translate([collar_radius,loop_radius,0]) square([2*loop_radius, loop_width]);
        }
      }
    }
  }
}
// loop();

module tag() {
  rim();
  plate();
  translate([0,text_y_offset,rim_radius]) lines();
  loop();
}
tag();
