/********************************************************
 * Data Visualization - 2D Matrix Demo                  *
 * Tested in Processing 3                               *     
 *                                                      *
 * Author: Rodger (Jieliang) Luo                        *
 * Supervisor: George Legrady                           *
 *                                                      *
 * Purpose: Demonstrate how to make a simple 2D Matrix  *
 *          data visualization with different color     *
 *          schemes.                                    *
 *                                                      *
 * Usage:                                               *
 *          Press '1', '2', '3', '4' to apply different *
 *          color schemes.                              *
 *          Press '0' to use gray scale.                *
 ********************************************************/

/*
Step One: Upload CSV to Table & Get basic information of data. 
 Step Two: Write data from Table to 2D Array & Have max and min value of data.
 Step Three: Visualize 2D Matrix.
 Step Four: Draw labels and title.
 */

final float flMarginToLeft = 50;
final float flMarginToTop = 40;

Table tbDVD;
int rows, cols;
float[][] flMatrix;
float flMax, flMin = 0;

float flCellWidth;
float flCellHeight;

color clCheckOutColor;

  //Only run one time
void setup() {
  size(1280, 500); // setup the size of the window
  background(30, 30, 30, 10);
  // In Processing 3, the size() function must be the first line of code inside setup()
  // and needs to use numbers instead of variables. 

  tbDVD = loadTable("TopDVDs_month.csv", "header");
  rows = tbDVD.getRowCount();
  cols = tbDVD.getColumnCount();

  println("Rows: " + rows);
  println("Columns: " + cols);

  flMatrix = new float[rows][cols-2];

  for (int i=0; i<flMatrix.length; i++) {
    for (int j=0; j<flMatrix[0].length; j++) {
      flMatrix[i][j] = log(tbDVD.getFloat(i, j+2)) + 1;
    }
  }

  // get max and min value from the array
  for (int i=0; i<flMatrix.length; i++) {
    for (int j=0; j<flMatrix[0].length; j++) {
      if (flMatrix[i][j] > flMax) {
        flMax = flMatrix[i][j];
      }
    }
  }

  println("Max: " + flMax);
  println("Min: " + flMin);
  
  flCellWidth = (width - flMarginToLeft * 2) / cols;
  flCellHeight = (height - flMarginToTop * 2) / rows;
}

//Refresh the canvas every frame
void draw() {  
  // println(hour() + ":" + minute() + ":" + second());

  // draw 2D matrix
  for (int i=0; i<flMatrix.length; i++) {
    for (int j=0; j<flMatrix[0].length; j++) {
      
      clCheckOutColor = floor(map(flMatrix[i][j], flMin, flMax, 0, 255));
      stroke(60,60,60);
      fill(clCheckOutColor, i % 255, j % 255);
      rect(flMarginToLeft + j*flCellWidth, flMarginToTop + i*flCellHeight, flCellWidth, flCellHeight);
      
    }
  }
}