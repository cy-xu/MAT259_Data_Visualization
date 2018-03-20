// backlog
// - create stacked boxes
// - Christina's own attempt at colouring boxes
// - creating classes for each box

// Earth
float globeRadiusInner = 250;
float globeRadiusOuter = 600;
PShape earthGlobe;
PImage earthImage;

// Misc
float keysStartPosX = 0;
float keysStartPosY = 20;
float keysGapSpace = 20;
int titleMaxLength = 110;
int keySelectXBoundary = 200;
float transitionState = 1;

// Rotation
boolean isRotating = true;
float rotationAngle = 200;
float rotationSpeed = 0.005;

// Locations
Table locationsTable;
PVector[] locationVectors;
PVector[] locationRefVectors;
float[] locationHeights;
float[] rotationAngles;
PVector[] rotationAxis;
String[] locationDepartmentNames;
float[] locationDepartmentHues;
String[] locationThesisTitles;
int locationsCount;

// Department names
String[] departmentNames = {
  "Applied Mathematics", 
  "Asian Studies", 
  "Biomolecular Science and Engineering", 
  "Chemical Engineering", 
  "Chemistry", 
  "Chemistry and Biochemistry", 
  "Chicana and Chicano Studies", 
  "Classics", 
  "Communication", 
  "Comparative Literature", 
  "Computer Science", 
  "Counseling, Clinical and School Psychology", 
  "Earth Science", 
  "Ecology, Evolution and Marine Biology", 
  "Economics", 
  "Education", 
  "Education - Gevirtz Graduate School", 
  "Education, Joint Program Cal Poly SLO", 
  "Electrical and Computer Engineering", 
  "English", 
  "Environmental Science and Management", 
  "Feminist Studies", 
  "Film and Media Studies", 
  "French", 
  "French and Italian", 
  "Geography", 
  "Geography, Joint Program SDSU", 
  "Geological Sciences", 
  "Global and International Studies", 
  "Hispanic Languages and Literatures", 
  "History", 
  "History of Art and Architecture", 
  "Latin American and Iberian Studies", 
  "Linguistics", 
  "Marine Science", 
  "Materials", 
  "Mathematics", 
  "Mechanical Engineering", 
  "Molecular, Cellular and Developmental Biology", 
  "Music", 
  "Philosophy", 
  "Physics", 
  "Political Science", 
  "Psychological and Brain Sciences", 
  "Religious Studies", 
  "Sociology", 
  "Spanish", 
  "Spanish and Portuguese", 
  "Theater and Dance", 
  "Theater Studies"
};
int departmentsCount = departmentNames.length;
float[] departmentColors = new float[departmentsCount];
IntDict departmentLocationsCounts = new IntDict();
HashMap<String, IntDict> departmentThesisMap = new HashMap<String, IntDict>();
String[][] departmentThesisTitles = new String[departmentsCount][0];
int indexOfDepartmentHovered = -1;
int indexOfDepartmentSelected = -1;
int indexOfThesisHovered = -1;

// UCSB
float ucsbLat = radians(34.4140);
float ucsbLon = radians(-119.8489);
PVector ucsbVector = getCartesianVector(ucsbLat, ucsbLon, globeRadiusInner);
PVector ucsbRefVector = getCartesianVector(ucsbLat, ucsbLon, globeRadiusOuter);  // good good

//Translation
float rectX=800, rectZ = 600;
float MapMax = 100;

