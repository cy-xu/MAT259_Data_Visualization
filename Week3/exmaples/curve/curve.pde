// define multiple vertices, every two points is a location
int[] coords = {
  40, 40, 80, 60, 100, 100, 60, 120, 50, 150
};

///// enviroment initialize, run once at start

void setup() {
  // set window size
  size(200, 200);
  // set backgorund
  background(255);

///// draw the curve and fill with color

  // fill the shape with color 200
  fill(200);
  // set outline color?
  stroke(100);
  // beigin draw shape
  beginShape();
  // control point 1
  curveVertex(40, 40);
  // set starting point
  // same as control point 1
  curveVertex(40, 40);
  curveVertex(80, 60);
  curveVertex(180, 80);
  curveVertex(100, 100);
  curveVertex(60, 120);
  // set end point
  // same as control point 2
  curveVertex(50, 150);
  // set control point 2
  curveVertex(50, 150);
  // end draw shape
  endShape();
  
////// draw the ellipses on lines

  // set fill color to red
  fill(255, 0, 0);
  // no outline
  noStroke();
  // based on curveVertex vertices
  // every two number is a point, draw a circle
  for (int i = 0; i < coords.length; i += 2) {
    ellipse(coords[i], coords[i + 1], 5, 5);
  }
}

// draw, it refresh automatically
void draw(){
  // no code needed here
}