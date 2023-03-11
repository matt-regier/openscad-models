// four-sided pyramid (horizontal)

showPoints=false; // true works for F5 Preview only; must set to false for F6 Render.

pyramid_base=8;
pyramid_half_base=pyramid_base/2;
pyramid_height=30;
pyramid_vertical_offset=10;

polyPoints = [
  [pyramid_half_base, pyramid_vertical_offset, 0], // 0 bottom-right
  [-pyramid_half_base, pyramid_vertical_offset, 0], // 1 bottom-left
  [0, pyramid_height, pyramid_half_base], // 2 apex
  [pyramid_half_base, pyramid_vertical_offset, pyramid_base], // 3 top-right
  [-pyramid_half_base, pyramid_vertical_offset, pyramid_base] // 4 top-left
];
polyFaces = [
  [0,2,1], // bottom
  [3,2,0], // right
  [1,2,4], // left
  [4,2,3], // top
  [3,0,1,4] // back
];

translate([-5,0,0]) {
  polyhedron(polyPoints, polyFaces);
  if (showPoints) {
    color("yellow") {
      for (idx = [ 0 : len(polyPoints) - 1 ] ) {
        echo("polyPoints", idx, polyPoints[idx]);
        translate(polyPoints[idx]) rotate([90,0,0]) linear_extrude(height=0.2) text(text=str(idx), size=2);
      }
    }
  }
}
