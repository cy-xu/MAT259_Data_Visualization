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
int rowNums;
int boxSize = 100;
ArrayList<Book> books = new ArrayList<Book>();
float[][] books_points ;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 250);
  table = loadTable("Elements2.csv", "header");
  rowNums = table.getRowCount();
  println("Rows: " + rowNums);

  for (int i = 0; i<rowNums; i++) {
    String element = table.getString(i, 0); //color
    String time = table.getString(i, 1); //x
    String date = table.getString(i, 2); //y
    int count = table.getInt(i, 3); //z
    String title = table.getString(i, 4);
    books.add(new Book(element, time, date, count, title));
  }
  println(books.get(0).element); //gets the element from the first 
   println(books.get(23).time); //gets the time from the 24th 
}

void draw() {
  background(100);
  stroke(220,225, 226);
  fill(20, 20); //255 opaque, 0 transparent
  books_points = new float[books.size()][2];
  for (int i = 0; i<books.size(); i++) {
    float dateAxis = map(dateParser(books.get(i).date), 0,3650,-boxSize/2,boxSize/2); 
    float timeAxis = map(timeParser(books.get(i).time), 600,1200,-boxSize/2,boxSize/2);
    float countAxis = map(log(books.get(i).count), log(1),log(13000),-boxSize/2,boxSize/2);
    color c = elementDetermine(books.get(i).element);
    strokeWeight(5);
    stroke(c,100);
    pushMatrix();
    translate(dateAxis,timeAxis,countAxis);
    point(0,0,0);
    float mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0)); 
    if (mouseObjectDistance < 20)
    {
      stroke(c,255);
      point(0,0,0);
      stroke(0,0,0,0);
      fill(255,255,255);
      textMode(SHAPE);
      textSize(3);
      text(books.get(i).title.toUpperCase(),0,0);
    }
    popMatrix();
  }
  stroke(220,10);
  fill(200,20);
  box(boxSize);
}