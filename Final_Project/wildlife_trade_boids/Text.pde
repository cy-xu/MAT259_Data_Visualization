void draw2DText() {

  PVector center = new PVector(winWidth/2.0, winHeight/2.0, 0);
  PVector mouse = new PVector(mouseX, mouseY, 0);
  float dMouse = PVector.dist(center, mouse);
  println(dMouse);
  float alpha = map(dMouse, 500, 300, 0, 255);

  // Title
  pushMatrix();
  translate(0, -80, -1);
  fill(50, 50, 50, alpha);
  textSize(32);
  textLeading(30);
  textAlign(CENTER, CENTER);
  String title = "Top Wildlife Buyers and Sellers";
  rectMode(CENTER);
  text(title, 0, 0, 0.4 * winWidth, 0.3 * winHeight);
  popMatrix();

  pushMatrix();
  translate(0, -20, -2);
  fill(100, alpha);
  textSize(28);
  textLeading(30);
  textAlign(CENTER, CENTER);
  String subTitle = "and their trade visualized based on UN 2016 data";
  rectMode(CENTER);
  text(subTitle, 0, 0, 0.3 * winWidth, 0.3 * winHeight);
  popMatrix();

  pushMatrix();
  translate(0, winHeight / 2.2, -2);
  fill(50, alpha);
  textSize(18);
  textLeading(22);
  textAlign(CENTER, CENTER);
  String introduction = "Each boat (triangle) represents one trasaction between world's top 14 wildlife importers and exporters. Boats are marked in exporter's color. Boats in light gray, coming and going outside the windows represents trade between other countries/regions not shown here. Data credit: UN CITES Wildlife Trade Database 2016. Author: Chengyuan Xu";
  rectMode(CENTER);
  text(introduction, 0, 0, 0.8 * winWidth, 0.15 * winHeight);
  popMatrix();
}