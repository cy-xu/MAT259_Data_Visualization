/*************************************************************************************
Data Visualization - Top Wildlife Buyers and Seller                
Tested in Processing 3                                    
                                                     
Author: Chengyuan Xu                        
Supervisor: Jieliang Luo                           

Purpose: Visualize world's top wildlife importer and export and their trade in 2016.

Usage: UP and DOWN arrow key to change speed, LEFT key to reset to normal speed
*************************************************************************************/

import java.util.Map;
import java.util.*;

int radius;
; 
float top, bottom;
Route testRoute;
int winWidth, winHeight, topMargin;

PShader blur;


void setup() {
  //fullScreen(P3D);
  size(1200, 800, P3D); // setup the size of the window
  background(255);
  smooth(4);

  blur = loadShader("blur.glsl"); 

  winWidth = width;
  winHeight = height;
  top = 0.05 * winHeight;
  bottom = 0.9 * winHeight;
  radius = int(winHeight / 2.8);

  loadCSV();
  loadAllTrade();

  testRoute = new Route();
  whichState();
  drawState();
}

void draw() {
  background(200);
  translate(winWidth/2.0, winHeight/2.0 - top);

  // draw country flags
  for (State s : stateMap.values()) {
    pushMatrix();
    translate(s.position.x, s.position.y, 1);
    //rotate(s.rotation);

    // draw background square
    noStroke();
    fill(s.c);
    rect(23, 15, 20, 20);
    //filter(blur);

    image(s.flag, -25, -25);
    popMatrix();
  }

  testRoute.run();
  draw2DText();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      maxspeed += 0.5;
    }
    if (keyCode == DOWN) {
      maxspeed -= 0.5;
    }
    if (keyCode == LEFT) {
      maxspeed = 3.0;
    }
  }
}