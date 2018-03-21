// motion compare current and previous frame to get b/w image
PImage motion = createImage(640, 360, RGB);
int motionThreshold = 60;
int motionCount_global = 0;

float motionX = 0;
float motionY = 0;
float lerpX = 0;
float lerpY = 0;
float handX = 0;
float handY = 0;

float avgX_global = 0;
float avgY_global = 0;

void motion() {

  motionCount = 0;

  float avgX = 0;
  float avgY = 0;

  video.loadPixels();
  prev.loadPixels();
  motion.loadPixels();

  //loadPixels();
  // Begin loop to walk through every pixel
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      int newLoc = (video.width - 1 - x) + y * video.width;

      if (d > motionThreshold * motionThreshold) {
        //stroke(255);
        //strokeWeight(1);
        //point(x, y);
        avgX += (video.width - 1 - x);
        avgY += y;
        motion.pixels[newLoc] = color(255);
        motionCount++;
      } else {
        motion.pixels[newLoc] = color(0);
      }
    }
  }

  motion.updatePixels();

  motionCount_global = motionCount;

  avgX_global = avgX / motionCount;
  avgY_global = avgY / motionCount;

  //return motion;
}

void drawMotionBlob() {

  if (motionCount_global > threshold) {
    motionX = avgX_global;
    motionY = avgY_global;
    println(motionCount_global);
  }

  lerpX = lerp(lerpX, motionX, 0.1); 
  lerpY = lerp(lerpY, motionY, 0.1); 

  handX = map(lerpX, 0, 640, 0, wwidth);
  handY = map(lerpY, 0, 360, 0, hheight * 1.5);

  fill(50, 100);
  strokeWeight(2.0);
  stroke(0);
  ellipse(handX, handY, 36, 36);
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}