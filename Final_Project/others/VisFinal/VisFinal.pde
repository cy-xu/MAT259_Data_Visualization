/* Version processing 3.0
Library used: peasycam, ontrolP5, toxiclibs
This visualization shows the volcano, tsunami and earthquake events happens over the history
the data is collected from NOAA website.
Interaction method: The top slider select the begin year of the events,
The bottom slide select how many events are displayed on the screen.
Use mouse to rotate the sphere.
Press key 1, 2, 3 to toggle the display of Tsunami, volcano, earthquake events, respectively.
Hover the mouse over the center of the events to display the information related to that event.

Qiaodong Cui. qiaodong@umail.ucsb.edu
*/

import peasy.*;
import controlP5.*;
import processing.opengl.*;
import toxi.processing.*;
import toxi.geom.*;

PeasyCam cam;
ControlP5 cp5;

PShape earthGlobe;
PImage earthImage;
Table earthquakeTab;
Table volcanoTab;
Table tsunamiTab;

float sphereRad = 40.0;

float maxNumTsu = 0;
float maxNumVol = 0;
float maxNumEqu = 0;

// List of all data
ArrayList<earthquakeEvent> eqEvents;
ArrayList<volcanoEvent> volEvents;
ArrayList<tsunamiEvent> tsuEvents;

// year List for binary search
IntList equYear;
IntList volYear;
IntList tsuYear;

// List for display.
ArrayList<earthquakeEvent> equDisp;
ArrayList<volcanoEvent> volDisp;
ArrayList<tsunamiEvent> tsuDisp;

PImage sprite;
PShader pointShader;
PShader lineShader;

color Tsuc = color(0, 255,255);
color Volc = color(255,0,0);
color Equc = color(255,255,0);

boolean mouseOverSider = false;

float StartYear = 0;
float TotalYears = 0.5;
int mappedYear = 0;

float magMinVol = 1e8;
float magMaxVol = -1e8;
float magMinEqu = 1e8;
float magMaxEqu = -1e8;
float magMinTsu = 1e8;
float magMaxTsu = -1e8;

boolean dispVol = true;
boolean dispEqu = true;
boolean dispTsu = true;
float dt = 1.0;

Psystem volPSystem;
ArrayList<Psystem> volPsys;

void setup() {
  size(900, 720, P3D);
  earthImage = loadImage("map_global.png");
  cam = new PeasyCam(this, 100);
  textMode(MODEL);
  // cam.lookAt(0, 10, 0);
  float  cameraZ = (height/2.0) / tan(PI*60.0/360.0);
  perspective(PI/3.0, float(width)/float(height), 0.001, cameraZ*10.0); //set near clip to 0.001 to go inside data
  
  pointShader= loadShader("frag.glsl", "vert.glsl");
  pointShader.set("weight", 30.0);
  pointShader.set("sprite", loadImage("sprite.png"));
  
  lineShader = loadShader("linefrag.glsl", "linevert.glsl");
  
  sprite = loadImage("sprite.png");
  
  noStroke();
  earthGlobe = createShape(SPHERE, sphereRad);
  earthGlobe.setTexture(earthImage);
  earthquakeTab = loadTable("EarthQuake.csv");
  volcanoTab = loadTable("volerup.csv");
  tsunamiTab = loadTable("tsevent.csv");
  
  eqEvents = new ArrayList<earthquakeEvent>();
  volEvents = new ArrayList<volcanoEvent>();
  tsuEvents = new ArrayList<tsunamiEvent>();
  
  equDisp = new ArrayList<earthquakeEvent>();
  volDisp = new ArrayList<volcanoEvent>();
  tsuDisp = new ArrayList<tsunamiEvent>();
  volPsys = new ArrayList<Psystem> ();
  volYear = new IntList();
  equYear = new IntList();
  tsuYear = new IntList();
  parseVolcanoData();
  parseEarthquakeData();
  parseTsunamiData();
  
  maxNumTsu = (float)tsuEvents.size()*0.05;
  maxNumEqu = (float)eqEvents.size()*0.05;
  maxNumVol = (float)volEvents.size()*0.05;

  // Slider
  cp5 = new ControlP5(this);
  cp5.addSlider("StartYear")
     .setPosition(width * 0.5 - 200,height - 70)
     .setSize(400,20)
     .setRange(0,1)
     .setValue(0)
     ;
  cp5.addSlider("TotalYears")
     .setPosition(width * 0.5 - 100,height - 35)
     .setSize(200,10)
     .setRange(0,1)
     .setValue(0.5)
     .setHandleSize(5)
     ;
  cp5.setAutoDraw(false);
  mappedYear = mapFloatToYear(StartYear);
  setDisplayArray(mappedYear, TotalYears);
  //println("magMinVol: " + magMinVol + " magMaxVol: " + magMaxVol + " magMinEqu: " + magMinEqu + " magMaxEqu: " + magMaxEqu + 
  //        " magMinTsu: " + magMinTsu + " magMaxTsu: " + magMaxTsu);
  
  //PVector pvector = new PVector();
  //pvector = sphereToXYZ(40,40, sphereRad);
  //PVector grav = new PVector();
  //grav.x = -pvector.x;
  //grav.y = -pvector.y;
  //grav.z = -pvector.z;
  //volPSystem = new Psystem(200, pvector.x, pvector.y, pvector.z, color(255,0,0), grav, 1);
}

