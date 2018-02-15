int[][] dataMatrix;
int[] dataMax;
int[] dataMin;
int[] dataSum;
Table[] CheckoutTimes;
Table jobApproval;
float cellHeight, cellWidth;
PFont[] Fonts;
boolean shouldShowCurve, mouseClick, shouldFollow;
color[] colors;
float[] verticalLines;
float[] horizonalLines;

int detailsI, detailsJ;
void setup() {
  fullScreen();
  //size(1000, 700);
  dataMatrix = new int[12*7][4];
  dataMax = new int[4];
  dataMin = new int[4];
  dataSum = new int[4];

  CheckoutTimes = new Table[3];
  CheckoutTimes[0] = loadTable("Couts of all books by month.csv");
  CheckoutTimes[1] = loadTable("Couts of all dvds by month.csv");
  CheckoutTimes[2] = loadTable("Couts of all cds by month.csv");

  jobApproval = loadTable("job_approval.csv");

  Fonts = new PFont[3];
  //Fonts[0] = loadFont("AppleGothic-12.vlw");
  Fonts[1] = loadFont("EurostileRegular-12.vlw");
  Fonts[2] = loadFont("EurostileRegular-48.vlw");

  colors = new color[3];
  colors[0] = #565B77;
  colors[1] = #6FDEFD;
  colors[2] = #43AD8A;

  horizonalLines = new float[4];
  horizonalLines[0] = 1.f/8*height;
  horizonalLines[1] = 3.f/8*height;
  horizonalLines[2] = 1.f/2*height;
  horizonalLines[3] = 7.f/8*height;

  verticalLines = new float[4];
  verticalLines[0] =  1.f/8*width;
  verticalLines[1] =  2.f/8*width;
  verticalLines[2] =  5.f/8*width;
  verticalLines[3] =  7.f/8*width;

  cellWidth = (verticalLines[3] - verticalLines[1])/(7*12);
  cellHeight = (horizonalLines[3]-horizonalLines[2])/3;

  shouldShowCurve = false;
  mouseClick = false;
  shouldFollow = true;

  for (int i = 0; i <7; i++ ) {
    for (int j = 0; j<12; j++) {
      String month= str(2000+i+8)+"-"+nf(j+1, 2, 0);
      //print(month);
      TableRow[] row = new TableRow[3];
      for (int k = 0; k<3; k++) {
        row[k] = CheckoutTimes[k].findRow(month, 0);
        if (row[k]!=null) {
          dataMatrix[i*12+j][k] = row[k].getInt(1);
        } else {
          dataMatrix[i*12+j][k] = 0;
        }
      }
      dataMatrix[i*12+j][3] = jobApproval.getInt(i*12+j, 0);
    }
  }

  for (int i = 0; i<4; i++) {
    dataMax[i] = 0;
    dataMin[i] = 1000;
    dataSum[i] = 0;
    for (int j = 0; j<12*7; j++) {
      if (dataMatrix[j][i]>dataMax[i]) dataMax[i] = dataMatrix[j][i];
      if (dataMatrix[j][i]<dataMin[i]) dataMin[i] = dataMatrix[j][i];
      dataSum[i] = dataSum[i] + dataMatrix[j][i];
    }
  }

  smooth();
  noStroke();
}

void draw() {
  background(255*7/8, 100);

  fill(255);
  rectMode(CORNERS);
  rect(width*0.04, height*0.04, width*0.96, height*0.96);

  noFill();

  //for (int i = 0; i< 4; i++) {
  //  line(verticalLines[i], 0, verticalLines[i], height);
  //  line(0, horizonalLines[i], width, horizonalLines[i]);
  //}
  if (shouldShowCurve) drawJobApprovalCurve();

  noStroke();
  boolean isMouseIn = false;
  for (int j = 0; j < 3; j++) {
    for (int i = 0; i < 7*12; i++) {
      if (drawCell(i, j)) {
        isMouseIn = true;
        doMouseInteraction(i, j);
        if (shouldFollow) {
          detailsI = i;
          detailsJ = j;
        } else if (mouseClick) {
          detailsI = i;
          detailsJ = j;
          mouseClick = false;
        }
      }
    }
  }
  if (!isMouseIn) {
    if (shouldFollow) {
      detailsI = -1;
      detailsJ = -1;
    } else {
      if (mouseClick) {
        detailsI = -1;
        detailsJ = -1;
        mouseClick = false;
      }
    }
  }

  doMouseInteractionForDetails(detailsI, detailsJ);

  drawLabel();
}

