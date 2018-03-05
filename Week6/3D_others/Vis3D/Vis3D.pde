
import peasy.*;
import processing.opengl.*;
PImage sprite;
PShader pointShader;
Table overall_data;
int [][] AllCheckPerMonth;

PeasyCam cam;

float groundPlaneSizeX = 100;
float groundPlaneSizeY = 200;
int cellNumX = 6;
int cellNumY = 12;
float cellSizeX = groundPlaneSizeX / cellNumX;
float cellSizeY = groundPlaneSizeY / cellNumY;

int fadeCounter = 0;
color backGroundColor = color(64,64,64);
int whichSelect = -1;
boolean transit = false;
int stage = -1;
boolean displayAll = true;
// evolution time step.
float dt = 1.0;
float weight = 40;
int npartTotal = 2000;
int npartPerFrame = 25;
int partLifetime;
float yGroundPos = 40;
Psysem [][] psystems1;
Psysem [][] psystems2;
Psysem [][] psystems3;
Psysem [][] psystems4;
boolean inTransit = false;
String [] labelText;
checkTimeFour [] checkTimeAll;
color [] StrokeCT;
color [] CT;
color [][] CSubT;
color [] PT;
Arrow [] arrows;
color [] LableColor;

void setup(){
  size(1200, 800, P3D);
  DefColors();
  labelText = new String[4];
  //fullScreen();
  cam = new PeasyCam(this, 300);
  cam.rotateY(PI*0.5);
  cam.rotateX(PI*0.2);
  //println(height);
  //Added on Jan 30th by Rodger Luo
  float  cameraZ = (height/2.0) / tan(PI*60.0/360.0);
  perspective(PI/3.0, float(width)/float(height), 0.001, cameraZ*10.0); //set near clip to 0.001 to go inside data
  //Finishd adding 
  pointShader= loadShader("frag.glsl", "vert.glsl");
  pointShader.set("weight", weight);
  pointShader.set("sprite", loadImage("sprite.png"));
  
  sprite = loadImage("sprite.png");
  partLifetime = npartTotal / npartPerFrame;

  
  //hint(DISABLE_DEPTH_MASK);
  checkTimeAll = new checkTimeFour[4];
  checkTimeAll[0] = new checkTimeFour("data/AggreratedDay/Drama");
  checkTimeAll[1] = new checkTimeFour("data/AggreratedDay/Fantasy");
  checkTimeAll[2] = new checkTimeFour("data/AggreratedDay/History");
  checkTimeAll[3] = new checkTimeFour("data/AggreratedDay/Scifi");
  overall_data = loadTable("AllCheckPerMonth.csv", "header");
  int numRow = overall_data.getRowCount();
  int numCol = overall_data.getColumnCount();
  // println (numRow, numCol);
  AllCheckPerMonth = new int[numCol-1][numRow];
  for (int i = 0; i < numRow; i++) {
    for (int j = 0; j < numCol - 1; j++) {
      AllCheckPerMonth[j][i] = overall_data.getInt(i, j+1);
    }
  }

  psystems1 = new Psysem [cellNumX][cellNumY];
  psystems2 = new Psysem [cellNumX][cellNumY];
  psystems3 = new Psysem [cellNumX][cellNumY];
  psystems4 = new Psysem [cellNumX][cellNumY];
  AllInit();
  
  labelText[0] = "Drama";
  labelText[1] = "Fantasy";
  labelText[2] = "History";
  labelText[3] = "Scifi";
  
}

void draw(){
  background(backGroundColor);
  if (!inTransit) {
    pushMatrix();
    drawLabels();  
    popMatrix();
  }
  
  pushMatrix();
  strokeWeight(1);
  drawGround(cellNumX, cellNumY, groundPlaneSizeX, groundPlaneSizeY, transit, whichSelect, 300.0);
  popMatrix();
  
  pushMatrix();
  //float[] rota = cam.getRotations();
  //rotateX(rota[0]);
  //rotateY(rota[1]);
  //rotateZ(rota[2]);
  shader(pointShader, POINTS);
  if (!inTransit) {
  for (int i = 0; i < cellNumX; i++) {
    for (int j = 0; j < cellNumY; j++) {
    psystems1[i][j].drawAllParticles();
    psystems1[i][j].evolveParticles();
    psystems2[i][j].drawAllParticles();
    psystems2[i][j].evolveParticles();
    psystems3[i][j].drawAllParticles();
    psystems3[i][j].evolveParticles();
    psystems4[i][j].drawAllParticles();
    psystems4[i][j].evolveParticles();
    }
  }
  }
  popMatrix();
  
}

