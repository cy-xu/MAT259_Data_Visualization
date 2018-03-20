class earthquakeEvent {
  public earthquakeEvent() {
  }
  public boolean tsunami; // 1 FLAG_TSUNAMI
  public int year; // 2 YEAR 
  public float magnitude; // 9 EQ_PRIMARY 10 EQ_MAG_MW 11 EQ_MAG_MS 12 EQ_MAG_MB 13 EQ_MAG_ML 14 EQ_MAG_MFA 15 EQ_MAG_UNK
  public String country; // 17 COUNTRY
  public float latitude; // 20 LATITUDE
  public float longitude; // 21 LONGITUDE
  public String death; // 35 TOTAL_DEATHS
  public float rndPhase;
  public void printInfo() {
    println("Year: " + year + " TSU: " + tsunami + " Mag: " + magnitude + " C: " + country + " LAT: " 
            + latitude + " LONG: " + longitude + " Death: " + death);
  }
  String getStrInfo() {
    String str = "Year: " + year + ", Mag: " + magnitude + ", Country: " + country + "\n" + " Tsunami?: ";
    if (tsunami) {
      str += "Yes";
    } else {
      str += "No";
    }
    if (death.length() != 0) {
      str += ", Death: " + death;
    }
    return str;
  }
};

class volcanoEvent {
  public volcanoEvent() {
  }
  
  public int year; // 0 Year
  public boolean tsunami; // 3 TSU
  public boolean earthquake; // 4 EQ
  public String name; // 5 NAME
  public String country; // 7 Country
  public float latitude; // 8 Latitude
  public float longitude; // 9 Longitude
  public float magnitude; // 14 VEI
  public String death; // 26 TOTAL_DEATHS
  public float rndPhase;
  public void printInfo() {
    println("Year: " + year + " Name: " + name + " TSU: " + tsunami + " EQU: " + earthquake + " C: " + country + " LAT: " + latitude + 
            " LONG: " + longitude + " MAG: " + magnitude + " Death: " + death);
  }
  
  String getStrInfo() {
    String str = "Year: " + year + ", Mag: " + magnitude + ", Country: " + country + "\n" ;

    if (death.length() != 0) {
      str += ", Death: " + death;
    }
    return str;
  }
};

class tsunamiEvent{
  public tsunamiEvent() {
  }
  public int year; // 1
  public String country; // 11
  public float latitude; // 14
  public float longitude;  // 15
  public float magnitude;  // 19
  public String death; // 34
  public float rndPhase;
  public void printInfo() {
    println("Year: " + year + " C: " + country + " LAT: " + latitude + " LONG: " +
    longitude + " mag: " + magnitude + " Death: " + death);
  }
  
  String getStrInfo() {
    String str = "Year: " + year + ", Mag: " + magnitude + ", Country: " + country + "\n";

    if (death.length() != 0) {
      str += ", Death: " + death;
    }
    return str;
  }
}

void parseTsunamiData() {
  int numTRow = tsunamiTab.getRowCount();
  for (int i = 1; i < numTRow; i++) {
    tsunamiEvent tEvent = new tsunamiEvent();
    String strYear = trim(tsunamiTab.getString(i, 1));
    String strCountry = trim(tsunamiTab.getString(i, 11));
    String strLat = trim(tsunamiTab.getString(i, 14));
    String strLong = trim(tsunamiTab.getString(i, 15));
    String strMag = trim(tsunamiTab.getString(i,10));
    String strMagIDA = trim(tsunamiTab.getString(i, 19));
    String strMagSOL = trim(tsunamiTab.getString(i, 20));
    String strDeath = trim(tsunamiTab.getString(i, 34));
    // Jump if key data is missing.
    if (strYear.length() == 0 || strLat.length() == 0 || strLong.length() == 0) {
      continue;
    }
    tEvent.year = Integer.parseInt(strYear);
    tEvent.country = strCountry;
    tEvent.latitude = Float.parseFloat(strLat);
    tEvent.longitude = Float.parseFloat(strLong);
    
    float mag = 0;
    if (strMagSOL.length() != 0) {
      mag = Float.parseFloat(strMagSOL);
    } else if (strMagIDA.length() != 0) {
      float idaM = Float.parseFloat(strMagIDA);
      // convert ida to sol
      float h = pow(2.0, idaM);
      mag = log2(sqrt(2.0) * h);
    } else if (strMag.length() != 0) {
      mag = Float.parseFloat(strMag);
    }
    // get max and min magnitude.
    if (mag > magMaxTsu) {
      magMaxTsu = mag;
    }
    if (mag < magMinTsu) {
      magMinTsu = mag;
    }
    tEvent.magnitude = mag;
    tEvent.death = strDeath;
    tEvent.rndPhase = random(0,1);
    tsuEvents.add(tEvent);
    tsuYear.append(tEvent.year);
  }
}

