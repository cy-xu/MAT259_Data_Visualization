//float resizeRatio(){

//}

boolean mouseInRect() {
  //return (mouseX > borders[0] && mouseX < borders[2] && mouseY > base);
  return (mouseX > borders[0] && mouseX < borders[2]);
}

boolean mouseInScreen() {
  return (mouseX > borders[0] && mouseX < borders[2]);
}

// draw a curve with data from Google Trend
void drawGoogleCurve() {
  pushMatrix();
  translate(0, 0, 0.1);

  curveWidth = (width - 2 * borders[0]) / flMatrix[1].length;

  fill(colors[1], 100);
  //noFill();
  strokeWeight(4);
  stroke(colors[1]);

  float curveShift = 15f;

  beginShape();
  curveVertex(borders[0]+ curveShift, base);
  curveVertex(borders[0]+ curveShift, base);
  for (int i = 0; i < flMatrix[1].length; i++) {
    curveVertex(i * curveWidth + borders[0]+ curveShift, base - map((flMatrix[1][i]), 0, 100, 0, height/2 - 2 * borders[1]));
  }
  curveVertex((flMatrix[1].length - 1) * curveWidth + borders[0]+ curveShift, base);
  curveVertex((flMatrix[1].length - 1) * curveWidth + borders[0]+ curveShift, base);
  endShape();

  stroke(colors[5], 200);
  strokeWeight(3);
  line(borders[0], base, borders[2], base);

  popMatrix();
}

void drawMouseVert() {
  if (mouseInScreen()) {
    stroke(colors[5], 80, 1);
    line(mouseX, borders[1], mouseX, borders[3]);
  }
}

void rotateGoogleText() {
  //camAngle = printCamera();
  rotateX(map(mouseY, 0, height, 0, 0));
  //translate(0, map(mouseY, 0, height, -1/2*height, 0), 0);
  //translate(0, 0, -500);
}

void rotateLibText() {
  rotateX(map(camAngle(), 0.0, height, PI, 0));
  //translate(0, map(mouseY, 0, height, -1/2*height, 0), 0);
  //camera(0.0, map(mouseY, 0, height, -height/4, height/8), 220.0, // eyeX, eyeY, eyeZ
}

float camAngle() {
  float lowAngle = height/8.0;
  float highAngle = -height/4.0;
  if (mouseY > 0.8 * height) {
    return lowAngle;
  } else if (mouseY < 0.2 * height){
  return highAngle;
  } else {
  return map(mouseY, 0.2 * height, 0.8 * height, highAngle, lowAngle);
  }
};