void drawEarthQuake() {  
  hint(DISABLE_DEPTH_MASK);
  shader(lineShader, LINES);
  for (int i = 0; i < equDisp.size(); i++) {
    float lat = equDisp.get(i).latitude;
    float lon = equDisp.get(i).longitude;
    PVector pos = sphereToXYZ(lat, lon, sphereRad*1.005);
    float mouseObjectDistance = sq(mouseX-screenX(pos.x, pos.y, pos.z))+sq(mouseY-screenY(pos.x, pos.y, pos.z)); 
    if (mouseObjectDistance < 8) {
      hint(DISABLE_DEPTH_TEST);
      cam.beginHUD();
      fill(255,255,255);
      textMode(SHAPE);
      textSize(15);
      String info = equDisp.get(i).getStrInfo();
      text(info, mouseX + 10, mouseY);
      cam.endHUD();
      hint(ENABLE_DEPTH_TEST);
    }
    float dispScale = getZeroOneRange(equDisp.get(i).magnitude, magMinEqu, magMaxEqu);
    dispScale = 0.5 + dispScale * 4.0;
    // strokeWeight(dispScale);
    color c = Equc;
    drawEnlargeCirc(pos, pos, c, dispScale, equDisp.get(i).rndPhase);
  }
  hint(ENABLE_DEPTH_MASK);
}

void drawTsu() {
  hint(DISABLE_DEPTH_MASK);
  shader(lineShader, LINES);
  for (int i = 0; i < tsuDisp.size(); i++) {
    float lat = tsuDisp.get(i).latitude;
    float lon = tsuDisp.get(i).longitude;
    PVector pos = sphereToXYZ(lat, lon, sphereRad*1.005);
    
    float mouseObjectDistance = sq(mouseX-screenX(pos.x, pos.y, pos.z))+sq(mouseY-screenY(pos.x, pos.y, pos.z)); 
    if (mouseObjectDistance < 8) {
      hint(DISABLE_DEPTH_TEST);
      cam.beginHUD();
      fill(255,255,255);
      textMode(SHAPE);
      textSize(15);
      String info = tsuDisp.get(i).getStrInfo();
      text(info, mouseX + 10, mouseY);
      cam.endHUD();
      hint(ENABLE_DEPTH_TEST);
    }
    float dispScale = getZeroOneRange(tsuDisp.get(i).magnitude, magMinTsu, magMaxTsu);
    dispScale = 0.5 + dispScale * 4.0;
    // strokeWeight(dispScale);
    color c = Tsuc;
    // drawParticleNew(pos, c);
     drawEnlargeCirc(pos, pos, c, dispScale, tsuDisp.get(i).rndPhase);
  }
  hint(ENABLE_DEPTH_MASK);
}
void drawVol() {
  strokeWeight(0.5);
  for (int i = 0; i < volDisp.size(); i++) {
    float lat = volDisp.get(i).latitude;
    float lon = volDisp.get(i).longitude;
    PVector pos = sphereToXYZ(lat, lon, sphereRad*1.005);
    
    float mouseObjectDistance = sq(mouseX-screenX(pos.x, pos.y, pos.z))+sq(mouseY-screenY(pos.x, pos.y, pos.z)); 
    if (mouseObjectDistance < 8) {
      hint(DISABLE_DEPTH_TEST);
      cam.beginHUD();
      fill(255,255,255);
      textMode(SHAPE);
      textSize(15);
      String info = volDisp.get(i).getStrInfo();
      text(info, mouseX + 10, mouseY);
      cam.endHUD();
      hint(ENABLE_DEPTH_TEST);
    }
    //float dispScale = getZeroOneRange(volDisp.get(i).magnitude, magMinVol, magMaxVol);
    //dispScale = 0.1 + dispScale * 1.0;
    //strokeWeight(dispScale);
    //color c = Volc;
    //drawParticleNew(pos, c);
    volPsys.get(i).drawAllParticles();
    volPsys.get(i).evolveParticles();
  }
}

void drawPtonSphere() {
  float lat = -70.179936; 
  float lon = 45.683657;
  PVector pos = sphereToXYZ(lat, lon, sphereRad);
  pushMatrix();
  fill(255, 0, 0);
  translate(pos.x, pos.y, pos.z);
  sphere(0.5);
  popMatrix();
}

void drawLabel() {
  float delta = 40;
  float ystart = 30;
  if (dispTsu) {
    stroke(Tsuc);
    strokeWeight(20);
    point(25, ystart);
    fill(255);
    textSize(20);
    textAlign(LEFT, TOP);
    text("Tsunami events: " + tsuDisp.size(), 36, ystart - 12, 0);
  }
  
  if (dispVol) {
    stroke(Volc);
    strokeWeight(25);
    point(25, ystart + delta);
    fill(255);
    text("Volcano events: " + volDisp.size(), 38, ystart - 12 + delta, 0);
  }
  
  if (dispEqu) {
    stroke(Equc);
    strokeWeight(20);
    point(25, ystart + 2*delta);
    fill(255);
    text("Earthquake events: " + equDisp.size(), 38, ystart - 12 + 2*delta, 0);
  }
  text("Start Year: " + mappedYear, 25, ystart - 12 + 3*delta, 0);
  textSize(25);
  text("Global Natural Hazards", width*0.35, 10);
}


void draw() {
  cam.setActive(!mouseOverSider);

  pushMatrix();
  background(51);
  
  noFill();
  noStroke();
  shape(earthGlobe);
  
  shader(pointShader, POINTS);
  
  if (dispEqu) {
    drawEarthQuake();
  }
  if (dispVol) {
    drawVol();
  }
  if (dispTsu) {
    drawTsu();
  }

  popMatrix();

  // 2D section
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD(); // peasy cam stops working here
  drawLabel();
  cp5.draw();
  mouseOverSider = cp5.isMouseOver() && mousePressed;
  if (mouseOverSider) {
    mappedYear = mapFloatToYear(StartYear);
    setDisplayArray(mappedYear, TotalYears);
  }
  cam.endHUD(); // start peasy cam again
  hint(ENABLE_DEPTH_TEST);
}