void parseVolcanoData () {
  int numVRow = volcanoTab.getRowCount();
  for (int i = 1; i < numVRow; i++) {
    volcanoEvent volcanoEvent = new volcanoEvent();
    String strYear = trim(volcanoTab.getString(i, 0));
    String strTsu  = trim(volcanoTab.getString(i, 3));
    String strEqu  = trim(volcanoTab.getString(i, 4));
    String strName = trim(volcanoTab.getString(i, 5));
    String strCountry  = trim(volcanoTab.getString(i, 7));
    String strLat  = trim(volcanoTab.getString(i, 8));
    String strLong  = trim(volcanoTab.getString(i, 9));
    String strMag = trim(volcanoTab.getString(i, 14));
    String strDeath = trim(volcanoTab.getString(i, 26));
    // Jump if key data is missing.
    if (strYear.length() == 0 || strLat.length() == 0 || strLong.length() == 0) {
      continue;
    }
    volcanoEvent.year = Integer.parseInt(strYear);
    if (strTsu.length() != 0) {
      volcanoEvent.tsunami = true;
    } else {
      volcanoEvent.tsunami = false;
    }
    
    if (strEqu.length() != 0) {
      volcanoEvent.earthquake = true;
    } else {
      volcanoEvent.earthquake = false;
    }
    volcanoEvent.country = strCountry;
    volcanoEvent.latitude = Float.parseFloat(strLat);
    volcanoEvent.longitude = Float.parseFloat(strLong);
    // The default magnitude will be 2 if the data is missing.
    volcanoEvent.magnitude = 2.0;
    if (strMag.length() != 0) {
      volcanoEvent.magnitude = Float.parseFloat(strMag);
    }
    volcanoEvent.death = strDeath;
    volcanoEvent.name = strName;
    
    float mag = volcanoEvent.magnitude;
    // get max and min magnitude.
    if (mag > magMaxVol) {
      magMaxVol = mag;
    }
    if (mag < magMinVol) {
      magMinVol = mag;
    }
    volcanoEvent.rndPhase = random(0,1);
    volEvents.add(volcanoEvent);
    volYear.append(volcanoEvent.year);
  }
}

void parseEarthquakeData() {
  int numERow = earthquakeTab.getRowCount();
  int numECol = earthquakeTab.getColumnCount();
  for (int i = 1; i < numERow; i++) {
    earthquakeEvent eqEvent = new earthquakeEvent();
    String strTsu =  trim(earthquakeTab.getString(i, 1));
    String strYear = trim(earthquakeTab.getString(i, 2));
    String strMag0 = trim(earthquakeTab.getString(i, 9)); // pri
    String strMag1 = trim(earthquakeTab.getString(i, 10));
    String strMag2 = trim(earthquakeTab.getString(i, 11));
    String strMag3 = trim(earthquakeTab.getString(i, 12));
    String strMag4 = trim(earthquakeTab.getString(i, 13));
    String strMag5 = trim(earthquakeTab.getString(i, 14));
    String strMag6 = trim(earthquakeTab.getString(i, 15));
    String strCountry = trim(earthquakeTab.getString(i, 17));
    String strLat = trim(earthquakeTab.getString(i, 20));
    String strLong = trim(earthquakeTab.getString(i, 21));
    String strDeath = trim(earthquakeTab.getString(i, 35));
    // Jump if key data is missing.
    if (strYear.length() == 0 || strLat.length() == 0 || strLong.length() == 0) {
      continue;
    }
    
    if (strTsu.length()!= 0) {
      eqEvent.tsunami = true;
    } else {
      eqEvent.tsunami = false;
    }
    
    eqEvent.year = Integer.parseInt(strYear);
    eqEvent.magnitude = 5.0; // The default magnitude will be 5 if the data is missing.
    if (strMag0.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag0);
    } else if (strMag1.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag1);
    } else if (strMag2.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag2);
    } else if (strMag3.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag3);
    } else if (strMag4.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag4);
    } else if (strMag5.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag5);
    } else if (strMag6.length() != 0) {
      eqEvent.magnitude = Float.parseFloat(strMag5);
    }
    eqEvent.country = strCountry;
    eqEvent.latitude = Float.parseFloat(strLat);
    eqEvent.longitude = Float.parseFloat(strLong);
    eqEvent.death = strDeath;
    
    float mag = eqEvent.magnitude;
    // get max and min magnitude.
    if (mag > magMaxEqu) {
      magMaxEqu = mag;
    }
    if (mag < magMinEqu) {
      magMinEqu = mag;
    }
    eqEvent.rndPhase = random(0,1);
    eqEvents.add(eqEvent);
    equYear.append(eqEvent.year);
  }
}
 
void setDisplayArray(int year, float yearLength) {
  int tsuDispLen = (int) (maxNumTsu * yearLength);
  int EquDispLen = (int) (maxNumEqu * yearLength);
  int VolDispLen = (int) (maxNumVol * yearLength);
  
  volPsys.clear();
  tsuDisp.clear();
  equDisp.clear();
  volDisp.clear();
  // Extract tsu for display.
  int idxBegin = binarySearchInt(tsuYear, year);
  
  int idxEnd = idxBegin + tsuDispLen;
  for (int i = idxBegin; i < idxEnd && i < tsuEvents.size() ; i++) {
    tsuDisp.add(tsuEvents.get(i));
  }
  
  // Extract equ for display
  idxBegin = binarySearchInt(equYear, year);
  idxEnd = idxBegin + EquDispLen;
  for (int i = idxBegin; i < idxEnd && i < eqEvents.size(); i++) {
    equDisp.add(eqEvents.get(i));
  }
  
  // Extract vol for display
  idxBegin = binarySearchInt(volYear, year);
  idxEnd = idxBegin + VolDispLen;
  for (int i = idxBegin; i < idxEnd && i < volEvents.size(); i++) {
    volDisp.add(volEvents.get(i));
    float lat = volEvents.get(i).latitude;
    float lon = volEvents.get(i).longitude;
    PVector pos = new PVector();
    pos = sphereToXYZ(lat, lon, sphereRad*1.005);
    float zeroOneMag = getZeroOneRange(volEvents.get(i).magnitude, magMinVol, magMaxVol);
    int numP = (int) (300 * zeroOneMag);
    
    PVector grav = new PVector();
    grav.x = -pos.x;
    grav.y = -pos.y;
    grav.z = -pos.z;
  
    volPSystem = new Psystem(numP, pos.x, pos.y, pos.z, color(255,0,0), grav, zeroOneMag*0.6);
    volPsys.add(volPSystem);
  }
}