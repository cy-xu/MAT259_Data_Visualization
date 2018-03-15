void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void addControls() {
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("toggle")
    .setPosition(winWidth/20.0, 1.6 * top)
    .setSize(50, 20)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setLabel("Hide Introduction") 
    ;

  //cp5.addToggle("shuffleColor")
  //  .setPosition(winWidth/20.0, 2.8 * top)
  //  .setSize(50, 20)
  //  .setValue(true)
  //  .setMode(ControlP5.SWITCH)
  //  .setLabel("Shuffle Colors") 
  //  ;

  cp5.addSlider("maxspeed")
    .setPosition(winWidth/20.0, 0.8 * top)
    .setLabel("Change Boat Speed") 
    .setWidth(50)
    .setSize(100, 20)
    .setRange(1, 8) // values can range from big to small as well
    .setValue(3)
    .setNumberOfTickMarks(8)
    .setSliderMode(Slider.FLEXIBLE)
    ;
}

void draw2DText() {

  PVector center = new PVector(winWidth/2.0, winHeight/2.0, 0);
  PVector mouse = new PVector(mouseX, mouseY, 0);
  //float dMouse = PVector.dist(center, mouse);
  //float alpha = map(dMouse, 500, 300, 0, 255);
  float alpha = 255;

  // Title
  pushMatrix();
  translate(0, -80, -5);
  fill(20, alpha);
  textSize(32);
  textLeading(30);
  textAlign(CENTER, CENTER);
  String title = "Top Wildlife Buyers and Sellers";
  rectMode(CENTER);
  text(title, 0, 0, 0.4 * winWidth, 0.3 * winHeight);
  popMatrix();

  pushMatrix();
  translate(0, -20, -4);
  fill(100, alpha);
  textSize(28);
  textLeading(30);
  textAlign(CENTER, CENTER);
  String subTitle = "and their trade visualized based on CITES 2016 data";
  rectMode(CENTER);
  text(subTitle, 0, 0, 0.3 * winWidth, 0.3 * winHeight);
  popMatrix();

  pushMatrix();
  translate(0, winHeight / 2.3, -2);
  fill(20, alpha);
  textSize(18);
  textLeading(22);
  textAlign(CENTER, CENTER);
  String introduction = "Each boat (triangle) represents one trasaction between world's top 14 wildlife importers and exporters. Boats are marked in exporter's color. Boats in light gray, coming and going outside the windows represents trade between other countries/regions not shown here. Data credit: CITES Wildlife Trade Database 2016. Chengyuan Xu, MAT UCSB";
  rectMode(CENTER);
  text(introduction, 0, 0, 0.8 * winWidth, 0.15 * winHeight);
  popMatrix();
}