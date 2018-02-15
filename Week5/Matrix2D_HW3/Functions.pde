

boolean mouseInRect() {
  return (mouseX > borders[0] && mouseX < borders[2] && mouseY > base);
}

boolean mouseInScreen() {
  return (mouseX > borders[0] && mouseX < borders[2]);
}

// draw a curve with data from Google Trend
void drawGoogleCurve() {  
  curveWidth = (width - 2 * borders[0]) / flMatrix[1].length;

  //fill(colors[1], 100);
  noFill();
  strokeWeight(2);
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
}



void drawMouseVert() {
  if (mouseInScreen()) {
    stroke(colors[5], 80);
    line(mouseX, borders[1], mouseX, borders[3]);
  }
}


//Title text
void drawText() {

  textAlign(LEFT, TOP);
  fill(colors[5]);
  textSize(26);

  switch(whichMonth()) {
  case 0: 
    text("", verticalLines[3], horizonalLines[0]);
    break;
  case 1: 
    text("Jan 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 2: 
    text("Feb 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 3: 
    text("Mar 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 4: 
    text("Apr 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 5: 
    text("May 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 6: 
    text("Jun 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 7: 
    text("Jul 2015.", verticalLines[3], horizonalLines[0]);
    textSize(18);
    text("Trump officially announced his candidacy for president of the United States.", verticalLines[3], horizonalLines[1], 300, 300);
    break;
  case 8: 
    text("Aug 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 9: 
    text("Sep 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 10: 
    text("Oct 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 11: 
    text("Nov 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 12: 
    text("Dec 2015", verticalLines[3], horizonalLines[0]);
    break;
  case 13: 
    text("Jan 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 14: 
    text("Feb 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 15: 
    text("Mar 2016", verticalLines[3], horizonalLines[0]);
    textSize(18);
    text("Trump won seven of the 11 states that vote on so-called Super Tuesday.", verticalLines[3], horizonalLines[1], 300, 300);
    break;
  case 16: 
    text("Apr 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 17: 
    text("May 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 18: 
    text("Jun 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 19: 
    text("Jul 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 20: 
    text("Aug 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 21: 
    text("Sep 2016", verticalLines[3], horizonalLines[0]);
    textSize(18);
    text("Two presidential debates took place and the national attention reached all time peak.", verticalLines[3], horizonalLines[1], 300, 300);
    break;
  case 22: 
    text("Oct 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 23: 
    text("Nov 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 24: 
    text("Dec 2016", verticalLines[3], horizonalLines[0]);
    break;
  case 25: 
    text("Jan 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 26: 
    text("Feb 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 27: 
    text("Mar 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 28: 
    text("Apr 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 29: 
    text("May 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 30: 
    text("Jun 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 31: 
    text("Jul 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 32: 
    text("Aug 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 33: 
    text("Sep 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 34: 
    text("Oct 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 35: 
    text("Nov 2017", verticalLines[3], horizonalLines[0]);
    break;
  case 36: 
    text("Dec 2017", verticalLines[3], horizonalLines[0]);
    break;
  }



  pushMatrix();
  //translate(0, -0.1*(horizonalLines[1]-horizonalLines[0]));
  //fill(255*7/8, 100);
  //Parallelogram(0.04*width,horizonalLines[0],verticalLines[0]-0.04*width, horizonalLines[1]/2-0.04*height,0.2);
  //translate(0, 0.1*(horizonalLines[1]-horizonalLines[0]));

  // Title
  fill(colors[5]);
  textSize(32);
  textAlign(LEFT, TOP);
  String title = "How Trump's Presidential Campaign Influenced Seattle's Reading Consumption";
  text(title, verticalLines[0], 0.06 * height, 700, 200);

  // TOP - Google
  fill(colors[5]);
  textSize(26);
  textAlign(LEFT, TOP);
  text("Google Trend", verticalLines[0], horizonalLines[0]);
  fill(140);
  textSize(18);
  textAlign(LEFT, TOP);
  String googleTrend ="The curve shows the how many times people searched 'Donald Trump' on Google every month, from January 2015 to December 2017."; 
  text(googleTrend, verticalLines[0], horizonalLines[1], 600, 300);

  // BOTTOM - Library
  //translate(0, 55);
  fill(colors[5]);
  textSize(26);
  textAlign(LEFT, BOTTOM);
  text("Seattle Public Library", verticalLines[0], horizonalLines[2]);
  fill(140);
  textSize(18);
  textAlign(LEFT, BOTTOM);
  String libData ="The bars represent the library's cheking records on Trump's books and DVDs each month over the same period of time."; 
  text(libData, verticalLines[0], horizonalLines[3], 500, 100);

  popMatrix();
}