void drawLabel0() {
  fill(255);
  textSize(50);
  pushMatrix();
  fill(255);
  textAlign(LEFT, TOP);
  translate(groundPlaneSizeX,0, groundPlaneSizeY*0.5);
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);
  scale(0.15);
  text(labelText[0], 0, 0, 0);
  popMatrix();
}

void drawLabel1() {
  fill(255);
  textSize(50);
  pushMatrix();
  fill(255);
  textAlign(LEFT, TOP);
  translate( - groundPlaneSizeX,0, groundPlaneSizeY*0.5);
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);
  scale(0.15);
  text(labelText[1], 0, 0, 0);
  popMatrix();
}

void drawLabel2() {
  fill(255);
  textSize(50);
  pushMatrix();
  fill(255);
  textAlign(LEFT, TOP);
  translate( - groundPlaneSizeX,0, -groundPlaneSizeY*0.5);
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);;
  scale(0.15);
  text(labelText[2], 0, 0, 0);
  popMatrix();
}

void drawLabel3() {
  fill(255);
  textSize(50);
  pushMatrix();
  fill(255);
  textAlign(LEFT, TOP);
  translate(groundPlaneSizeX,0, -groundPlaneSizeY*0.5);
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);
  scale(0.15);
  text(labelText[3], 0, 0, 0);
  popMatrix();
}

void drawAxisLabel() {
  fill(255);
  textSize(8);
  pushMatrix();
  textAlign(LEFT, TOP);
  translate(-10, yGroundPos - 10, -groundPlaneSizeY - 20);
  rotateX(PI/4.0);
  //scale(0.1);
  text("Year", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(-groundPlaneSizeX - 10, yGroundPos - 25, 15);
  rotateY(PI*0.5);
  rotateX(PI/4.0);
  //scale(0.1);
  text("Month", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textSize(5);
  translate(-groundPlaneSizeX + cellSizeX*0.2 , yGroundPos - 15, -groundPlaneSizeY);
  rotateX(PI/4.0);
  //scale(0.08);
  int i = 2012;
  for (int j = 0; j < 12; j++) {
    text(str(i),0,0,0);
    translate(cellSizeX , 0,0);
    i++;
    if (j == 5) {
      i = 2012;
    }
  }
  popMatrix();
  
  pushMatrix();
  textSize(8);
  translate(-groundPlaneSizeX - 10, yGroundPos - 15, -groundPlaneSizeY + cellSizeY * 0.7);
  //rotateX(PI/4.0);
  //scale(0.08);
  i = 1;
  for (int j = 0; j < 24; j++) {
    pushMatrix();
    rotateY(PI*0.5);
    rotateX(PI/4.0);
    text(str(i),0,0,0);
    popMatrix();
    translate(0, 0,cellSizeY);
    i++;
    if (j == 11)
      i = 1;
  }
  popMatrix();
  
  pushMatrix();
  translate(0, yGroundPos - 2, 0);
  strokeWeight(5.0);
  stroke(255,255,255);
  line(-groundPlaneSizeX, 0, 0, groundPlaneSizeX, 0, 0);
  line(0,0,- groundPlaneSizeY, 0, 0, groundPlaneSizeY);
  line(-groundPlaneSizeX, 0, - groundPlaneSizeY, groundPlaneSizeX, 0, - groundPlaneSizeY);
  line(-groundPlaneSizeX, 0, - groundPlaneSizeY, -groundPlaneSizeX, 0, groundPlaneSizeY);
  popMatrix();
}

void drawLabels(){
  drawLabel0();
  drawLabel1();
  drawLabel2();
  drawLabel3();
  drawAxisLabel();
}

void drawOneLabel(int idx) {
  if (idx == 0) {
    drawLabel0();
  } else if (idx == 1) {
    drawLabel1();
  } else if (idx == 2) {
    drawLabel2();
  } else {
    drawLabel3();
  }
}