boolean drawCell(int verticalIndex, int horizonalIndex) {

  float percent = float(dataMatrix[verticalIndex][horizonalIndex])/dataMax[horizonalIndex];
  fill(lerpColor(colors[0], colors[1], percent), 150);

  float startY = horizonalLines[2]+horizonalIndex*cellHeight;
  float startX = verticalLines[1]+verticalIndex*cellWidth;
  rectMode(CORNER);
  rect(startX, startY, cellWidth, cellHeight*0.5, 0);

  boolean isMouseInX = (mouseX>startX) && (mouseX < startX+cellWidth);
  boolean isMouseInY = (mouseY>(startY))&& (mouseY < (startY+cellHeight*0.5));
  boolean isMouseIn = isMouseInX && isMouseInY;
  return isMouseIn;
}

void doMouseInteraction(int verticalIndex, int horizonalIndex) {
  float percent = float(dataMatrix[verticalIndex][horizonalIndex])/dataMax[horizonalIndex];
  float startY = horizonalLines[2]+horizonalIndex*cellHeight;
  float startX = verticalLines[1]+verticalIndex*cellWidth;

  fill(lerpColor(colors[0], colors[1], percent), 255);
  rect(startX, startY, cellWidth, cellHeight*0.5);

  if (verticalIndex>=12 && shouldShowCurve) {
    float jobApprovalPercent = map(dataMatrix[verticalIndex-12][3], dataMin[3], dataMax[3], 0, 1);
    color jobApprovaColor = lerpColor(colors[0], colors[1], jobApprovalPercent);
    fill(jobApprovaColor, 240);
    Parallelogram(verticalLines[1]+ (verticalIndex+0.5)*cellWidth-6, 
      map(dataMatrix[verticalIndex-12][3], dataMin[3], dataMax[3], horizonalLines[3], horizonalLines[1])-6, 12, 12, 0.2);
  }
}

void doMouseInteractionForDetails(int verticalIndex, int horizonalIndex) {

  if (verticalIndex>=0&&horizonalIndex>=0) {

    // Details Part
    //
    float percent = float(dataMatrix[verticalIndex][horizonalIndex])/dataMax[horizonalIndex];
    float detailTextX = 0.5*(verticalLines[2]+verticalLines[3])-3;
    float detailTextY1 = 0.5*(horizonalLines[0]+horizonalLines[1]);
    float detailTextY2 = 0.5*(horizonalLines[0]+horizonalLines[1]) + 20;
    float detailTextY3 = 0.5*(horizonalLines[0]+horizonalLines[1]) + 40;
    color detailBlockColor =  lerpColor(colors[0], colors[1], percent);
    String typeName = "";
    switch(horizonalIndex) {
    case 0 : 
      typeName = "Book";
      break;
    case 1 : 
      typeName = "DVD";
      break;
    case 2 : 
      typeName = "CD";
      break;
    }

    // Main Block
    //
    fill(detailBlockColor);
    Parallelogram( 0.5*(verticalLines[2]+verticalLines[3]), 0.5*(horizonalLines[0]+horizonalLines[1]), 
      0.5*(verticalLines[3]-verticalLines[2]), 0.5*(horizonalLines[1]-horizonalLines[0]), 0.2);

    // Text
    fill(0);
    textFont(Fonts[1], 12);
    textAlign(RIGHT, TOP);
    text(str(2008+verticalIndex/12)+"/"+nf(verticalIndex%12+1, 2), detailTextX, detailTextY1);
    text(typeName+" Checkouts: " + str(dataMatrix[verticalIndex][horizonalIndex]), detailTextX, detailTextY2);

    // Job Approval part
    //
    if (verticalIndex>=12 && shouldShowCurve) {
      text("Job Approval: " + str(dataMatrix[verticalIndex-12][3])+"%", detailTextX, detailTextY3);
      float jobApprovalPercent = map(dataMatrix[verticalIndex-12][3], dataMin[3], dataMax[3], 0, 1);
      color jobApprovaColor = lerpColor(colors[0], colors[1], jobApprovalPercent);
      fill(jobApprovaColor, 240);
      Parallelogram( 0.5*(verticalLines[2]+verticalLines[3]), 0.3*horizonalLines[0]+0.7*horizonalLines[1], 
        0.5*(verticalLines[3]-verticalLines[2]), 0.3*(horizonalLines[1]-horizonalLines[0]), 0.2/0.6);
    }
  }
}

void Parallelogram(float startX, float startY, float Width, float Height, float ratio) {
  beginShape();
  vertex(startX, startY);
  vertex(startX+Width, startY+Height*ratio);
  vertex(startX+Width, startY+Height);
  vertex(startX, startY+Height*(1-ratio));
  endShape();
}

