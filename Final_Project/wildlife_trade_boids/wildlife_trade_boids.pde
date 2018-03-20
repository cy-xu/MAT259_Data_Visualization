/*************************************************************************************
 Data Visualization - Top Wildlife Buyers and Seller                
 Tested in Processing 3                                    
 
 Author: Chengyuan Xu                        
 Supervisor: Jieliang Luo                           
 
 Purpose: Visualize world's top wildlife importer and export and their trade in 2016.
 Reference: Daniel Shiffman - https://github.com/shiffman/The-Nature-of-Code-Examples
 
 Usage: Controls on top-left corner
 *************************************************************************************/

//import java.util.Map;
//import java.util.*;
import controlP5.*;
import peasy.*;
import processing.opengl.*;

PeasyCam cam;
ControlP5 cp5;

int radius, winWidth, winHeight, topMargin; 
float top, bottom;
float maxspeed; // max speed
Route testRoute;

PShader blur;
boolean showIntro, shuffleAllColor;

void setup() {
  fullScreen(P3D);
  //size(1200, 800, P3D); // setup the size of the window
  background(255);
  smooth(4);

  cam = new PeasyCam(this, 0);
  blur = loadShader("blur.glsl"); 

  winWidth = width;
  winHeight = height;
  top = 0.05 * winHeight;
  bottom = 0.9 * winHeight;
  radius = int(winHeight / 3.2);

  // set camera
  cam.setActive(false);
  cam.lookAt(winWidth / 2.0, winHeight / 2.0, 700);

  // load and process all data
  loadCSV();
  loadAllTrade();

  testRoute = new Route(); // create the Route to control boids
  whichState(); // give values to 14 states
  drawState(); // draw all the boids

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  addControls();
}

void draw() {
  background(200);
  translate(winWidth/2.0, winHeight/2.0 - top);

  // draw squares
  for (State s : stateMap.values()) {
    pushMatrix();
    translate(s.position.x, s.position.y, 1);
    noStroke();
    fill(s.c);
    rect(0, 0, 75, 50, 7);
    popMatrix();
  }
  filter(blur);

  // draw country flags
  for (State s : stateMap.values()) {
    pushMatrix();
    translate(s.position.x, s.position.y, 1);
    //rotate(s.rotation);
    image(s.flag, -25, -25);
    popMatrix();
  }

  // render the boids every frame
  testRoute.run();

  //if (shuffleAllColor == false) {
  //  shuffleColor();
  //  shuffleAllColor = true;
  //}

  // draw text
  if (showIntro == true) {
    draw2DText();
  }

  gui();
}

void toggle(boolean theFlag) {
  if (theFlag==true) {
    showIntro = true;
  } else {
    showIntro = false;
  }
  println("Introduction turned on/off.");
}

//void keyPressed() {
//  if (key == CODED) {
//    if (keyCode == UP) {
//      maxspeed += 0.5;
//    }
//    if (keyCode == DOWN) {
//      maxspeed -= 0.5;
//    }
//    if (keyCode == LEFT) {
//      maxspeed = 3.0;
//    }
//  }
//}