String[] deweyLabels;

void loadLabels() {
    labels = loadTable("deweyClasses.csv");
    deweyLabels = new String[1000];
    for (int k=0; k<1000; k++) {
      TableRow drow = labels.matchRow("^" + str(k) + "$",0);
      deweyLabels[k] = drow.getString(1);
    }
    if (unDewey) {
      unDeweyLabels = new String[10];
      for (int n=0; n<10; n++) {
        String udl = "";
        switch (n) {
          case 0: udl = "E";
                  break;
          case 1: udl = "J";   
                  break;
          case 2: udl = "YA";  
                  break;
          case 3: udl = "biography";   
                  break;
          case 4: udl = "mystery";   
                  break;
          case 5: udl = "sci-fi";   
                  break;
          case 6: udl = "fiction";   
                  break;
          case 7: udl = "VHS";      
                  break;
          case 8: udl = "CD";      
                  break;
          case 9: udl = "DVD";      
                  break;
        }
        unDeweyLabels[n] = udl;
      }
    }
}

void drawLabels() {
  for (int cl=0; cl<noClasses; cl++) {
    pushMatrix();
      rotateX(radians(90));
      rotateZ(radians(270));
      textAlign(LEFT, CENTER);
      textSize(lpix);
      stroke(0,0,80);
      float tx = (rowsPerClass * cl + uD) * (bH + beadSpacing) + 3*lpix/4;
      float ty = -1*(colsPerClass*colSpacing)/2 - lpix;
      text(deweyTitle(floor(startDewey/100)+cl), tx, ty);
    popMatrix();
  }
  for (int n=0; n<10; n++) {
    pushMatrix();
      rotateX(radians(90));
      rotateZ(radians(270));
      textAlign(RIGHT,CENTER);
      textSize(upix);
      stroke(0,0,80);
      float tx = - 3*lpix/4; //(bH + beadSpacing)
      float ty = -1*(colsPerClass*colSpacing)/2 + (n*colSpacing);
      text(unDeweyLabels[n], tx, ty);
    popMatrix();
  }
}

String deweyTitle(int dClass) {
// gives string title for dewey class
  String deweyClass;
  String deweyRegExp;
  String deweyTitle;
  
  switch(dClass){
    case 1: deweyClass = "100";
            deweyRegExp = "1..";
            deweyTitle = "philosophy & psychology";
            break;
    case 2: deweyClass = "200";
            deweyRegExp = "2..";
            deweyTitle = "religion";
            break;
    case 3: deweyClass = "300";
            deweyRegExp = "3..";
            deweyTitle = "social sciences & politics";
            break;
    case 4: deweyClass = "400";
            deweyRegExp = "4..";
            deweyTitle = "languages";
            break;
    case 5: deweyClass = "500";
            deweyRegExp = "5..";
            deweyTitle = "science";
            break;
    case 6: deweyClass = "600";
            deweyRegExp = "6..";
            deweyTitle = "technology";
            break;
    case 7: deweyClass = "700";
            deweyRegExp = "7..";
            deweyTitle = "arts & recreation";
            break;
    case 8: deweyClass = "800";
            deweyRegExp = "8..";
            deweyTitle = "literature";
            break;
    case 9: deweyClass = "900"; // dewey level 900 is default
            deweyRegExp = "9..";
            deweyTitle = "history & geography";
            break;
    case 0: deweyClass = "000";
            deweyRegExp = "^[0-9]?0$";
            deweyTitle = "computer science & information";
            break;
    default: deweyRegExp = "900";
             deweyClass = "9.."; 
             deweyTitle = "History & geography";
  }
  return deweyTitle;
}