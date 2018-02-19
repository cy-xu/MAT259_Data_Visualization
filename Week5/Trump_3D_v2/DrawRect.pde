float[] rectHeight;
float barWidth;
float barX;
int lastBar;
color fillColor;
float colorVlue;

ArrayList<float[]> rects = new ArrayList<float[]>();

int whichMonth() {
  barWidth = (width - 2 * borders[0]) / flMatrix[0].length;
  if (mouseInRect()) {
    return int((mouseX - borders[0]) / barWidth);
  } else {
    return 0;
  }
}

int whichMonth2(float mouse_x) {
  barWidth = (width - 2 * borders[0]) / flMatrix[0].length;
  return int((mouse_x - borders[0]) / barWidth);
}

// Read rect height for each month   
void getRectHeight() {
  rectHeight = new float[flMatrix[0].length];
  for (int i = 0; i < flMatrix[0].length; i++) {
    rectHeight[i] = map((flMatrix[0][i]), 0, 25, 0, height/2 - 2 * borders[1]);
    //rectHeight[i] = base + (flMatrix[0][i]);
    //println(rectHeight[i]);
  }
}

void loadArrayList() {
  float[] temprect_last = new float[]{-1f, -1f};
  for (int x = (int)borders[0]; x<(int)borders[2]; x++) {
    int whichBar = whichMonth2(x);
    barX = borders[0] + whichBar * barWidth;
    colorVlue = rectHeight[whichBar];
    //println("barX = "+barX);
    float[] temprect = new float[]{barX, rectHeight[whichBar], 0, colorVlue}; //{x,h,ifDraw}
    if (temprect_last[0]!=temprect[0]) {
      rects.add(temprect);
      temprect_last = temprect;
    }
  }
}

void drawLibrary() {
  int whichBar = whichMonth();
  //println(whichBar);
  barX = borders[0] + whichBar * barWidth;

  translate(barX, base, rectHeight[whichBar] / 2);
  fill(colors[4], map(rectHeight[whichMonth()], 0, height/2 - 2 * borders[1], 0, 100));
  //rectMode(CORNER);
  stroke(colors[2], 100);
  //rect(barX, base, barWidth, rectHeight[whichBar]+5);
  box(barWidth, barWidth/2, rectHeight[whichBar] + 2);

  //println(rectHeight[whichMonth()]);
}

void drawMouseVert() {
  float lineX = borders[0] + (whichMonth() + 1) * barWidth;
  if (camY() < 0) {
    stroke(colors[5], 80, 1);
    line(lineX, rectHeight[whichMonth()] + 2, mouseX, borders[3]);
  }
}

void showLibrary() {
  //println("rects.size() = "+rects.size());

  for (int i = 0; i<rects.size(); i++) {

    barX = borders[0] + whichMonth() * barWidth;
    if (rects.get(i)[0]==barX) {
      rects.get(i)[2]=1;
    }
    if (rects.get(i)[2]!=0) {

      pushMatrix();
      translate(0, base, rects.get(i)[1] / 2);
      fill(colors[2], map(rects.get(i)[3], 0, 300, 0, 200));
      //noFill();
      stroke(colors[2], 80);
      rectMode(CORNER);
      //rect(rects.get(i)[0], base, barWidth, rects.get(i)[1]);
      translate(rects.get(i)[0], 0);
      box(barWidth, barWidth/10, rects.get(i)[1]);
      popMatrix();
    }
  }
}