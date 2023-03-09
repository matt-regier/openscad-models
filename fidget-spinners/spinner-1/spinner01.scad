module spinner() {
    cylinder(h=8, r1=8, r2=8);
    rotate_extrude() {
        translate([24,4,0]) circle(r=4);
    }
}
//spinner();


CubePoints = [
  [  4,  0,  0 ],  //0
  [  0, 24,  4 ],  //1
  [ -4,  0,  0 ],  //2
  [  4,  0,  8 ],  //3
  [  0, 24,  4 ],  //4
  [ -4,  0,  8 ],  //5
  [ 10,  7,  5 ],  //6
  [  0,  7,  5 ]   //7
];
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
polyhedron( CubePoints, CubeFaces );
