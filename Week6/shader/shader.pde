PGraphics o; //offscreen, FBO (framebuffer object)
PShader blur_shader;

void setup() {
  size(512, 512);
  o = createGraphics(width, height);
  //blur_shader = loadShader("sampling_shder.frag", "sampling_shder.vert");
}

void draw() {
  background(0);

  o.beginDraw();

  background(255);

  noStroke();

  fill(255, 255, 0);
  rect(50, 50, 100, 100);

  o.endDraw();

  image(o, 0, 0, width/2, height/2);
  //image(o, mouseX, mouseY, width /2, height /2);
}