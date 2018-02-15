/*************************************************************************************
Data Visualization - Basic 3D Demo                
Tested in Processing 3                                    
                                                     
Author: Rodger (Jieliang) Luo                        
Supervisor: George Legrady                           

Purpose: Show how to present volume data in a basic 3D environment     

Usage: 1. A mouse left-drag will rotate the camera around the subject.
          2. A right drag will zoom in and out. 
          3. A middle-drag (command-left-drag on mac) will pan. 
          4. A double-click restores the camera to its original position. 
          5. The shift key constrains rotation and panning to one axis or the other.
*************************************************************************************/

import peasy.*;
PeasyCam cam;

int startYear = 2006;
int endYear = 2014;

Table table;
int numRows, numColumns;

ArrayList<Book> books = new ArrayList<Book>();

void setup(){
  size(1300, 1300, P3D);
  cam = new PeasyCam(this, 200);
  
  //Added on Jan 30th by Rodger Luo
  float  cameraZ = (height/2.0) / tan(PI*60.0/360.0);
  perspective(PI/3.0, width/height, 0.001, cameraZ*10.0); //set near clip to 0.001 to go inside data
  //Finished adding 
  
  table = loadTable("Elements2.csv", "header");
  numRows = table.getRowCount();
  println("Rows: " + numRows);
  
  for(int i=0; i<numRows; i++){
    String element= table.getString(i,0);
    String time = table.getString(i,1);
    String date = table.getString(i,2);
    int count = table.getInt(i,3);
    String title = table.getString(i,4);
    books.add(new Book(element, time, date, count, title));
  }
}

void draw(){
  background(100);
  
  for(int i=0; i<books.size(); i++){
    float yearAxis = map(dateParser(books.get(i).date), 0, 3650, -50, 50);
    float timeAxis = map(timeParser(books.get(i).time), 600, 1200, -50, 50);
    float deweyAxis = map(log(books.get(i).count), 0, log(13000), -50, 50);
    color c = elementDetermine(books.get(i).element);
    pushMatrix();
    translate(yearAxis, timeAxis, deweyAxis);
    strokeWeight(2);
    stroke(c);
    point(0,0,0);
    popMatrix();
  }
  
  drawLabels();  
    
  fill(200, 20);
  noStroke();
  box(100);
}

void drawLabels(){
  fill(255);
  textSize(30);
  pushMatrix();
  textAlign(LEFT, TOP);
  translate(-50, 50, 50);
  scale(0.1);
  text("2006", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textAlign(RIGHT, TOP);
  translate(50, 50, 50);
  scale(0.1);
  text("2015", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textAlign(RIGHT, TOP);
  translate(-50, -50, 50);
  scale(0.1);
  text("10AM", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textAlign(RIGHT, BOTTOM);
  translate(-50, 50, 50);
  scale(0.1);
  text("8PM", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textAlign(LEFT, CENTER);
  translate(50, 50, 50);
  scale(0.1);
  text("Count 13000", 0, 0, 0);
  popMatrix();
  
  pushMatrix();
  textAlign(LEFT, CENTER);
  translate(50, 50, -50);
  scale(0.1);
  text("Count 0", 0, 0, 0);
  popMatrix();
}