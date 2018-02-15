/*************************************************************************************
 Data Visualization - 3D Tree Map Demo                
 Tested in Processing 3                                    
 
 Author: Rodger (Jieliang) Luo                        
 Supervisor: George Legrady
 
 Modified on Feb 6th, 2017
 
 Purpose: Showing how to present multiple tree maps in 3D space by 
 using curve lines as connections.
 
 Usage: 1. Check Presentation Mode for going through all deweys automatically
        2. Enter specific dewey class for see individual trajectory of that dewey class.
        3. Press SPACE to go through all deweys manually. 
        4. Navigate Peasy Cam to explore the environment. 
 
 Required Libraries:
 1. Treemap Library by Ben Fry
 2. Peasy Cam -> Accessible from Processing Import Library 
 3. Control P5 -> Accessible from Processing Import Library
 *************************************************************************************/

/*
  Data we used in this demo are checkouts of each dewey class in 2006, separated in 12 months. 
*/

import treemap.*; //Tree Map library
import peasy.*; //3D Navigation library
import controlP5.*; //GUI library

//------------------------------------------------------------Constants Section
final int NUM_LAYERS = 12;   //Number of Layers;
                             //We set it to 12 because of 12 months. 
                             
final int LAYER_DIST = 200;  //Distance between each layer in virtual space 

final int TRANS = 100; // Transparacny of layers
//------------------------------------------------------------Variables Section
int selectedDewey = -100; // Set it to negative to make no dewey is selected at the start

boolean presentationMode = false; // true -> automation 
                                  // false -> no automation

PeasyCam cam; //Camera(3D Nav) varaible

ControlP5 cp5; //User Interface 

//Data-Related Variables
Table table;
Table deweyTable;
int numRows, numColumns;
float[][] dataMatrix;
String[] deweys;
ArrayList<String> deweyNames;

//TreeMap-Related Variables
DeweyMap[] deweyData;
Treemap[] map;

//Variables for drawing rects
ArrayList<ArrayList<PVector>> pointsOne = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsTwo = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsThree = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsFour = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);

//------------------------------------------------------------Setup Section
void setup() {
  size(1280, 720, OPENGL);
  
  //Initial camera and user interface 
  cam = new PeasyCam(this, 2000);
  cp5 = new ControlP5(this);


  //Add innotations at the top of canvas with Control P5 
  Textfield Dewey = cp5.addTextfield("dewey")
                       .setPosition(160, 10)
                       .setSize(50, 15)
                       .setFocus(true)
                       .setColor(color(0))
                       .setColorBackground(color(255))
                       .setColorActive(color(255))
                       .setColorForeground(color(255))
                       .setCaptionLabel("Please Enter A Dewey Number from 0 to 990")
                       ;
  Dewey.getCaptionLabel().getStyle().marginTop  = -16; 
  Dewey.getCaptionLabel().getStyle().marginLeft  = 55;
    
  cp5.addCheckBox("checkBox")
     .setPosition(20, 10)
     .setSize(15, 15) 
     .addItem("Presentation Mode", 1)
     //.activateAll() //This function makes the check box selected by default
     ;  
  cp5.setAutoDraw(false);


  //Put data into Processing table from csv
  table = loadTable("2006.csv", "header");
  numRows = table.getRowCount(); 
  numColumns = table.getColumnCount();
  dataMatrix = new float[numColumns-1][numRows];
  deweys = new String[numRows];
  println("Rows: " + numRows + " Columns: " + numColumns);
  deweyTable = loadTable("deweyClasses.csv", "header");
  deweyNames = new ArrayList<String>();
  for(int i=0; i<deweyTable.getRowCount(); i++){
    if(deweyTable.getInt(i,0) % 10 == 0){
      deweyNames.add(deweyTable.getString(i,1)); 
    }
  }
  
  //Put data from the table into a 2D array
  for (int i=0; i<numColumns-1; i++) {
    for (int j=0; j<numRows; j++) {
      dataMatrix[i][j] = table.getFloat(j, i+1);
    }
  }

  //Save Dewey categories into a 1D array
  for (int i=0; i<numRows; i++) {
    deweys[i] = table.getString(i, 0);
  }

  //Initialize tree map variables
  deweyData = new DeweyMap[NUM_LAYERS];
  map = new Treemap[NUM_LAYERS];
  for (int i=0; i<NUM_LAYERS; i++) { 
    deweyData[i]= new DeweyMap();
    pointsOne.add(new ArrayList<PVector>());
    pointsTwo.add(new ArrayList<PVector>());
    pointsThree.add(new ArrayList<PVector>());
    pointsFour.add(new ArrayList<PVector>());
  }

  //Add dewey categories and counts into tree map data structure
  //This part of the codes are based on Ben Fry's Tree Map library. 
  //Please see more details in the reference of TreeMap library (http://benfry.com/writing/treemap/reference/)  
  for (int i=0; i<dataMatrix.length; i++) {
    for (int j=0; j<dataMatrix[i].length; j++) {
      deweyData[i].addDewey(deweys[j], (int)dataMatrix[i][j]);
    }
    deweyData[i].finishAdd();
    map[i] = new Treemap(deweyData[i], 0, 0, width, height);
  }

  //Caculate points coordinates of the whole tree map structure 
  for (int i=0; i<dataMatrix.length; i++) {
    
    //Caculate and save coordinates of central point of each rect
    for (int j=0; j<deweyData[i].getItems().length; j++) {
      double x = deweyData[i].getItems()[j].getBounds().x;
      double y = deweyData[i].getItems()[j].getBounds().y;
      double w = deweyData[i].getItems()[j].getBounds().w; 
      double h = deweyData[i].getItems()[j].getBounds().h; 
      
      //Based on the central points, caculate coordinates of four corners of the rects 
      PVector pointOne = new PVector((int)x, (int)y, LAYER_DIST*(i-dataMatrix.length/2));
      pointsOne.get(i).add(pointOne);

      PVector pointTwo = new PVector((int)(x+w), (int)y, LAYER_DIST*(i-dataMatrix.length/2));
      pointsTwo.get(i).add(pointTwo);

      PVector pointThree = new PVector((int)(x+w), (int)(y+h), LAYER_DIST*(i-dataMatrix.length/2));
      pointsThree.get(i).add(pointThree);

      PVector pointFour = new PVector((int)x, (int)(y+h), LAYER_DIST*(i-dataMatrix.length/2));
      pointsFour.get(i).add(pointFour);
    }
  }
}