void setup() {
  fullScreen(P3D);
  colorMode(HSB, 800);
  frameRate(30);
  noStroke();
  PImage earthImage = loadImage("earth.jpg");
  earthGlobe = createShape(SPHERE, globeRadiusInner);
  earthGlobe.setTexture(earthImage);

  // setup locations
  locationsTable = loadTable("fullListGeocoded.csv", "header");
  locationsCount = locationsTable.getRowCount();
  locationVectors = new PVector[locationsCount];
  locationRefVectors = new PVector[locationsCount];
  locationHeights = new float[locationsCount];
  rotationAngles = new float[locationsCount];
  rotationAxis = new PVector[locationsCount];
  locationDepartmentNames = new String[locationsCount];
  locationDepartmentHues = new float[locationsCount];  // this is a new hue for every location
  locationThesisTitles =  new String[locationsCount];
  PVector xAxis = new PVector (0, 1, 0);

  // loop through locations
  for (int i = 0; i < locationsCount; i++) {
    TableRow row = locationsTable.getRow(i);
    // retrieves the ith row from dataTable, and save to "row" variable

    float lat = radians(row.getFloat("lat"));  // retrieves the latitutde from the "current" row
    float lon = radians(row.getFloat("lon"));
    float[] refParams = getRefParams(lat, lon, ucsbLat, ucsbLon, 0.25);
    locationVectors[i] = getCartesianVector(lat, lon, globeRadiusInner);
    locationRefVectors[i] = getCartesianVector(refParams[0], refParams[1], refParams[2]);

    String departmentName = row.getString("department");
    locationDepartmentNames[i] = departmentName;
    locationDepartmentHues[i] = getDepartmentColor(departmentName);

    String title = row.getString("title");
    locationThesisTitles[i]= title;

    // set locations count for each department
    if (departmentLocationsCounts.hasKey(departmentName)) {
      departmentLocationsCounts.set(departmentName, departmentLocationsCounts.get(departmentName) + 1);
    } else {
      departmentLocationsCounts.set(departmentName, 1);
    }
    // set locations count for each thesis
    IntDict thesisInCurrDepartment = departmentThesisMap.get(departmentName);
    if (thesisInCurrDepartment == null) {
      thesisInCurrDepartment = new IntDict();
    }
    if (thesisInCurrDepartment.hasKey(title)) {
      thesisInCurrDepartment.set(title, thesisInCurrDepartment.get(title) + 1);
    } else {
      thesisInCurrDepartment.set(title, 1);        
    }
    departmentThesisMap.put(departmentName, thesisInCurrDepartment);

    float numberOfItems = row.getFloat("Frequency");
    float maxHeight = pow(10, 10);
    locationHeights[i] = map(pow(1.6, numberOfItems), 0, maxHeight, 10, 50);
    rotationAngles[i] = PVector.angleBetween(xAxis, locationVectors[i]);
    rotationAxis[i] = xAxis.cross(locationVectors[i]);
  }

  //  loop through departments
  for (int i = 0; i < departmentsCount; i++) {
    departmentColors[i] = getDepartmentColor(departmentNames[i]);
    
    IntDict thesisTitles = departmentThesisMap.get(departmentNames[i]);
    thesisTitles.sortKeys();
    
    departmentThesisTitles[i] = thesisTitles.keyArray();
  }
}

void mousePressed() {
  if (indexOfDepartmentSelected >= 0) {
    indexOfDepartmentSelected = -1;
    indexOfDepartmentHovered = -1;
    indexOfThesisHovered = -1;
    transitionState = 1 - transitionState;
  } else if (indexOfDepartmentHovered >= 0) {
    indexOfDepartmentSelected = indexOfDepartmentHovered;
    transitionState = 1 - transitionState;
  }
}

void mouseMoved() {
  if (indexOfDepartmentSelected >= 0) {
    // thesis selection
    if (mouseX < keySelectXBoundary * 2) {
      indexOfThesisHovered = floor((mouseY - keysGapSpace / 2 - 38) / keysGapSpace);
      if (indexOfThesisHovered < 0 || indexOfThesisHovered > departmentThesisTitles[indexOfDepartmentSelected].length  - 1) {
        indexOfThesisHovered = -1;
      }
    } else {
      indexOfThesisHovered = -1;
    }    
  } else {
    // department selection
    if (mouseX < keySelectXBoundary) {
      indexOfDepartmentHovered = floor((mouseY - keysGapSpace / 2) / keysGapSpace);
      if (indexOfDepartmentHovered < 0 || indexOfDepartmentHovered > departmentsCount - 1) {
        indexOfDepartmentHovered = -1;
      }
    } else {
      indexOfDepartmentHovered = -1;
    }
  }
}

void keyPressed() {
  if (isRotating == true) {
    isRotating = false;
  } else if (keyCode == LEFT || keyCode == RIGHT) {
    // do nothing
  } else {
    isRotating = true;
  }
}

void doTranslateReferenceKeys() {
  if (indexOfDepartmentSelected >= 0) {
    float focusedY = -1 * (keysGapSpace * indexOfDepartmentSelected);

    translate(0, transitionState * focusedY);
  }
}

