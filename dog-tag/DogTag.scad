// https://www.reddit.com/r/openscad/comments/3jwobs/comment/cvg5iro/?utm_source=reddit&utm_medium=web2x&context=3
module multiLine(lines, size){
  union(){
    for (i = [0 : len(lines)-1])
      translate([0, -i * (size + 2), 0]) 
        text(lines[i], size);
  }
}
//multiLine(["one", "two"], 20);

font_height=0.33/*in*/*2.54/*cm/in*/*10/*mm/cm*/;
font_depth=1;
name="   Puppers";
phone_number_1="xxx.xxx.xxxx";
phone_number_2="yyy.yyy.yyyy";

//linear_extrude(height = font_depth) 
//    text("MNOPQRS", 
//     size=font_height,
//     font="Bitstream Vera Sans",
//     halign="center",
//     valign="center"
//     );

linear_extrude(height = font_depth) 
    multiLine([name, phone_number_1, phone_number_2], font_height);
