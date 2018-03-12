import java.util.Map;
import java.util.*;

int radius = 300; 
float top, bottom;
Route testRoute;
int winWidth, winHeight, topMargin;

import peasy.*;
PeasyCam cam;

void setup() {
  size(1200, 800, P3D); // setup the size of the window
  background(255);
  winWidth = width;
  winHeight = height;
  top = 0.1 * winHeight;
  bottom = 0.9 * winHeight;

  loadCSV();
  loadAllTrade();

  //Create An ArrayList of boids for each two trade countries

  testRoute = new Route();
  whichState();
  drawState();
}

void draw() {
  background(200);
  //translate(winWidth / 2.0, top + winHeight / 2.0);

  //fill(#f8f8f8, 100);
  //stroke(200, 100);
  //rectMode(CORNERS);
  //rect(width*0.04, height*0.04, width*0.96, height*0.96);

  for (State s : stateMap.values()) {
    pushMatrix();
    translate(s.position.x, s.position.y, 1);
    rotate(s.rotation);
    image(s.flag, -20, -20);
    popMatrix();
  }



  testRoute.run();
}

//void keyPressed() {
//  if (key == CODED) {
//    if (keyCode == RIGHT) {
//      testRoute.addBoid(new Boid(new PVector(width/2, height), new PVector(width/2, 0)));
//    }
//    if (keyCode == LEFT) {
//      testRoute.addBoid(new Boid(new PVector(width/2, height), new PVector(mouseX, mouseY)));
//    }
//  }
//}