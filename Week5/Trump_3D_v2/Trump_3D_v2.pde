/************************************************************************************* //<>//
 Data Visualization - From Political Joke to the 45th President               
 Tested in Processing 3                                    
 
 Author: Chengyuan Xu                        
 Supervisor: Jieliang Luo                           
 
 Purpose: Find out the correlation between major campaign events, media coverage,
 internet trend and Seattle people's reading habits.
 
 Library: Processing Video
 
 Reference: Daniel Shiffman - https://github.com/shiffman/The-Nature-of-Code-Examples
 
 Usage: Vertical movement of the mouse to see different information from different
 angles, horizontal movement of the mouse to switch between different months.
 *************************************************************************************/

// added for motion control
import processing.video.*;
Capture video;
PImage prev;
float threshold = 500;
int motionCount = 0;

PGraphics timeCover;
Table table;
int rows, cols;
int wwidth, hheight;
float[][] flMatrix;
float curveWidth;
float flMax, flMin = 0;
float borders[];
float base;
color[] colors;
float[] verticalLines;
float[] horizonalLines;

PImage[] coversToDraw;

PMatrix3D baseMat;
float alpha =0;

void setup() {
  fullScreen(P3D);
  //size(860, 600, P3D);
  background(30, 30, 30, 10);
  textMode(SHAPE);
  smooth(4);

  wwidth = width;
  hheight = height;
  println(wwidth);

  // added for motion control
  video = new Capture(this, 640, 360);
  video.start();
  prev = createImage(640, 360, RGB);



  // Remember the start model view matrix values
  baseMat = getMatrix(baseMat);
  mouseX = 0;
  mouseY = int(0.7 * height);

  base = 0.5 * height;

  colors = new color[6];
  colors[0] = #f8f8f8; // gray background
  colors[1] = #FB90B2; // Pink
  //colors[2] = #84D3FD; // Blue
  colors[2] = #3992d4; // Blue
  colors[3] = #bcbcbc; // Darker gray
  colors[4] = #86FCAB;
  colors[5] = #575757; // black font

  borders = new float[4];
  borders[0] = 0.04 * width;
  borders[1] = 0.04 * height;
  borders[2] = 0.96 * width;
  borders[3] = 0.96 * height;

  horizonalLines = new float[4];
  horizonalLines[0] = 0.14 * height;
  horizonalLines[1] = 0.20 * height;
  horizonalLines[2] = 0.6 * height;
  horizonalLines[3] = 0.66 * height;

  verticalLines = new float[5];
  verticalLines[0] =  0.06 * width;
  verticalLines[1] =  0.20 * width;
  verticalLines[2] =  0.50 * width;
  //verticalLines[3] =  0.5 * width;
  verticalLines[3] =  0.06 * width;
  verticalLines[4] =  0.64 * width;

  // import library & Google data
  table = loadTable("trump_2015_2017.csv", "header");
  rows = table.getRowCount();
  cols = table.getColumnCount();

  // Read CSV table values Google and Library to a matrix
  flMatrix = new float[rows][cols-2];
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < flMatrix[0].length; j++) {
      //flMatrix[i][j] = log(table.getFloat(i, j+2)) + 1;
      flMatrix[i][j] = table.getFloat(i, j+2);
      //println(flMatrix[i][j]);
    }
  }

  getRectHeight();
  loadArrayList();

  // load all time magazine covers
  loadCovers();
}

// added for montion control
void captureEvent(Capture video) {
  prev = video.copy();
  prev.updatePixels();
  video.read();
  //motion();
}

//Refresh the canvas every frame
void draw() {
  background(200, 100);
  translate(-width/2.0, -height/2.0, 0);

  pushMatrix(); // start drawing in 3D

  // background rectangle 
  //fill(colors[0], 100);
  //stroke(200, 100);
  //rectMode(CORNERS);
  //rect(width*0.04, height*0.04, width*0.96, height*0.96);

  //draw Google Trend
  drawGoogleCurve();

  //draw verticle line based on mouseX
  //drawMouseVert();
  pushMatrix();
  drawLibrary();
  popMatrix();

  pushMatrix();
  showLibrary();
  popMatrix();


  pushMatrix();

  drawGoogleText();
  drawEventText();
  drawLibText();
  draw2DText();
  popMatrix();

  // draw Time magazine cover
  //drawWhichCover();
  coversToDraw = drawWhichCover();
  drawCovers();

  popMatrix(); // end drawing 3D

  // begin drawing 2D
  this.setMatrix(baseMat); 

  // added for motion control
  pushMatrix();
  //translate(width/2.0, height/2.0, 20);
  //image(motion, 0, 0);
  popMatrix();


  // Change height of the camera with mouseY
  camera(0, camY(), camZ(), // eyeX, eyeY, eyeZ
    0.0, 0.0, 0.0, // centerX, centerY, centerZ
    0.0, 1.0, 0.0); // upX, upY, upZ

  //float fov = PI/3;
  //float cameraZ = (height/2.0) / tan(fov/2.0);  
  //perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
}


void keyPressed() {
  if (key == 'a') {
    threshold += 20;
  } else if (key == 'z') {
    threshold -= 20;
  }

  println(threshold);
}