// Time Magzine covers

PImage[] timeCovers;
int numCovers = 17;
//PVector coverSize = (base )

void loadCovers() {
  timeCovers = new PImage[numCovers];
  for (int i = 0; i < numCovers; i++) {
    StringBuilder file = new StringBuilder("time_cover/").append(i).append(".jpg");
    String fileName = file.toString();
    timeCovers[i] = loadImage(fileName);
    println(fileName);
  }
}



void drawWhich() {
}

void drawCovers() {
  pushMatrix();
  translate(verticalLines[2], base, 0);
  //rotateX(PI/2.0);
  timeCovers[0].resize(420, 560);
  if (camAngle() < 0.0) {
    tint(255, 60);
  } else if (camAngle() > 0.0) {
    tint(255, map(camAngle(), 0.0, height/8.0, 60.0, 255.0));
  }
  image(timeCovers[0], 0, 0);
  popMatrix();
}

// Time Cover
//timeCover.beginDraw();
//timeCover.background(100);
//timeCover.stroke(255);
//timeCover.line(20, 20, mouseX, mouseY);
//timeCover.endDraw();
//image(timeCover, 9, 30); 
//image(timeCover, 51, 30);