void drawJobApprovalCurve() {
  strokeWeight(2);
  stroke(colors[0]);
  beginShape();
  curveVertex(verticalLines[1]+ (0+12+0.5)*cellWidth, map(dataMatrix[0][3], dataMin[3], dataMax[3], horizonalLines[3], horizonalLines[1]));
  for (int i = 0; i < 6*12; i++) {
    curveVertex(verticalLines[1]+ (i+12+0.5)*cellWidth, map(dataMatrix[i][3], dataMin[3], dataMax[3], horizonalLines[3], horizonalLines[1]));
  }
  curveVertex(verticalLines[1]+ (71+12+0.5)*cellWidth, map(dataMatrix[71][3], dataMin[3], dataMax[3], horizonalLines[3], horizonalLines[1]));
  endShape();
  line(verticalLines[0], horizonalLines[2]- 0.5*cellHeight, 0.5*(verticalLines[0]+verticalLines[1]), horizonalLines[2]- 0.5*cellHeight);
}

void drawLabel() {

  fill(0);

  // Horizonal lables
  //
  textAlign(LEFT, BOTTOM);
  textFont(Fonts[1], 12);
  text(str(2008)+"/"+nf(1, 2), verticalLines[1], horizonalLines[2]);
  textAlign(RIGHT, BOTTOM);
  text(str(2014)+"/"+str(12), verticalLines[3], horizonalLines[2]);


  // Vertical labels
  //
  textAlign(LEFT, TOP);
  textFont(Fonts[1], 12);
  text("Book", verticalLines[0], horizonalLines[2]+ 0*cellHeight);
  text("DVD", verticalLines[0], horizonalLines[2] + 1*cellHeight);
  text("CD", verticalLines[0], horizonalLines[2] + 2*cellHeight);
  if (shouldShowCurve) {
    text("Job Approval", verticalLines[0], horizonalLines[2]- cellHeight);
  }

  // Max an Min
  //
  int gradingNum = 7;
  float gradingLength = (verticalLines[1]-verticalLines[0])/2;
  float gradingSize = gradingLength/gradingNum;
  for (int i = 0; i < gradingNum; i++) {
    fill(lerpColor(colors[0], colors[1], i/6.f), 150);
    noStroke();
    rectMode(CORNER);
    rect(verticalLines[0]+gradingSize*i, horizonalLines[2]+0.5*cellHeight-gradingSize, gradingSize, gradingSize);
    rect(verticalLines[0]+gradingSize*i, horizonalLines[2]+1.5*cellHeight-gradingSize, gradingSize, gradingSize);
    rect(verticalLines[0]+gradingSize*i, horizonalLines[2]+2.5*cellHeight-gradingSize, gradingSize, gradingSize);
  }

  textFont(Fonts[1], 10);
  fill(128);
  for (int i = 0; i < 3; i++) {
    textAlign(LEFT, BOTTOM);
    text(str(dataMin[i]), verticalLines[0], horizonalLines[2]+ (i+0.5)*cellHeight - gradingSize);
    textAlign(RIGHT, BOTTOM);
    text(str(dataMax[i]), verticalLines[0]+gradingLength, horizonalLines[2]+ (i+0.5)*cellHeight - gradingSize);
  }
  if (shouldShowCurve) {
    textAlign(LEFT, BOTTOM);
    text(str(dataMin[3])+"%", verticalLines[0], horizonalLines[2] - 0.5*cellHeight -2);
    textAlign(RIGHT, BOTTOM);
    text(str(dataMax[3])+"%", verticalLines[0]+gradingLength, horizonalLines[2] - 0.5*cellHeight - 2);
  }

  //Title text
  //
  pushMatrix();
  //translate(0, -0.1*(horizonalLines[1]-horizonalLines[0]));
  //fill(255*7/8, 100);
  //Parallelogram(0.04*width,horizonalLines[0],verticalLines[0]-0.04*width, horizonalLines[1]/2-0.04*height,0.2);
  //translate(0, 0.1*(horizonalLines[1]-horizonalLines[0]));

  fill(128, 200);
  textFont(Fonts[2], 20);
  textAlign(LEFT, TOP);
  text(" Job Approval and \n Checkout Times of Related Items of", verticalLines[0], horizonalLines[0]);
  translate(0, 55);
  fill(0);
  textFont(Fonts[2], 42);
  textAlign(LEFT, TOP);
  text("BARACK OBAMA", verticalLines[0], horizonalLines[0]);
  popMatrix();
}

void keyPressed() {
  if (key == 'C' || key == 'c') {
    shouldShowCurve = !shouldShowCurve;
    print(shouldShowCurve);
  }
  if (key == 'F' || key == 'f') {
    shouldFollow = !shouldFollow;
    print(shouldFollow);
  }
}
void mouseClicked() {
  mouseClick = true;
}