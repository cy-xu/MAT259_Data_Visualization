import peasy.PeasyCam;

PShape s;
PeasyCam cam;

void setup() {
  size(640, 480, P3D);
  cam = new PeasyCam(this, 200);

  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("Whale_01.obj");
  s.scale(4.0);
}

void draw() {
  background(204);
  //translate(width/2, height/2);

  shape(s, 100, 100);
}