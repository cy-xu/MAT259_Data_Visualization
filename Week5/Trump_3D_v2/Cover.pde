// Time Magzine covers //<>//

int coverWidth = int(0.3 * 840);
int coverHeight = int(0.3 * 1120);

PImage[] timeCovers;
int numCovers = 17;
String coverMonth;
String coverTitle;

float timePast  = 0;
float timeInterval = 1000.0;

boolean ifFadeCompleted = false;

//import milchreis.imageprocessing.*;

void loadCovers() {
  timeCovers = new PImage[numCovers];
  for (int i = 0; i < numCovers -1; i++) {
    StringBuilder file = new StringBuilder("time_cover/").append(i).append(".jpg");
    String fileName = file.toString();
    timeCovers[i] = loadImage(fileName);
    timeCovers[i].resize(coverWidth, coverHeight);
    //println(coverWidth, coverHeight);
  }
}

PImage[] coversDrawing = new PImage[2];

float getTrans() {
  if (handY <= 0.2 * height) {
    if (coversDrawing[0] != null && ifFadeCompleted == false) {
      float fadeRatio = 255 - ((millis() - timePast) * 1.0 / timeInterval) * 255;
      if (fadeRatio < 30.0) {
        ifFadeCompleted = true;
      }
      return fadeRatio;
    } else {
    return 0.0;
    }
  } else {
    //return map(camY(), 0.0, -height, 30.0, 255.0);
    return 30.0;
  }
}

void drawFunc(float alpha) {
  pushMatrix();
  translate(width * 0.6, base, 0);
  rotateX(PI/2.0);
  float boxWidth = 0.4 * width;
  float boxHeight = 0.3 * height;

  for (int i = 0; i < 2; i++) {
    if (coversDrawing[i] != null) {
      tint(255, alpha);
      image(coversDrawing[i], i * (1.1 * coverWidth), (-1.1 * coverHeight));
      fill(colors[5], alpha);
      textSize(36);
      textAlign(LEFT, TOP);
      text(coverMonth, -0.5 * width, -0.4 * height, boxWidth, boxHeight);
      text(coverTitle, -0.5 * width, -0.3 * height, boxWidth, boxHeight);
    }
  }
  popMatrix();
}  


void drawCovers() {
  if (coversToDraw[0] != null) {
    coversDrawing = coversToDraw;
    drawFunc(getTrans());
    ifFadeCompleted = false;
    timePast = millis();
  } else {
    if (millis() > timePast + timeInterval) {
      timePast = millis();
    } else {
      //println(fadeRatio);
      drawFunc(getTrans());
    }
  }
}

//timePast = millis();
//if (coversDrawing[0] != null) {
//  if (millis() < timePast + timeInterval) {
//    float fadeRatio = 1/((millis() - timePast) / timeInterval) * 255;
//    drawFunc(fadeRatio);
//    //break;
//  }
//}

PImage[] drawWhichCover() {
  PImage[] returnedImages = new PImage[2];
  switch(whichMonth()) {
  case 8: 
    coverMonth = "Aug 2015";
    coverTitle = "Deal with it.";
    returnedImages[0] = timeCovers[0];
    returnedImages[1] = null;
    return returnedImages;
  case 13: 
    coverMonth = "Jan 2016";
    coverTitle = "Now he just needs the votes.";
    returnedImages[0] = timeCovers[1];
    returnedImages[1] = null;
    return returnedImages;
  case 15:
    coverMonth = "Mar 2016";
    coverTitle = "On the plane with Donald Trump.";
    returnedImages[0] = timeCovers[2];
    returnedImages[1] = null;
    return returnedImages;
  case 19: 
    coverMonth = "Jul 2016";
    coverTitle = "For Trump, intuition beats experience. What that would mean for the presidency";
    returnedImages[0] = timeCovers[3];
    returnedImages[1] = null;
    return returnedImages;
  case 22: 
    coverMonth = "Oct 2016";
    coverTitle = "Total Meltdown.";
    returnedImages[0] = timeCovers[4];
    returnedImages[1] = null;
    return returnedImages;
  case 23: 
    coverMonth = "Nov 2016";
    coverTitle = "Donald Turmp. President-elect. Nov.9, 2016";
    returnedImages[0] = timeCovers[5];
    returnedImages[1] = timeCovers[6];
    return returnedImages;
  case 24: 
    coverMonth = "Dec 2016";
    coverTitle = "Person of the Year. President of the divided states of America.";
    returnedImages[0] = timeCovers[7];
    returnedImages[1] = null;
    return returnedImages;
  case 25: 
    coverMonth = "Jan 2017";
    coverTitle = "INCOMING. A survival guide to the white house from team Obama to team Trump.";
    returnedImages[0] = timeCovers[8];
    returnedImages[1] = timeCovers[9];
    return returnedImages;
  case 26: 
    coverMonth = "Feb 2017";
    coverTitle = "Nothing to See Here.";
    returnedImages[0] = timeCovers[10];
    returnedImages[1] = null;
    return returnedImages;
  case 27: 
    coverMonth = "Mar 2017";
    coverTitle = "Trump's War on Washington.";
    returnedImages[0] = timeCovers[11];
    returnedImages[1] = null;
    return returnedImages;
  case 29: 
    coverMonth = "May 2017";
    coverTitle = "The Firing of James Comey. / After Hours in the White House.";
    returnedImages[0] = timeCovers[12];
    returnedImages[1] = timeCovers[13];
    return returnedImages;
  case 34: 
    coverMonth = "Oct 2017";
    coverTitle = "Now Trump's Cabinet Is Dismantling Government as We Know It.";
    returnedImages[0] = timeCovers[14];
    returnedImages[1] = null;
    return returnedImages;
  case 35: 
    coverMonth = "Nov 2017";
    coverTitle = "Why He Alaways Bounces Back.";
    returnedImages[0] = timeCovers[15];
    returnedImages[1] = null;
    return returnedImages;
  case 37: 
    coverMonth = "Jan 2018";
    coverTitle = "Year One.";
    returnedImages[0] = timeCovers[16];
    returnedImages[1] = null;
    return returnedImages;
  default: 
    returnedImages[0] = null;
    returnedImages[1] = null;
    return returnedImages;
  }
}

//if (mousePressed == true) {
//  image(drawWhichCover(), 0, 0);
//} else {
//  int intensity = int(map(mouseY, 0, base, 2, 0));
//  image(Glitch.apply(drawWhichCover(), intensity), 0, 0);
//}

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


//  // You can also use:
//  // Glitch.apply(image)
//  // Glitch.apply(image, intensity, scanlineHeight)
//}