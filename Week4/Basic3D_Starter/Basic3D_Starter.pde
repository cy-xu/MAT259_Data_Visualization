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

Table table;
int rows;

ArrayList<Book> books = new ArrayList<Book>();

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 200);

  table = loadTable("Elements2.csv", "header");
  rows = table.getRowCount();

  println("rows: " + rows);

  for (int i = 0; i < rows; i++) {
    String element = table.getString(i, 0);
    String time = table.getString(i, 1);
    String date = table.getString(i, 2);
    int count = table.getInt(i, 3);
    String title = table.getString(i, 4);
    books.add(new Book(element, time, date, count, title));
  }
}

void draw() {
  background(0);

  for (int i=0; i < books.size(); i++) {
    float yearAxis = map(dateParser(books.get(i).date), 0, 3650, -50, 50);
    float timeAxis = map(timeParser(books.get(i).time), 600, 1200, -50, 50);
    float checkoutAxis = map(log(books.get(i).count), 0, log(13000), -50, 50);
    color c = elementDetermine(books.get(i).element);

    pushMatrix();
    translate(yearAxis, timeAxis, checkoutAxis);
    //sphere()
    //stroke(c);
    strokeWeight(4);
    box(10);
    point(0, 0, 0);
    popMatrix();
  }

  fill(255, 30);
  noStroke();
  //box(100);
}