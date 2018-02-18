/*************************************************************************************
3D SPL Data Visualization
                                                     
Author: Kimberly Schlesinger                        
Supervisor: George Legrady                           
*************************************************************************************/

// declare camera
import peasy.*;
import controlP5.*;
PeasyCam cam;
ControlP5 cp5;

// general bead organization
int bead_type = 1;    // dots, spiral lines, or objects
int nCs = 6;          // number of countries
int noClasses = 8;    // number of dewey classes
int deweyPerClass = 100;  // number of beads per class (same for all)
int startDewey = 200; // start dewey number (all must be sequential)
int nBeads = noClasses * deweyPerClass;  // total bead number per country
Bead[][] allBeads = new Bead[noClasses*deweyPerClass][nCs];  // init bead array
boolean unDewey = true;
Bead[][] udBeads = new Bead[10][nCs];  // init bead array
int uD;

// individual bead sizes
int startYear = 2006;  // time vars = bead angle
int noYears = 11;      // number of years per dewey class
int noMonths = 12;     // number of months per year
float rScale = 10;     // radius scale
String cName;          // initialize string for bead country name

// bead arrangement in space
float bH = 50;            // bead height
float colSpacing = 50;    // space between strings (cols)
float beadSpacing = 50;   // space between beads (rows)
int colsPerClass = 10;    // number of cols per dewey class
int rowsPerClass = ceil(deweyPerClass / colsPerClass); 

// min and max values for 
// saturation and brightness
float satMin = 35; //35
float satMax = 99; //99
float briMin = 35; //10
float briMax = 99; //99

// for labels
float lpix = 45; // size of class labels
float upix = 20; // size of unDewey labels
float dpix = 5; // size of date labels
String theTxt;
String unDeweyLabels[];
String cPrint;

// for input data storage
Table table;
Table labels;
Table undewey;
float[][] beadMatrix;  // holds bead checkout values

// interaction
boolean cSwitch[];
boolean iSwitch;
boolean lSwitch;
boolean mSwitch;
boolean dispTxt;
boolean tLabels;

void setup(){
  // size and view
  size(1300, 1300, P3D);
  colorMode(HSB, 360, 100, 100);
  translate(width/2 - colSpacing/2,height/2,0);
  
  setupCamera();

  setSwitches();
    
  createDeweyBeads();
  
  loadLabels();
}

void draw(){
  //size(1280, 720); // setup the size of the window

  // Make the screen resizable.            
  surface.setResizable(true);
  
  // set background and initial position of array
  background(0,0,20);
  cam.rotateX(0);
  dispTxt = false;
  theTxt = "";
    
  // draw beadstrings
  for (int s=0; s<colsPerClass; s++){
    float strx = s*colSpacing - (colsPerClass*colSpacing)/2;
    float strz = -1 * ((rowsPerClass*noClasses-1+uD) * (bH + beadSpacing));
    stroke(0,0,75);
    strokeWeight(1);
    line(strx, 0, beadSpacing, strx, 0, strz);    
  }
    
  // set country to define label printing
  cPrint = "";
  for (int c=0; c<nCs; c++) {
    if (cSwitch[c] == true) {
      cPrint = countryName(c);
    }
  }
  
  // draw dewey beads & non-dewey beads
  for (int c=0; c<nCs; c++) {
    if (cSwitch[c] == true) {
      for(int b=0; b<noClasses*deweyPerClass; b++) {
        allBeads[b][c].drawBead();
      }
      for(int n=0; n<10; n++) {
        udBeads[n][c].drawBead();
      }
    }
  }
  
  // draw interface
  if (iSwitch==true) iDisplay();
  
  // draw mouseover text
  if (mSwitch==true) mDisplay();
  
  // draw topic labels
  if(lSwitch==true) drawLabels();
   
}