//------------------------------------------------------------Draw Section
void draw() {
  background(220);
  colorMode(HSB); // Change the color mode to HSB
  
  //Set automation in presentation mode 
  if(presentationMode) {
    rotateY(frameCount*0.001);
    if(frameCount % 120 == 0) {
      selectedDewey += 10;
      if(selectedDewey == 1000) selectedDewey = -100;
    }
  }

  //The volumetric shapes go through all layers are composed by four side meshes.   
  //The following codes draw four sides of meshes separately.
  
  //Draw Top Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numRows; j++) {
   for (int i=0; i<pointsOne.size()-1; i++) {
     float x1_1 = pointsOne.get(i).get(j).x;
     float y1_1 = pointsOne.get(i).get(j).y + 0.1;
     float z1_1 = pointsOne.get(i).get(j).z;

     float x2_1 = pointsTwo.get(i).get(j).x;
     float y2_1 = pointsTwo.get(i).get(j).y + 0.1;
     float z2_1 = pointsTwo.get(i).get(j).z;

     float x1_2 = pointsOne.get(i+1).get(j).x;
     float y1_2 = pointsOne.get(i+1).get(j).y + 0.1;
     float z1_2 = pointsOne.get(i+1).get(j).z;

     float x2_2 = pointsTwo.get(i+1).get(j).x;
     float y2_2 = pointsTwo.get(i+1).get(j).y + 0.1;
     float z2_2 = pointsTwo.get(i+1).get(j).z;

     float lineColor = Float.parseFloat(deweyData[i].deweys.keySet().toArray()[j].toString());

     beginShape();  
     noStroke();
     
     //The next a few lines of code controls color of shapes going through layers
     //Colors for the tree map layers are in DeweyItem class
     if (lineColor == selectedDewey) {
       fill(map(lineColor, 0, 990, 0, 255), 255/2, 255, TRANS);
     } else {
       if (selectedDewey >= 0) noFill();
       else fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
     } 
     vertex(x1_1, y1_1, z1_1);
     vertex(x2_1, y2_1, z2_1);
     vertex(x2_2, y2_2, z2_2);
     vertex(x1_2, y1_2, z1_2);
     endShape();
   }
  }
  popMatrix();

  //Draw Bottom Meshes 
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numRows; j++) {
   for (int i=0; i<pointsThree.size()-1; i++) {
     float x1_1 = pointsThree.get(i).get(j).x;
     float y1_1 = pointsThree.get(i).get(j).y - 0.1;
     float z1_1 = pointsThree.get(i).get(j).z;

     float x2_1 = pointsFour.get(i).get(j).x;
     float y2_1 = pointsFour.get(i).get(j).y - 0.1;
     float z2_1 = pointsFour.get(i).get(j).z;

     float x1_2 = pointsThree.get(i+1).get(j).x;
     float y1_2 = pointsThree.get(i+1).get(j).y - 0.1;
     float z1_2 = pointsThree.get(i+1).get(j).z;

     float x2_2 = pointsFour.get(i+1).get(j).x;
     float y2_2 = pointsFour.get(i+1).get(j).y - 0.1;
     float z2_2 = pointsFour.get(i+1).get(j).z;

     float lineColor = Float.parseFloat(deweyData[i].deweys.keySet().toArray()[j].toString());     

     beginShape();
     noStroke();
     
     //The next a few lines of code controls color of shapes going through layers
     //Colors for the tree map layers are in DeweyItem class
     if (lineColor == selectedDewey) {
       fill(map(lineColor, 0, 990, 0, 255), 255/2, 255, TRANS);
     } else {
       if (selectedDewey >= 0) noFill();
       else fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
     } 
     vertex(x1_1, y1_1, z1_1);
     vertex(x2_1, y2_1, z2_1);
     vertex(x2_2, y2_2, z2_2);
     vertex(x1_2, y1_2, z1_2);
     endShape();
   }
  }
  popMatrix();

  //Draw Left Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numRows; j++) {
   for (int i=0; i<pointsOne.size()-1; i++) {
     float x1_1 = pointsOne.get(i).get(j).x + 0.1;
     float y1_1 = pointsOne.get(i).get(j).y;
     float z1_1 = pointsOne.get(i).get(j).z;

     float x2_1 = pointsFour.get(i).get(j).x + 0.1;
     float y2_1 = pointsFour.get(i).get(j).y;
     float z2_1 = pointsFour.get(i).get(j).z;

     float x1_2 = pointsOne.get(i+1).get(j).x + 0.1;
     float y1_2 = pointsOne.get(i+1).get(j).y;
     float z1_2 = pointsOne.get(i+1).get(j).z;

     float x2_2 = pointsFour.get(i+1).get(j).x + 0.1;
     float y2_2 = pointsFour.get(i+1).get(j).y;
     float z2_2 = pointsFour.get(i+1).get(j).z;

     float lineColor = Float.parseFloat(deweyData[i].deweys.keySet().toArray()[j].toString());     

     beginShape();
     noStroke();
     
     //The next a few lines of code controls color of shapes going through layers
     //Colors for the tree map layers are in DeweyItem class
     if (lineColor == selectedDewey) {
       fill(map(lineColor, 0, 990, 0, 255), 255/2, 255, TRANS);
     } else {
       if (selectedDewey >= 0) noFill();
       else fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
     } 
     vertex(x1_1, y1_1, z1_1);
     vertex(x2_1, y2_1, z2_1);
     vertex(x2_2, y2_2, z2_2);
     vertex(x1_2, y1_2, z1_2);
     endShape();
   }
  }
  popMatrix();

  //Draw Right Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numRows; j++) {
   for (int i=0; i<pointsTwo.size()-1; i++) {
     float x1_1 = pointsTwo.get(i).get(j).x - 0.1;
     float y1_1 = pointsTwo.get(i).get(j).y;
     float z1_1 = pointsTwo.get(i).get(j).z;

     float x2_1 = pointsThree.get(i).get(j).x - 0.1;
     float y2_1 = pointsThree.get(i).get(j).y;
     float z2_1 = pointsThree.get(i).get(j).z;

     float x1_2 = pointsTwo.get(i+1).get(j).x - 0.1;
     float y1_2 = pointsTwo.get(i+1).get(j).y;
     float z1_2 = pointsTwo.get(i+1).get(j).z;

     float x2_2 = pointsThree.get(i+1).get(j).x - 0.1;
     float y2_2 = pointsThree.get(i+1).get(j).y;
     float z2_2 = pointsThree.get(i+1).get(j).z;

     float lineColor = Float.parseFloat(deweyData[i].deweys.keySet().toArray()[j].toString());     
     lineColor = map(lineColor, 0, 990, 0, 255);

     beginShape();
     noStroke();
     
     //The next a few lines of code controls color of shapes going through layers
     //Colors for the tree map layers are in DeweyItem class
     if (lineColor == selectedDewey) {
       fill(map(lineColor, 0, 990, 0, 255), 255/2, 255, TRANS);
     } else {
       if (selectedDewey >= 0) noFill();
       else fill(map(lineColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
     } 
     vertex(x1_1, y1_1, z1_1);
     vertex(x2_1, y2_1, z2_1);
     vertex(x2_2, y2_2, z2_2);
     vertex(x1_2, y1_2, z1_2);
     endShape();
   }
  }
  popMatrix();

  //Draw the 12 tree map layers  
  for (int i=0; i<dataMatrix.length; i++) {
    pushMatrix();
    translate(-width/2, -height/2, LAYER_DIST*(i - dataMatrix.length/2));
    map[i].draw();
    popMatrix();
  }

  //Draw Title
  cam.beginHUD();  //Stopping peasy cam
  fill(150);
  rect(0, 0, width, 35);
  fill(255);
  textAlign(RIGHT);
  if(selectedDewey >= 0 && selectedDewey <= 990){
    String deweyName = deweyNames.get(selectedDewey/10);
    deweyName = deweyName.toUpperCase();
    text(selectedDewey + " " + deweyName, width-10, 20);
  }
  cp5.draw();
  cam.endHUD();
}

//Function for showing each dewey manually by pressing SPACE
void keyPressed(){
  if(key == ' '){
    if(selectedDewey < 0) selectedDewey = 0;
    else selectedDewey += 10;
    
    if(selectedDewey == 1000) selectedDewey = -100;
  }
}

public void dewey(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
  selectedDewey = int(theText);
}

void checkBox(float[] a) {
  if(a[0] == 1) presentationMode = true;
  else presentationMode = false;
}