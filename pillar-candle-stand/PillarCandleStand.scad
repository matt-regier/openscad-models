BezierExample();
module BezierExample() {

  points = [
    [0,0,0],
    [47,0,0],
    [49,2,0],
    [47,4,0],
    [30,6,0],
    [28,11,0],
    [30,16,0],
    [47,18,0],
    [49,20,0],
    [47,22,0],
    [0,22,0]
  ];
  
  $fn=10;
  size = 0.02;
  
  //echo(len(BezierPath(points,n=7)));

  %showPoints(points, size*10);
  //*
  // color("red") showPoints(BezierPath(points,n=1), size);
  // color("green") showPoints(BezierPath(points,n=2), size);
  // color("blue") showPoints(BezierPath(points,n=3), size);

  color("yellow") 
    rotate_extrude() {
     intersection() {
       projection() {
        showPoints(BezierPath(points,n=4), size);
       }
       square([1000,1000]);  
     }
  }


  // color("magenta") showPoints(BezierPath(points,n=5), size);
  // color("cyan") showPoints(BezierPath(points,n=6), size);
  // color("white") showPoints(BezierPath(points,n=7), size);
  //*/
  
}

module showPoints(points, size=0.02) {
  for (c = points) translate(c) cube(size, center=true);
}

// return point along curve at position "t" in range [0,1]
// use ctlPts[index] as the first control point
// Bezier curve has order == n
function BezierPoint(ctlPts, t, n, index=0) = (n > 1) ? 
  _BezierPoint([for (i = [index:index+n-1]) ctlPts[i] + t * (ctlPts[i+1] - ctlPts[i])], t, n-1) :
  ctlPts[index] + t * (ctlPts[index+1] - ctlPts[index]);

// slightly optimized version takes less parameters
function _BezierPoint(ctlPts, t, n) = (n > 1) ? 
  _BezierPoint([for (i = [0:n-1]) ctlPts[i] + t * (ctlPts[i+1] - ctlPts[i])], t, n-1) :
  ctlPts[0] + t * (ctlPts[1] - ctlPts[0]);

// n sets the order of the Bezier curves that will be stitched together
// if no parameter n is given, points will be generated for a single curve of order == len(ctlPts) - 1
// Note: $fn is number of points *per segment*, not over the entire path.
function BezierPath(ctlPts, n, index=0) = 
  let (
    l1 = $fn > 3 ? $fn : 200,
    l2 = len(ctlPts),
    n = (n == undef || n > l2-1) ? l2 - 1 : n
  )
  //assert(n > 0)
  [for (segment = [index:n:l2-1-n], i = [0:l1-1])
    BezierPoint(ctlPts, i / l1, n, segment), ctlPts[l2-1]];
  