void iDisplay(){
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
 
  //Title
    fill(0,0,80);
    textAlign(LEFT);
    textSize(60);
    text("International SPL", -width+200, -height+150);
    
  // Country key
    for (int c=0; c<nCs; c++){
      if (cSwitch[c]) { 
        textSize(35);
        pushMatrix();
        translate(-width+300, -height+580+(c * 45), 0);
        stroke(countryHue(countryName(c)),0,0);
        fill(countryHue(countryName(c)),90,85);
        text(countryName(c),0,0);
        popMatrix();
      }
    }
    
  // interaction key 
    textSize(25);
    textAlign(LEFT);
    fill(0,0,80);
    text("K Schlesinger | MAT 259 3D Project",-width+250,-height+200);
    text("Data from Seattle Public Library",-width+250,-height+230);
    pushMatrix();
    translate(-width+250, -height+280); //750
    text("Press [d] for dots and [s] for spirals",0,0);
    text("Press [1-" + nCs + "] to toggle data for each country",0,30);
    text("Press [m] and [t] to toggle mouseover text and dates",0,60);
    text("Press [h] for hanging view and [r] for top view",0,90);
    text("Press [space] to allow free rotation", 0,120);
    text("Press [i] to toggle text interface",0,150);
    text("Press [l] to toggle labels",0,180);
    popMatrix();
    
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void mDisplay() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();

  // mouseover text
    if (dispTxt==true) {
      fill(0,0,80);
      textSize(25);
      textAlign(RIGHT);
      text(theTxt,width-150,-height+200);
    }
    
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}