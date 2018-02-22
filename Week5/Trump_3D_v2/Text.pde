//Title text
void titleOne() {
  fill(colors[5]);
  textSize(26);
  textAlign(RIGHT, TOP);
}

void titleTwo() {
  fill(120);
  textSize(20);
  textAlign(RIGHT, TOP);
}

void draw2DText() {
  // Title
  pushMatrix();
  translate(0, 0, 1);
  fill(colors[5]);
  textSize(32);
  textAlign(LEFT, TOP);
  String title = "From Political Joke to the 45th President";
  text(title, verticalLines[0], 0.08 * height, 700, 200);

  fill(120);
  textSize(24);
  textAlign(LEFT, TOP);
  String subtitle = "How Trump's Presidential Campaign Influenced Seattle's Reading Consumption";
  text(subtitle, verticalLines[0], 0.14 * height, 500, 200);
  popMatrix();
}

// TOP - Google
void drawGoogleText() {
  pushMatrix();
  titleOne();
  text("Google Trend", verticalLines[4], horizonalLines[0], 400, 300);

  titleTwo();
  String googleTrend ="The curve shows the how many times people searched 'Donald Trump' on Google every month, from January 2015 to December 2017."; 
  text(googleTrend, verticalLines[4], horizonalLines[1], 400, 300);
  popMatrix();
}

// BOTTOM - Library
void drawLibText() {
  pushMatrix();
  translate(0, 0, 1);
  titleOne();
  text("Seattle Public Library", verticalLines[4], horizonalLines[2], 400, 300);

  titleTwo();
  String libData ="The bars represent the library's cheking records on Trump's books and DVDs each month over the same period of time."; 
  text(libData, verticalLines[4], horizonalLines[3], 400, 300);
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
    text("Trump officially announced his candidacy for president of the United States. He introduced his plans to build a “great wall” on the U.S.-Mexico border.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 8: 
    text("Aug 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("During the first GOP debate in Cleveland, Ohio, Trump attracted boos when he said he wouldn’t pledge to support whoever won the party’s nomination.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 9: 
    text("Sep 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump unveiled his tax plan from Trump Tower, promising that he would “shift the burden” to wealthy families. Of his plan, Trump said, “If you’re single and earn less than $25,000 per year, or married and jointly earn less than $50,000, you’ll not pay any income tax. Nothing.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 10: 
    text("Oct 2015", verticalLines[3], horizonalLines[2]);
    break;
  case 11: 
    text("Nov 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("As the host of Saturday Night Live, Trump danced to Drake’s “Hotline Bling,” and fake live-tweeted a sketch. The episode gave the long-running series its best ratings in four years.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 12: 
    text("Dec 2015", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump scored a public endorsement from Russian President Vladimir Putin, who said he would “welcome” the businessman as president. In response, Trump issued a statement to PEOPLE, saying, “It is always a great honor to be so nicely complimented by a man so highly respected within his own country and beyond.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 13: 
    text("Jan 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Once again at the front of the GOP pack, Trump proudly declared, “I could stand in the middle of Fifth Avenue and shoot somebody and I wouldn’t lose any voters.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 14: 
    text("Feb 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Once again at the front of the GOP pack, Trump proudly declared, “I could stand in the middle of Fifth Avenue and shoot somebody and I wouldn’t lose any voters.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 15: 
    text("Mar 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump won seven of the 11 states that vote on so-called Super Tuesday.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 16: 
    text("Apr 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Trump won his home state of New York’s primary on April 16, but still complained about the delegate selection system, which he dubbed “rigged.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 17: 
    text("May 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("During a speech in Fort Wayne, Indiana, ahead of the state’s primaries, Trump charged, “We can’t continue to allow China to rape our country.”", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 18: 
    text("Jun 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("Republican leaders were quick to distance themselves from Trump after the candidate made anti-Muslim comments in the wake of the shooting at an Orlando nightclub that left 49 dead.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 19: 
    text("Jul 2016", verticalLines[3], horizonalLines[2]);
    textSize(20);
    text("In a July tweet, Trump unveiled that Indiana Gov. Mike Pence would be his vice presidential running mate.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 20: 
    text("Aug 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 21: 
    text("Sep 2016", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Two presidential debates took place and the national attention reached all time peak.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 22: 
    text("Oct 2016", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Trump clashes with Clinton before an audience of tens of millions in three presidential debates that are marked by their unusually ugly tone - Trump at one point said Clinton should be in jail. Public polls show that most Americans thought Clinton prevailed in all three debates.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 23: 
    text("Nov 2016", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Trump wins the U.S. presidential election in one of the biggest upsets in decades.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 24: 
    text("Dec 2016", verticalLines[3], horizonalLines[2]);
    break;
  case 25: 
    text("Jan 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Trump signs his first executive order to start rolling back Obamacare. Later signs orders directing the construction of a US-Mexico border wall and the travel ban.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 26: 
    text("Feb 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Judge blocks Trump's travel ban. Michael Flynn resigns as national security adviser.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 27: 
    text("Mar 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Without evidence, Trump accuses Obama of wiretapping Trump Tower. FBI Director James Comey confirms that the bureau is investigating alleged Trump campaign ties to Russian election meddling.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 28: 
    text("Apr 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("The US launches a military strike on a Syrian government airbase. During the strike, Trump dines with Xi at Mar-a-Lago.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 29: 
    text("May 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("White House announces Trump's first foreign trip as President: Saudi Arabia, Israel and the Vatican. / Trump fires FBI Director James Comey.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 30: 
    text("Jun 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Comey testifies: Trump asked me to let Flynn investigation go. ", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 31: 
    text("Jul 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Trump's approval rating drops to 36% in a Washington Post/ABC News poll.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 32: 
    text("Aug 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Bannon fired.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 33: 
    text("Sep 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Justice Department: No evidence of wiretapping of Trump Tower. / Supreme Court: Trump administration can keep travel ban on most refugees.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 34: 
    text("Oct 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("Trump avoids gun control talk in Las Vegas visit. / Trump says he will release JFK docs.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 35: 
    text("Nov 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("US implements tighter sanctions on Cuba.", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  case 36: 
    text("Dec 2017", verticalLines[3], horizonalLines[2]);
    textSize(18);
    text("", verticalLines[3], horizonalLines[3], 700, 300);
    break;
  }
  popMatrix();

  //translate(0, -0.1*(horizonalLines[1]-horizonalLines[2]));
  //fill(255*7/8, 100);
  //Parallelogram(0.04*width,horizonalLines[0],verticalLines[0]-0.04*width, horizonalLines[1]/2-0.04*height,0.2);
  //translate(0, 0.1*(horizonalLines[1]-horizonalLines[0]));
}