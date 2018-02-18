// setup camera
void setupCamera() {
  cam = new PeasyCam(this, 500);
  perspective(PI/20, width/height, 1, 10000);
  cam.setWheelScale(0.1);
  cp5 = new ControlP5(this);
}

void setSwitches() {
  // set all interaction switches to defaults
  iSwitch = true;              // instructions on
  lSwitch = true;              // labels on
  mSwitch = true;              // mouseover text on
  dispTxt = false;             // no initial mouseover
  tLabels = false;             // date labels off
  cSwitch = new boolean[nCs];
  for (int c=0; c<nCs; c++) {  // all countries on
    cSwitch[c] = true;
  }
  if (unDewey == true) uD = 1;
  else uD = 0;
}

void createDeweyBeads() {
 // load in data to tables
  table = loadTable("q3_country_dewey_3D.csv", "header");
  
 // create each bead in a for loop
 for (int c=0; c<nCs; c++) {
   
  cName = countryName(c);
   
  for (int b=0; b<nBeads; b++) {
    
    // initialize all bead matrix to 0
    beadMatrix = new float[noYears][noMonths];
    for (int m=0; m<noMonths; m++) {
      for (int w=0; w<noYears; w++) {
        beadMatrix[w][m] = 0;
      }
    }
    
    // fill bead matrix
      for(TableRow row : table.matchRows("^" + str(b+startDewey) + "$","deweyBin")) {
        for (int m=0; m<noMonths; m++) {
          for (int w=0; w<noYears; w++){
            int yr = w + startYear;
            int mn = m + 1;
            if (row.getInt("year(cout)")==yr && row.getInt("month(cout)")==mn) {
              beadMatrix[w][m] = row.getFloat(cName);
            }
          }
        }
      }

    // find Bead location
    int bClass = floor(b/deweyPerClass);                        // current class
    int bRow = floor((b-bClass*deweyPerClass)/colsPerClass);    // current row IN CLASS
    int bCol = (b-bClass*deweyPerClass) % colsPerClass;         // current col
    float bX = bCol * colSpacing - (colsPerClass * colSpacing)/2;           // x pos
    float bZ = -1 * (bRow + (rowsPerClass * bClass + uD)) * (bH + beadSpacing);  // z pos
    
    // create Bead in Bead array
    allBeads[b][c] = new Bead(beadMatrix,bX,0,bZ,bH,cName,b+startDewey);
    
  } // end loop over number of beads
  
  // create unDewey beads
  if (unDewey) {
    createUnDeweyBeads(c);
  }
  
 }  // end loop over number of countries
}

void createUnDeweyBeads(int c) {
    for (int n=0;n<10;n++) {
      // initialize all bead matrix to 0
      beadMatrix = new float[noYears][noMonths];
      for (int m=0; m<noMonths; m++) {
        for (int w=0; w<noYears; w++) {
          beadMatrix[w][m] = 0;
        }
      }
      
      // load table
      switch (n) {
        case 0: undewey = loadTable("q3_country_noDewey_E.csv","header");
                break;
        case 1: undewey = loadTable("q3_country_noDewey_J.csv","header");   
                break;
        case 2: undewey = loadTable("q3_country_noDewey_YA.csv","header");   
                break;
        case 3: undewey = loadTable("q3_country_noDewey_B.csv","header");   
                break;
        case 4: undewey = loadTable("q3_country_noDewey_MYSTERY.csv","header");   
                break;
        case 5: undewey = loadTable("q3_country_noDewey_SCI-FIC.csv","header");   
                break;
        case 6: undewey = loadTable("q3_country_noDewey_FIC.csv","header");   
                break;
        case 7: undewey = loadTable("q3_country_noDewey_VHS.csv","header");   
                break;
        case 8: undewey = loadTable("q3_country_noDewey_CD.csv","header");   
                break;
        case 9: undewey = loadTable("q3_country_noDewey_DVD.csv","header");   
                break;
      }
      
      // fill bead matrix
      for (TableRow row : undewey.rows()) {
        for (int m=0; m<noMonths; m++) {
          for (int w=0; w<noYears; w++){
            int yr = w + startYear;
            int mn = m + 1;
            if (row.getInt("year(cout)")==yr && row.getInt("month(cout)")==mn) {
              beadMatrix[w][m] = row.getFloat(cName);
            }
          }
        }
      }
      
      // create bead at (n,0,0)
      float ubX = n * colSpacing - (colsPerClass * colSpacing)/2;
      udBeads[n][c] = new Bead(beadMatrix,ubX,0,0,bH,cName,-1);
    }
}