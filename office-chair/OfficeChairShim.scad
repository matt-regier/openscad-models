$fn = 36;

debug=true;
if (debug) {
    echo(version=version());
    echo(inside_bottom_x=inside_bottom_x);
    echo(inside_bottom_y=inside_bottom_y);
    echo(inside_midpoint_x=inside_midpoint_x);
    echo(inside_midpoint_y=inside_midpoint_y);
    echo(outside_midpoint_x=outside_midpoint_x);
    echo(outside_midpoint_y=outside_midpoint_y);
    echo(outside_bottom_x=outside_bottom_x);
    echo(outside_bottom_y=outside_bottom_y);
}

gap = 0.1;

inside_bottom_x = 37;
inside_bottom_y = 0;

inside_midpoint_x = ((37+42)/2);
inside_midpoint_y = ((0+44)/2);

factor = 1.25;
outside_midpoint_x = inside_midpoint_x+(2*factor);
outside_midpoint_y = inside_midpoint_y-(3*factor);

outside_bottom_x = 84/2;
outside_bottom_y = 0;

module ChairShim() {
color("red")
    //rotate_extrude()
        polygon( points=[
            [inside_bottom_x+gap,inside_bottom_y],
            [inside_midpoint_x+gap,inside_midpoint_y],
            [outside_midpoint_x,outside_midpoint_y],
            [outside_bottom_x,outside_bottom_y],
        ] );
}
ChairShim();
