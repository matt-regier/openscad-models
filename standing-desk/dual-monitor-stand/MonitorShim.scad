$fn=360;

shim_radius=40;
shim_height=2.5*2.54*10;
corner_radius=3;

/*TODO: I need to reinclude attribution for roundedCube */
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

module shim() { 


  // $fn= 360;

  // width = 10;   // width of rectangle
  // height = 2;   // height of rectangle
  // r = 50;       // radius of the curve
  //a = 30;       // angle of the curve

  // rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);

  //rotate_extrude(/*angle = 180*/) 
  {
    translate([shim_radius, corner_radius, 0])
      {
        circle(r = corner_radius);
      }
    translate([shim_radius, shim_height+corner_radius, 0])
    {
      circle(r = corner_radius);
    }
    square(size = [shim_radius, shim_height+2*corner_radius]);
    translate([0, 0, 0])
    {
    }


  }

      // square(size = [height, width], center = true);

  //cylinder(shim_height, shim_radius, shim_radius);
      rotate_extrude($fn = 180) {
        
        
      }


//         polygon( points=[
// [0,0], // center bottom
// [37,0], // outer bottom edge
// //[39,50], // under lip (original)
// [46-4,50-6], // under lip (angled)
// [46,50], // outer bottom lip
// [46,55], // outer top lip
// [37,55], // inner top lip
// [37,53], // notch 1

// //[39,53], // notch 2 attempt 1
// //[39,51], // notch 3 attempt 1

// [39,52], // notch 2&3 attempt 2

// [37,51], // notch 4
// [35,2], // inner bottom edge
// [0,2], // center top
// [0,2] // end
//         ] 
//         );
        
        
        
  // translate([-shim_radius,0,0]) roundedCube(2*shim_radius,shim_radius,shim_height,corner_radius);
}
shim();