
PVector otherImporter = new PVector(winWidth, winHeight/2);
PVector otherExporter = new PVector(winWidth, winHeight/2);

HashMap<String, State> stateMap = new HashMap<String, State>();

class State {
  String codeName;
  String fullName;
  PVector position;
  color c;
  PImage flag;
  float rotation;
  int rank;

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
  
  for (Trade t : hashMap.values()) {

    if (topStates.hasValue(t.exporter)) {
      exporter = stateMap.get(t.exporter);
      origin = exporter.position.copy();
      if (topStates.hasValue(t.importer)) {
        importer = stateMap.get(t.importer);
        destination = importer.position.copy();
      } else {
        importer = null;
        destination = origin.copy().mult(random(5, 6)).rotate(PI / 12.0);
      }
    } else {
      importer = stateMap.get(t.importer);
      destination = importer.position.copy();
      exporter = null;
      origin = destination.copy().mult(random(5, 6)).rotate(PI / -12.0);
    }

    tempKey = t.A2B;
    boidCount = ceil(log10(t.quantity/1000));
    //boidCount = ceil(t.quantity/100000000);

    // assign color
    if (topStates.hasValue(t.exporter)) {
      c = exporter.c;
    } else {
      c = color(188, 170, 164);
    }

    for (int i = 0; i < int(boidCount); i++) {
      testRoute.addBoid(new Boid(origin, destination, c));
    }
  }
}