void doTranslateEarth() {
  float defaultX = width * 0.55;
  float defaultY = height * 0.5;
  float defaultZ = 0;

  float defocusedX = width * 0.95;
  float defocusedY = height * 0.25;
  float defocusedZ = -800;

  if (indexOfDepartmentSelected >= 0) {
    // defocused earth
    translate(
      defaultX + transitionState * (defocusedX - defaultX), 
      defaultY + transitionState * (defocusedY - defaultY), 
      defaultZ + transitionState * (defocusedZ - defaultZ)
    );
  } else {
    // focused earth
    translate(
      defocusedX + transitionState * (defaultX - defocusedX), 
      defocusedY + transitionState * (defaultY - defocusedY), 
      defocusedZ + transitionState * (defaultZ - defocusedZ)
    );
  }

  if (transitionState < 1) {
    transitionState += 0.1;
  }
}

void doRotate(float rotationSpeed) {
  rotateY(rotationAngle);
  
  if (isRotating == true) {
    rotationAngle += rotationSpeed;
  } else if (keyPressed) {
    if (keyCode == LEFT) {
      rotationAngle -= rotationSpeed * 5;
    } else if (keyCode == RIGHT) {
      rotationAngle += rotationSpeed * 5;
    }
  }
}

float getDepartmentColor(String name) {
  for (int i = 0; i < departmentsCount; i++) {
    if (name.equals(departmentNames[i])) {
      return (i * 800 / departmentsCount);
    }
  }
  return 0;
}

void drawReferenceKeys() {
  // only draw text of department that is highlighted
  fill(0);
  strokeWeight(2);
  textSize(10);
  textAlign(LEFT);

  float keyLinesLength = 30;
  float keyTextStartPosX = keysStartPosX + keyLinesLength + 5;
  float keyTextStartPosY = keysStartPosY + 3;
  String departmentName;
  String thesisTitle;
  int thesisLocationsCount;

  for (int i = 0; i < departmentsCount; i++) {
    if (indexOfDepartmentSelected == i || indexOfDepartmentSelected == -1) {
      // department color line
      stroke(departmentColors[i], 450, 450, 900);
      line(
        keysStartPosX, 
        keysStartPosY + keysGapSpace * i, 
        keyLinesLength, 
        keysStartPosY + keysGapSpace * i
      );

      // department name
      if (indexOfDepartmentHovered == i || indexOfDepartmentHovered == -1) {
        fill(800);
      } else {
        fill(400);
      }
      departmentName = departmentNames[i];
      text(departmentName + " [" + departmentLocationsCounts.get(departmentName) + "]", keyTextStartPosX, keyTextStartPosY + keysGapSpace * i);

      if (indexOfDepartmentSelected == i) {
        // vertical line
        line(
          keysStartPosX + 50, 
          keysStartPosY + keysGapSpace * i + 10, 
          keysStartPosX + 50, 
          keysStartPosY + keysGapSpace * i + 20
        );
        
        IntDict thesisLocationCounts = departmentThesisMap.get(departmentNames[indexOfDepartmentSelected]);

        // thesis names
        for (int j = 0; j < departmentThesisTitles[i].length; j++) {
          thesisTitle = departmentThesisTitles[i][j];
          thesisLocationsCount = thesisLocationCounts.get(thesisTitle);
          if (thesisTitle.length() > titleMaxLength) {
            thesisTitle = thesisTitle.substring(0, titleMaxLength) + "...";
          }
          
          if (indexOfThesisHovered == j || indexOfThesisHovered == -1) {
            fill(800);
          } else {
            fill(400);
          }
          text(
            thesisTitle + " [" + thesisLocationsCount + "]", 
            keysStartPosX + 40, 
            keysStartPosY + keysGapSpace * (i + j) + 38
          );
        }
      }
    }
  }
}

void drawText() {
  pushMatrix();
  fill(800);
  translate(1000, MapMax*1.5, -rectZ);
  strokeWeight(2);
  textAlign(CENTER, CENTER);    
  String title = "SPATIALISING UCSB RESEARCH";
  String subTitle = "Where does research at UCSB come from?";
  String description ="This interactive 3D data visualization examines the relationship between different departments at UCSB and the geographic nature of their research. The result situates scientific research at UCSB in more powerful ways than library shelves, supporting multiple paradigms of data discovery. More broadly, this project generates verbal, written, and visual communication methods, with a particular emphasis on framing relationships, visual storytelling, and information design. Such spatializations convey how scientific research topics are related through similarity (by department type and proximity).";
  textSize(40);
  text (title, -rectX/2, MapMax*5.5, rectX, MapMax*7.5);
  textSize(24);
  text (subTitle, -rectX/2, MapMax*6.0, rectX, MapMax*7.5);
  textSize(19);
  text (description, -rectX/2, MapMax*7.5, rectX, MapMax*7.5);
  textLeading(20);
  popMatrix();
  }

