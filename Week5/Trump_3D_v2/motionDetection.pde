// motion compare current and previous frame to get b/w image
PImage motion = createImage(640, 360, RGB);
int motionThreshold = 60;

float motionX = 0;
float motionY = 0;
float lerpX = 0;
float lerpY = 0;

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
        avgX += x;
        avgY += y;
        motion.pixels[newLoc] = color(255);
        motionCount++;
      } else {
        motion.pixels[newLoc] = color(0);
      }
    }
  }
  
  motion.updatePixels();

  if (motionCount > threshold) {
    motionX = avgX / motionCount;
    motionY = avgY / motionCount;
  };

  lerpX = lerp(lerpX, motionX, 0.1); 
  lerpY = lerp(lerpY, motionY, 0.1); 

  fill(255, 0, 255);
  strokeWeight(2.0);
  stroke(0);
  ellipse(map(lerpX, 0, 1280, 0, wwidth), map(lerpY, 0, 720, 0, hheight), 36, 36);

  //return motion;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}