PGraphics timeCover;
Table table;
int rows, cols;
float[][] flMatrix;
float curveWidth;
float flMax, flMin = 0;
float borders[];
float base;
color[] colors;
float[] verticalLines;
float[] horizonalLines;

PMatrix3D baseMat;
float alpha =0;

void setup() {
  fullScreen(P3D);
  //size(860, 600, P3D);
  background(30, 30, 30, 10);
  // frameRate(4);

  // Remember the start model view matrix values
  baseMat = getMatrix(baseMat);

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
  horizonalLines[0] = 0.22 * height;
  horizonalLines[1] = 0.26 * height;
  horizonalLines[2] = 0.6 * height;
  horizonalLines[3] = 0.6 * height;

  verticalLines = new float[4];
  verticalLines[0] =  0.06 * width;
  verticalLines[1] =  0.20 * width;
  verticalLines[2] =  0.50 * width;
  verticalLines[3] =  0.75 * width;

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

  smooth(4);
  getRectHeight();
  loadArrayList();

  // load all time magazine covers
  loadCovers();
}

//Refresh the canvas every frame
void draw() {
  background(200, 100);

  scale(0.3);
  translate(-width/2.0, -height/2.0, 0);

  pushMatrix(); // start drawing in 3D

  // background rectangle 
  //fill(colors[0], 100);
  //stroke(200, 100);
  //rectMode(CORNERS);
  //rect(width*0.04, height*0.04, width*0.96, height*0.96);

  //textMode(SHAPE);

  //draw Google Trend
  drawGoogleCurve();

  // draw library box, rotate 30 degree

  // draw verticle line based on mouseX
  //drawMouseVert();
  pushMatrix();
  drawLibrary();
  popMatrix();

  pushMatrix();
  showLibrary();
  popMatrix();


  pushMatrix();
  if (camAngle() < 0) {
    rotateX(map(camAngle(), 0, -height/4.0, 0, 0.3 * PI));
    translate(0, map(camAngle(), 0, -height/4.0, 0, -height/8.0), map(camAngle(), 0, -height/4.0, 0, -height/8.0));
  }
  drawGoogleText();
  drawEventText();
  drawLibText();
  draw2DText();
  popMatrix();

  // draw Time magazine cover
  drawCovers();

  popMatrix(); // end drawing 3D

  this.setMatrix(baseMat); // begin drawing 2D


  // Change height of the camera with mouseY
  camera(0.0, camAngle(), 220.0, // eyeX, eyeY, eyeZ
    0.0, 0.0, 0.0, // centerX, centerY, centerZ
    0.0, 1.0, 0.0); // upX, upY, upZ

  //float fov = PI/3;
  //float cameraZ = (height/2.0) / tan(fov/2.0);  
  //perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
}