void drawEarth() {
  shape(earthGlobe);
}

void drawUCSB() {
  pushMatrix();
  translate(ucsbVector.x, ucsbVector.y, ucsbVector.z);
  fill(204, 133, 0);  // random red colour
  // box(5, locationHeights[i], 5);
  popMatrix();
}

void drawLocations() {
  for (int i = 0; i < locationsCount; i++) {
    pushMatrix();
    fill(800);
    stroke(800);
    PVector vector = locationVectors[i];
    PVector rotationAxes = rotationAxis[i];
    translate(vector.x, vector.y, vector.z);
    rotate(rotationAngles[i], rotationAxes.x, rotationAxes.y, rotationAxes.z);
    box(5, 5, 5);
    //box(5, locationHeights[i], 5);
    //ellipseMode(CENTER);
    //ellipse(0,0, locationHeights[i], locationHeights[i]);
    popMatrix();
  }
}

void drawBezierCurves() {
  noFill();
  stroke(255);
  for (int i = 0; i < locationsCount; i++) {

    boolean shouldRenderBezier = true;
    if (indexOfDepartmentSelected > 0) {
      // render by title
      shouldRenderBezier = departmentNames[indexOfDepartmentSelected].equals(locationDepartmentNames[i]);
      if (indexOfThesisHovered >= 0) {
        shouldRenderBezier = departmentThesisTitles[indexOfDepartmentSelected][indexOfThesisHovered].equals(locationThesisTitles[i]);
      }
    } else {
      // render by department
      if (indexOfDepartmentHovered >= 0) {
        shouldRenderBezier = departmentNames[indexOfDepartmentHovered].equals(locationDepartmentNames[i]);
      }      
    }

    if (shouldRenderBezier) {
      PVector vector = locationVectors[i];
      PVector refVector = locationRefVectors[i];
      // x.2 inside bezier loop, call function, using "current" location department, to get color
      stroke(locationDepartmentHues[i], 450, 450, 900); //change colours here
      beginShape();
      vertex(vector.x, vector.y, vector.z);
      bezierVertex(
        refVector.x, refVector.y, refVector.z, 
        ucsbRefVector.x, ucsbRefVector.y, ucsbRefVector.z, 
        ucsbVector.x, ucsbVector.y, ucsbVector.z
        );
      endShape();
    }
  }
}

void draw() {
  pushMatrix();
  background(51);
  doTranslateReferenceKeys();
  drawReferenceKeys();
  drawText();
  popMatrix();

  doTranslateEarth();
  doRotate(rotationSpeed);
  drawEarth();
  drawUCSB();
  drawLocations();

  // drawing Bezier Curves
  drawBezierCurves();
}

// Converting to Cartesian coordinate system
PVector getCartesianVector(float lat, float lon, float radius) {
  float x = radius * cos(lat) * cos(lon + PI);
  float y = radius * cos(lat) * sin(lon + PI);
  float z = radius * sin(lat);

  return new PVector(x, -z, -y);
}

float[] getRefParams(float latInit, float lonInit, float latDest, float lonDest, float fraction) {
  float deltaLat = latDest - latInit;
  float deltaLon = lonDest - lonInit;
  float chordLength = sin(deltaLat/2) * sin(deltaLat/2) +
    cos(latInit) * cos(latDest) * sin(deltaLon/2) * sin(deltaLon/2);
  float angularDist = 2 * atan2(sqrt(chordLength), sqrt(1-chordLength));

  float a = sin((1 - fraction) * angularDist) / sin(angularDist);
  float b = sin(fraction * angularDist) / sin(angularDist);
  float x = a * cos(latInit) * cos(lonInit) + b * cos(latDest) * cos(lonDest);
  float y = a * cos(latInit) * sin(lonInit) + b * cos(latDest) * sin(lonDest);
  float z = a * sin(latInit) + b * sin(latDest);

  float lat = atan2(z, sqrt(x * x + y * y));
  float lon = atan2(y, x);

  float maxRadius = globeRadiusOuter + (globeRadiusOuter - globeRadiusInner);
  float minRadius = globeRadiusOuter - (globeRadiusOuter - globeRadiusInner) / 2;
  float radius = minRadius + (angularDist / PI) * (maxRadius - minRadius);

  return new float[]{lat, lon, radius};
}