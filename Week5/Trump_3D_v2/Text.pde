//Title text
PFont f;

void draw2DText() {
  // Title
  pushMatrix();
  translate(0, 0, 1);
  fill(colors[5]);
  textSize(32);
  textAlign(LEFT, TOP);
  String title = "From Political Joke to the 45th President";
  text(title, verticalLines[0], 0.04 * height, 700, 200);
  
  fill(colors[5]);
  textSize(26);
  textAlign(RIGHT);
  String subtitle = "How Trump's Presidential Campaign Influenced Seattle's Reading Consumption";
  text(subtitle, 0.60 * width, 0.04 * height, 500, 200);
  popMatrix();
}

// TOP - Google
void drawGoogleText() {
  pushMatrix();
  fill(colors[5]);
  textSize(26);
  textAlign(LEFT, TOP);
  text("Google Trend", verticalLines[0], horizonalLines[0]);
  fill(120);
  textSize(20);
  textAlign(LEFT, TOP);
  String googleTrend ="The curve shows the how many times people searched 'Donald Trump' on Google every month, from January 2015 to December 2017."; 
  text(googleTrend, verticalLines[0], horizonalLines[1], 500, 300);
  popMatrix();
}

// BOTTOM - Library
void drawLibText() {
  pushMatrix();
  translate(0, 0, 1);
  fill(colors[5]);
  textSize(26);
  textAlign(LEFT, TOP);
  text("Seattle Public Library", verticalLines[0], horizonalLines[2]);
  fill(120);
  textSize(20);
  textAlign(LEFT, TOP);
  String libData ="The bars represent the library's cheking records on Trump's books and DVDs each month over the same period of time."; 
  text(libData, verticalLines[0], horizonalLines[3], 500, 100);
  popMatrix();
}

void drawEventText() {
  pushMatrix();
  //translate(0, base * 0.6, 1);
  translate(0, 0, 1);
  textAlign(LEFT, TOP);
  fill(colors[5]);
  textSize(26);
  //f = createFont("Arial", 16, true); // Arial, 16 point, anti-aliasing on
  //textFont(f, 36);

  switch(whichMonth()) {
  case 0: 
    text("", verticalLines[3], horizonalLines[2]);
    break;
  case 1: 
    text("Jan 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 2: 
    text("Feb 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 3: 
    text("Mar 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 4: 
    text("Apr 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 5: 
    text("May 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 6: 
    text("Jun 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 7: 
    text("Jul 2015.", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump officially announced his candidacy for president of the United States. He introduced his plans to build a “great wall” on the U.S.-Mexico border.", verticalLines[3], horizonalLines[3], 500, 300);
    break;
  case 8: 
    text("Aug 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("During the first GOP debate in Cleveland, Ohio, Trump attracted boos when he said he wouldn’t pledge to support whoever won the party’s nomination.", verticalLines[3], horizonalLines[3], 500, 300);
    break;
  case 9: 
    text("Sep 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump unveiled his tax plan from Trump Tower, promising that he would “shift the burden” to wealthy families. Of his plan, Trump said, “If you’re single and earn less than $25,000 per year, or married and jointly earn less than $50,000, you’ll not pay any income tax. Nothing.”", verticalLines[3], horizonalLines[3], 500, 300);
    break;
  case 10: 
    text("Oct 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 11: 
    text("Nov 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 12: 
    text("Dec 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 13: 
    text("Jan 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 14: 
    text("Feb 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 15: 
    text("Mar 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump won seven of the 11 states that vote on so-called Super Tuesday.", verticalLines[3], horizonalLines[3], 300, 300);
    break;
  case 16: 
    text("Apr 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 17: 
    text("May 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 18: 
    text("Jun 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 19: 
    text("Jul 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 20: 
    text("Aug 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 21: 
    text("Sep 2016", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Two presidential debates took place and the national attention reached all time peak.", verticalLines[3], horizonalLines[3], 300, 300);
    break;
  case 22: 
    text("Oct 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 23: 
    text("Nov 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 24: 
    text("Dec 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 25: 
    text("Jan 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 26: 
    text("Feb 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 27: 
    text("Mar 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 28: 
    text("Apr 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 29: 
    text("May 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 30: 
    text("Jun 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 31: 
    text("Jul 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 32: 
    text("Aug 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 33: 
    text("Sep 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 34: 
    text("Oct 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 35: 
    text("Nov 2017", verticalLines[3], horizonalLines[2]);
    break;
  case 36: 
    text("Dec 2017", verticalLines[3], horizonalLines[2]);
    break;
  }
  popMatrix();

  //translate(0, -0.1*(horizonalLines[1]-horizonalLines[2]));
  //fill(255*7/8, 100);
  //Parallelogram(0.04*width,horizonalLines[0],verticalLines[0]-0.04*width, horizonalLines[1]/2-0.04*height,0.2);
  //translate(0, 0.1*(horizonalLines[1]-horizonalLines[0]));
}