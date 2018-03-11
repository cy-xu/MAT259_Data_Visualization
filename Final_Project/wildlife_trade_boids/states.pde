
PVector otherImporter = new PVector(winWidth, winHeight/2);
PVector otherExporter = new PVector(winWidth, winHeight/2);

HashMap<String, State> stateMap = new HashMap<String, State>();

class State {
  String codeName;
  String fullName;
  PVector exporter_pos, importer_pos;
  color c;

  State(String code, String name) {
    codeName = code;
    fullName = name;
  }
}

void drawState() {
  PVector origin, destination;
  State exporter, importer;
  String tempKey;
  State currState;
  int boidCount;
  color c;


  println("top = "+ top);
  println("bottom = "+ bottom);
  println("otherImporter = "+ otherImporter);
  println("otherExporter = "+ otherExporter);

  for (Trade t : hashMap.values()) {
    tempKey = t.A2B;
    exporter = stateMap.get(t.exporter);
    importer = stateMap.get(t.importer);
    boidCount = int(t.quantity/100000);
    c = exporter.c;

    origin = exporter.exporter_pos.copy();
    destination = importer.importer_pos.copy();

    //println("t.A2B = "+ t.A2B + ", tempKey = " + tempKey);
    //println("origin is " + origin + " destination is " + destination);
    //println(boidCount + " boids added for " + tempKey);

    for (int i = 0; i < int(boidCount); i++) {
      testRoute.addBoid(new Boid(origin, destination, c));
    }
  }
}

void whichState() {
  for (String code : topStates) {
    if (!stateMap.containsKey(code)) {
      switch(code) {
      case "US":
        State US = new State("US", "United States of America");
        US.importer_pos = new PVector((0+0.5) * colWidth, top);
        US.exporter_pos = new PVector((3+0.5) * colWidth, bottom);
        US.c = color(41, 128, 185);
        stateMap.put(code, US);
        break;
      case "JP":
        State JP = new State("JP", "Japan");
        JP.importer_pos = new PVector((1+0.5) * colWidth, top);
        JP.exporter_pos = otherExporter.copy();
        JP.c = color(253, 237, 236);
        stateMap.put(code, JP);
        break;
      case "DE":
        State DE = new State("DE", "Germany");
        DE.importer_pos = new PVector((2+0.5) * colWidth, top);
        DE.exporter_pos = new PVector((5+0.5) * colWidth, bottom);
        DE.c = color(128, 139, 150);
        stateMap.put(code, DE);
        break;
      case "FR":
        State FR = new State("FR", "France");
        FR.importer_pos = new PVector((3+0.5) * colWidth, top);
        FR.exporter_pos = new PVector((4+0.5) * colWidth, bottom);
        FR.c = color(253, 254, 254);
        stateMap.put(code, FR);
        break;
      case "HK":
        State HK = new State("HK", "Hong Kong");
        HK.importer_pos = new PVector((4+0.5) * colWidth, top);
        HK.exporter_pos = otherExporter.copy();
        HK.c = color(214, 234, 248);
        stateMap.put(code, HK);
        break;
      case "CH":
        State CH = new State("CH", "Switzerland");
        CH.importer_pos = new PVector((5+0.5) * colWidth, top);
        CH.exporter_pos = new PVector((9+0.5) * colWidth, bottom);
        CH.c = color(232, 218, 239);
        stateMap.put(code, CH);
        break;
      case "CN":
        State CN = new State("CN", "China");
        CN.importer_pos = new PVector((6+0.5) * colWidth, top);
        CN.exporter_pos = new PVector((6+0.5) * colWidth, bottom);
        CN.c = color(250, 128, 114);
        stateMap.put(code, CN);
        break;
      case "SG":
        State SG = new State("SG", "Singapore");
        SG.importer_pos = new PVector((7+0.5) * colWidth, top);
        SG.exporter_pos = new PVector((8+0.5) * colWidth, bottom);
        SG.c = color(200, 230, 201);
        stateMap.put(code, SG);
        break;
      case "AE":
        State AE = new State("AE", "United Arab Emirates");
        AE.importer_pos = new PVector((8+0.5) * colWidth, top);
        AE.exporter_pos = otherExporter.copy();
        AE.c = color(77, 182, 172);
        stateMap.put(code, AE);
        break;
      case "CA":
        State CA = new State("CA", "Canada");
        CA.importer_pos = new PVector((9+0.5) * colWidth, top);
        CA.exporter_pos = otherExporter.copy();
        CA.c = color(245, 245, 245);
        stateMap.put(code, CA);
        break;
      case "NL":
        State NL = new State("NL", "Netherlands");
        NL.fullName = "Netherland";
        NL.importer_pos = new PVector(0, 0);
        NL.exporter_pos = new PVector((0+0.5) * colWidth, bottom);
        NL.c = color(248, 196, 113);
        stateMap.put(code, NL);
        break;
      case "ID":
        State ID = new State("ID", "Indonesia");
        ID.importer_pos = new PVector(0, 0);
        ID.exporter_pos = new PVector((1+0.5) * colWidth, bottom);
        ID.c = color(209, 196, 233);
        stateMap.put(code, ID);
        break;
      case "IT":
        State IT = new State("IT", "Italy");
        IT.importer_pos = new PVector(0, 0);
        IT.exporter_pos = new PVector((2+0.5) * colWidth, bottom);
        IT.c = color(100, 181, 246);
        stateMap.put(code, IT);
        break;
      case "EC":
        State EC = new State("EC", "Ecuador");
        EC.importer_pos = new PVector(0, 0);
        EC.exporter_pos = new PVector((2+0.5) * colWidth, bottom);
        EC.c = color(100, 181, 246);
        stateMap.put(code, EC);
        break;
      }
    }
  }
}