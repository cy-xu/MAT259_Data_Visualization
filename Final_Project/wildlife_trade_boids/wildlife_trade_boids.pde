import java.util.Map;
import java.util.*;

int stateNum = 10; 
float colWidth;
Route testRoute;

void setup() {
  size(1280, 500, P3D); // setup the size of the window
  background(255);
  colWidth = width / stateNum; 

  loadCSV();
  loadAllTrade();

  //Create An ArrayList of boids for each two trade countries

  testRoute = new Route();
  whichState();
  drawState();
}

void draw() {
  background(200);

  fill(#f8f8f8, 100);
  stroke(200, 100);
  rectMode(CORNERS);
  rect(width*0.04, height*0.04, width*0.96, height*0.96);

translate(0, height/2);

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