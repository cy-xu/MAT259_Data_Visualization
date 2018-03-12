import java.util.Map;
import java.util.*;

int radius;; 
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
  top = 0.1 * winHeight;
  bottom = 0.9 * winHeight;
  radius = int(winHeight / 2.8);
  //radius = int(winHeight / 5);

  loadCSV();
  loadAllTrade();

  //Create An ArrayList of boids for each two trade countries

  testRoute = new Route();
  whichState();
  drawState();
}

void draw() {
  background(200);
  translate(winWidth/2.0, winHeight/2.0);

  // draw country flags
  for (State s : stateMap.values()) {
    pushMatrix();
    translate(s.position.x, s.position.y, 1);
    //rotate(s.rotation);

    // draw background square
    noStroke();
    fill(s.c);
    rect(12, 4, 20, 20);
    //filter(blur);

    image(s.flag, -25, -25);
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