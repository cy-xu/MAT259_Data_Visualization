float bigger(float a, float b) {
  if (a != a) {
    if (b != b) {
      return 0;
    } else {
      return b;
    }
  } else {
    if (b != b) {
      return a;
    } else {
      if (a > b) {
        return a;
      } else {
        return b;
      }
    }
  }
}

int log10 (float x) {
  return int(log(x) / log(10));
}

//void shuffleColor() {
//  for (State s : stateMap.values()) {
//    s.c = color(random(255), random(255), random(255));
//  }
//}

void whichState() {
  for (String code : topStates) {
    if (!stateMap.containsKey(code)) {
      switch(code) {
      case "US":
        State US = new State("US", "United States of America");
        US.rank = 1;
        US.c = color(0, 102, 255);
        US.flag = loadImage("US.png");
        US.position = new PVector(0.6 * radius, -0.8 * radius);
        stateMap.put(code, US);
        break;
      case "JP":
        State JP = new State("JP", "Japan");
        JP.rank = 2;
        JP.c = color(255, 205, 210);
        JP.flag = loadImage("JP.png");
        JP.position = new PVector(1.1 * radius, -0.52 * radius);
        stateMap.put(code, JP);
        break;
      case "DE":
        State DE = new State("DE", "Germany");
        DE.rank = 3;
        DE.c = color(117, 117, 117);
        DE.flag = loadImage("DE.png");
        DE.position = new PVector(1.4 * radius, -0.24 * radius);
        stateMap.put(code, DE);
        break;
      case "FR":
        State FR = new State("FR", "France");
        FR.rank = 4;
        FR.c = color(0, 0, 153);
        FR.flag = loadImage("FR.png");
        FR.position = new PVector(1.4 * radius, 0.24 * radius);
        stateMap.put(code, FR);
        break;
      case "HK":
        State HK = new State("HK", "Hong Kong");
        HK.rank = 5;
        HK.c = color(214, 234, 248);
        HK.flag = loadImage("HK.png");
        HK.position = new PVector(1.1 * radius, 0.52 * radius);
        stateMap.put(code, HK);
        break;
      case "CH":
        State CH = new State("CH", "Switzerland");
        CH.rank = 6;
        CH.c = color(232, 218, 239);
        CH.flag = loadImage("CH.png");
        CH.position = new PVector(0.6 * radius, 0.8 * radius);
        stateMap.put(code, CH);
        break;
      case "CN":
        State CN = new State("CN", "China");
        CN.rank = 7;
        CN.c = color(255, 0, 51);
        CN.flag = loadImage("CN.png");
        CN.position = new PVector(0, 0.9 * radius);
        stateMap.put(code, CN);
        break;
      case "SG":
        State SG = new State("SG", "Singapore");
        SG.rank = 8;
        SG.c = color(200, 230, 201);
        SG.flag = loadImage("SG.png");
        SG.position = new PVector(-0.6 * radius, 0.8 * radius);
        stateMap.put(code, SG);
        break;
      case "AE":
        State AE = new State("AE", "United Arab Emirates");
        AE.rank = 9;
        AE.c = color(77, 182, 172);
        AE.flag = loadImage("AE.png");
        AE.position = new PVector(-1.1 * radius, 0.52 * radius);
        stateMap.put(code, AE);
        break;
      case "CA":
        State CA = new State("CA", "Canada");
        CA.rank = 10;
        CA.c = color(245, 245, 245);
        CA.flag = loadImage("CA.png");
        CA.position = new PVector(-1.4 * radius, 0.24 * radius);
        stateMap.put(code, CA); 
        break;
      case "NL":
        State NL = new State("NL", "Netherlands");
        NL.rank = 11;
        NL.fullName = "Netherland";
        NL.c = color(248, 196, 113);
        NL.flag = loadImage("NL.png");
        NL.position = new PVector(-1.4 * radius, -0.24 * radius);
        stateMap.put(code, NL);
        break;
      case "ID":
        State ID = new State("ID", "Indonesia");
        ID.rank = 12;
        ID.c = color(255, 255, 255);
        ID.flag = loadImage("ID.png");
        ID.position = new PVector(-1.1 * radius, -0.52 * radius);
        stateMap.put(code, ID);
        break;
      case "IT":
        State IT = new State("IT", "Italy");
        IT.rank = 13;
        IT.c = color(0, 204, 153);
        IT.flag = loadImage("IT.png");
        IT.position = new PVector(-0.6 * radius, -0.8 * radius);
        stateMap.put(code, IT);
        break;
      case "EC":
        State EC = new State("EC", "Ecuador");
        EC.rank = 0;
        EC.c = color(255, 235, 59);
        EC.flag = loadImage("EC.png");
        EC.position = new PVector(0, -0.9 * radius);
        stateMap.put(code, EC);
        break;
      }
    }
  }

  for (State s : stateMap.values()) {
    s.rotation = 0;
  }
}