import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Matrix2D_HW3 extends PApplet {

PGraphics timeCover;
Table table;
int rows, cols;
float[][] flMatrix;
float flMax, flMin = 0;
float borders[];
float base;
int[] colors;

public void setup() {
  
  //size(1280, 500);
  background(30, 30, 30, 10);
  // frameRate(4);

  base = 0.7f * height;
  
  colors = new int[3];
  colors[0] = 0xff565B77;
  colors[1] = 0xff6FDEFD;
  colors[2] = 0xff43AD8A;

  borders = new float[4];
  borders[0] = 0.04f * width;
  borders[1] = 0.04f * height;
  borders[2] = 0.96f * width;
  borders[3] = 0.96f * height;

  timeCover = createGraphics(40, 40);

  table = loadTable("trump_2015_2017.csv", "header");
  rows = table.getRowCount();
  cols = table.getColumnCount();

  println("Rows: " + rows);
  println("Columns: " + cols);

  flMatrix = new float[rows][cols-2];

  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < flMatrix[0].length; j++) {
      //flMatrix[i][j] = log(table.getFloat(i, j+2)) + 1;
      flMatrix[i][j] = table.getFloat(i, j+2) + 1;
      println(flMatrix[i][j]);
    }
  }

  
}

//Refresh the canvas every frame
public void draw() {
  background(255*7/8, 100);

  fill(255);
  rectMode(CORNERS);
  rect(width*0.04f, height*0.04f, width*0.96f, height*0.96f);

  // Time Cover
  timeCover.beginDraw();
  timeCover.background(100);
  timeCover.stroke(255);
  timeCover.line(20, 20, mouseX, mouseY);
  timeCover.endDraw();
  image(timeCover, 9, 30); 
  image(timeCover, 51, 30);

  //draw Google Trend
  drawGoogleCurve();

}
public void drawGoogleCurve() {
  // draw a curve with data from Google Trend
  fill(250 + random(-5, 5));
  //noFill();
  strokeWeight(2);
  stroke(200);
  beginShape();
  curveVertex(0 * curveWidth + width*0.04f, base);
  curveVertex(0 * curveWidth + width*0.04f, base);
  for (int i = 0; i < flMatrix[1].length; i++) {
    curveVertex(i * curveWidth + width*0.04f, base - (flMatrix[1][i]));
  }
  curveVertex((flMatrix[1].length - 1) * curveWidth + width*0.04f, base);
  curveVertex((flMatrix[1].length - 1) * curveWidth + width*0.04f, base);
  endShape();
    
}
  public void settings() {  fullScreen();  smooth(4); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Matrix2D_HW3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
