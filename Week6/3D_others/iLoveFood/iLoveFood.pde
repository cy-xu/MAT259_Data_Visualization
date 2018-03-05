/*************************************************************************************
 Data Visualization - Assignment 3                                            
 
 Author: Chantel Chan
 Purpose: Show popularity on different     
 
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
float maxCount, maxAVG, maxSTD;
float radius, x, y, z;
ArrayList<Book> books = new ArrayList<Book>();
float[][] books_points ;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 250);
  table = loadTable("Meals3.csv", "header");
  rowNums = table.getRowCount();
  println("Rows: " + rowNums);
  maxCount = 0;
  maxAVG = 0;
  maxSTD = 0;

  for (int i = 0; i<rowNums; i++) {
    String title = table.getString(i, 0);       //title
    float deweyClass = table.getFloat(i, 1);    //color
    float count = table.getFloat(i, 2);             //size of point
    float avg = table.getFloat(i, 3);           //jitter
    float std = table.getFloat(i, 4)/3;           //speed
    float r = 100;                              //radius
    float x = random(-(r-10), r-10); 
    float y = random(-sqrt((sq(r)-sq(x))), sqrt((sq(r)-sq(x)))); 
    float z = random(-sqrt((sq(r)-sq(x)-sq(y))), sqrt((sq(r)-sq(x)-sq(y))));     //position generated randomly
    float dirX = (random(-1, 1) < 0) ? avg : -avg;
    float dirY = (random(-1, 1) < 0) ? avg : -avg;
    float dirZ = (random(-1, 1) < 0) ? avg : -avg;
    books.add(new Book(title, deweyClass, count, std, avg, x, y, z, dirX, dirY, dirZ));

    maxCount = max(maxCount, table.getFloat(i, 2));
    maxAVG = max(maxAVG, table.getFloat(i, 3));
    maxSTD = max(maxSTD, table.getFloat(i, 4));
  }
}

void draw() {
  background(#474D56);
  colorMode(HSB, 100);
  for (int i = 0; i<books.size()-1; i++) {
    if (books.get(i).title != null) {
      float pointSize = map((books.get(i).count), 0, maxCount, 5, 50); 
      color c = elementDetermine(books.get(i).deweyClass);
      String cat = category(c);
      strokeWeight(pointSize);
      stroke(c);
      pushMatrix();
      translate((books.get(i).x), (books.get(i).y), (books.get(i).z));
      point(0, 0, 0);
      float mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0)); 
      if (mouseObjectDistance < 75) {
        strokeWeight(pointSize*2.5);

        stroke(c, 255);
        point(0, 0, 0);
        stroke(#FFFFFF);
        fill(#FFFFFF);
        textMode(SHAPE);
        textSize(5);
        text(cat, 0, 0);
        
        textSize(3);
        text("Count: " + str(books.get(i).count), 0, 10);
        text(books.get(i).title.toUpperCase(), 0, 15);
        

        strokeWeight(pointSize);
        stroke(c, 255);
        point(0, 0, 0);
        stroke(0, 0, 0, 0);

      }
      popMatrix();
      books.get(i).move();
      books.get(i).bounce();
    }
  }

  for (int i=0; i<(books.size()); i++) {
    for (int j=i+1; j<(books.size()); j++) {
      if ((elementDetermine(books.get(i).deweyClass) == elementDetermine(books.get(j).deweyClass)) &&
        (books.get(i).title != null && books.get(j).title != null)) {
        books.get(i).eat(books.get(j));
      }
    }
  }
}