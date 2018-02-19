// Time Magzine covers

import milchreis.imageprocessing.*;

PImage[] timeCovers;
int numCovers = 17;
int[] toDraw;
//PVector coverSize = (base )

void loadCovers() {
  timeCovers = new PImage[numCovers];
  for (int i = 0; i < numCovers; i++) {
    StringBuilder file = new StringBuilder("time_cover/").append(i).append(".jpg");
    String fileName = file.toString();
    timeCovers[i] = loadImage(fileName);
    timeCovers[i].resize(420, 560);
  }
}

void drawCovers() {
  pushMatrix();
  //translate(verticalLines[2], base, -timeCovers[0].height);
  translate(0, base, -timeCovers[0].height);
  rotateX(PI/2.0);
  if (camY() > 0) {
    tint(255, 60);
  } else if (camY() < 0) {
    tint(255, map(camY(), 0.0, -height/4.0, 60.0, 255.0));
  }
  image(timeCovers[0], mouseX, 0);
  popMatrix();

  //pushMatrix();
  //if (camAngle() > 0) {
  //  tint(255, 60);
  //} else if (camAngle() < 0) {
  //  tint(255, map(camAngle(), 0.0, -height/4.0, 60.0, 255.0));
  //}

  //int n = timeCovers.length;
  //float ratio = float(timeCovers[0].width) / float(width) / n;
  //int coverSmallWidth = int(float(timeCovers[0].width) * ratio);
  //int coverSmallHeight = int(float(timeCovers[0].height) * ratio);
  //println("coverSmallHeight is " + coverSmallHeight);
  //println("coverSmallWidth is " + coverSmallWidth);

  //println("ratio is " + ratio);
  ////translate(0, 0, -timeCovers[0].height);
  ////rotateX(PI/2.0);

  //translate(whichMonth() * barWidth, base, -timeCovers[0].height);
  //rotateX(PI/2.0);
  //if (mousePressed == true) {
  //  image(timeCovers[1], 0, 0);
  //} else {
  //  int intensity = (int) map(mouseY, 0, base, 2, 0);
  //  image(Glitch.apply(timeCovers[1], intensity), 0, 0);

  //  // You can also use:
  //  // Glitch.apply(image)
  //  // Glitch.apply(image, intensity, scanlineHeight)
  //}
}

//int[] drawWhichCover() {
//  toDraw = new int[2];
//  switch(whichMonth()) {
//  case 8: 
//    toDraw[0] = 0;
//    return toDraw;
//    break;
//  case 9: 
//    text("Sep 2015", verticalLines[3], horizonalLines[2]);
//    break;
//  case 10: 
//    text("Oct 2015", verticalLines[3], horizonalLines[2]);
//    break;
//  case 11: 
//    text("Nov 2015", verticalLines[3], horizonalLines[2]);
//    break;
//  case 12: 
//    text("Dec 2015", verticalLines[3], horizonalLines[2]);
//    break;
//  case 13: 
//    text("Jan 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 14: 
//    text("Feb 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 15: 
//    text("Mar 2016", verticalLines[3], horizonalLines[2]);
//    textSize(18);
//    text("Trump won seven of the 11 states that vote on so-called Super Tuesday.", verticalLines[3], horizonalLines[3], 300, 300);
//    break;
//  case 16: 
//    text("Apr 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 17: 
//    text("May 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 18: 
//    text("Jun 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 19: 
//    text("Jul 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 20: 
//    text("Aug 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 21: 
//    text("Sep 2016", verticalLines[3], horizonalLines[2]);
//    textSize(18);
//    text("Two presidential debates took place and the national attention reached all time peak.", verticalLines[3], horizonalLines[3], 300, 300);
//    break;
//  case 22: 
//    text("Oct 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 23: 
//    text("Nov 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 24: 
//    text("Dec 2016", verticalLines[3], horizonalLines[2]);
//    break;
//  case 25: 
//    text("Jan 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 26: 
//    text("Feb 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 27: 
//    text("Mar 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 28: 
//    text("Apr 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 29: 
//    text("May 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 30: 
//    text("Jun 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 31: 
//    text("Jul 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 32: 
//    text("Aug 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 33: 
//    text("Sep 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 34: 
//    text("Oct 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 35: 
//    text("Nov 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  case 36: 
//    text("Dec 2017", verticalLines[3], horizonalLines[2]);
//    break;
//  }
//  popMatrix();
//}

// Time Cover
//timeCover.beginDraw();
//timeCover.background(100);
//timeCover.stroke(255);
//timeCover.line(20, 20, mouseX, mouseY);
//timeCover.endDraw();
//image(timeCover, 9, 30); 
//image(timeCover, 51, 30);