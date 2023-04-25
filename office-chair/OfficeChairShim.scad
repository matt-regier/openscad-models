$fn = 360;

debug=false;
if (debug) {
    echo(version=version());
    echo(inside_bottom_x=inside_bottom_x);
    echo(inside_bottom_y=inside_bottom_y);
    echo(inside_top_x=inside_top_x);
    echo(inside_top_y=inside_top_y);
    echo(outside_top_x=outside_top_x);
    echo(outside_top_y=outside_top_y);
    echo(outside_bottom_x=outside_bottom_x);
    echo(outside_bottom_y=outside_bottom_y);
}

gap=1;
inside_bottom_diameter=40.5+gap;
inside_bottom_x = inside_bottom_diameter/2;
inside_bottom_y = 0;

inside_top_diameter = 40.5+gap;
inside_top_x = inside_top_diameter/2;
inside_top_y = 62;

outside_top_diameter = 50.5;
outside_top_x = outside_top_diameter/2;
outside_top_y = 62;

outside_bottom_diameter=47.5;
outside_bottom_x = outside_bottom_diameter/2;
outside_bottom_y = 0;

module ChairShim() {
    color("red")
        rotate_extrude()
            polygon( points=[
                [inside_bottom_x, inside_bottom_y],
                [inside_top_x, inside_top_y],
                [outside_top_x, outside_top_y],
                [outside_bottom_x, outside_bottom_y]
            ] );
    color("blue")
        rotate_extrude()
            // translate([inside_top_x,62,0])
            //     square([5,10]);
            translate([outside_top_x-5,62,0]) 
                polygon( points=[
                    [0.0, 0.0],
                    [0.0, 5.0],
                    [3.5, 10.0],
                    [5.0, 10.0],
                    [5.0, 0.0]
                ] );
    }
ChairShim();
