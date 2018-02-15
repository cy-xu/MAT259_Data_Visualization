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


void setup() {
  //fullScreen();
  size(1440, 800, P3D);
  background(30, 30, 30, 10);
  // frameRate(4);

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
  horizonalLines[0] = 0.28 * height;
  horizonalLines[1] = 0.32 * height;
  horizonalLines[2] = 0.82 * height;
  horizonalLines[3] = 0.82 * height;

  verticalLines = new float[4];
  verticalLines[0] =  0.06 * width;
  verticalLines[1] =  0.20 * width;
  verticalLines[2] =  0.50 * width;
  verticalLines[3] =  0.75 * width;

  timeCover = createGraphics(40, 40);

  table = loadTable("trump_2015_2017.csv", "header");
  rows = table.getRowCount();
  cols = table.getColumnCount();

  //println("Rows: " + rows);
  //println("Columns: " + cols);

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
}

//Refresh the canvas every frame
void draw() {
  background(200, 100);

  // Change height of the camera with mouseY
  camera(30.0, map(mouseY, 0, height, -height, height), 220.0, // eyeX, eyeY, eyeZ
    0.0, 0.0, 0.0, // centerX, centerY, centerZ
    0.0, 1.0, 0.0); // upX, upY, upZ

  translate(-width/1.5, -height/2.0, 0);

  fill(colors[0], 100);
  stroke(200, 100);
  rectMode(CORNERS);
  rect(width*0.04, height*0.04, width*0.96, height*0.96);

  // Time Cover
  //timeCover.beginDraw();
  //timeCover.background(100);
  //timeCover.stroke(255);
  //timeCover.line(20, 20, mouseX, mouseY);
  //timeCover.endDraw();
  //image(timeCover, 9, 30); 
  //image(timeCover, 51, 30);

  mouseInRect();
  whichMonth();

  //draw Google Trend
  drawGoogleCurve();

  // draw verticle line based on mouseX
  //drawMouseVert();

  drawLibrary();
  drawLibrary2();


  drawText();
}