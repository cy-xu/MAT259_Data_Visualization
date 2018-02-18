float offsetY;

void keyPressed()
{
  // label toggle
  if (key == 'l' || key == 'L') {
    if (lSwitch==true) lSwitch = false;
    else if (lSwitch==false) lSwitch = true; 
  }
  
  // mouseover text toggle
    if (key == 'm' || key == 'M') {
    if (mSwitch==true) mSwitch = false;
    else if (mSwitch==false) mSwitch = true; 
  }
  
  // mouseover bead time labels toggle
  if (key == 't' || key == 'T') {
    if (tLabels==true) tLabels = false;
    else if (tLabels==false) {
      tLabels = true;
    }
  }
  
  // instruction text toggle
  if (key == 'i' || key == 'I') {
    if (iSwitch==true) iSwitch = false;
    else if (iSwitch==false) iSwitch = true; 
  }
  
  // different bead types
  if (key == 'd' || key == 's' || key == 'c' || key == 'f' ) { 
    // bead_type 1 is default (dot spiral)
    // set new bead_type
    if (key == 'd') bead_type = 1;
    if (key == 's') bead_type = 2;
    //if (key == 'c') bead_type = 3;
    //if (key == 'f') bead_type = 4;
  }
  
  // turn countries on and off
  if (key == '2') {
    if (nCs>=2){
    if (cSwitch[1]==true) cSwitch[1] = false;
    else if (cSwitch[1]==false) cSwitch[1] = true;
    }
  }
  if (key == '3') {
    if (nCs>=3){
    if (cSwitch[2]==true) cSwitch[2] = false;
    else if (cSwitch[2]==false) cSwitch[2] = true;
    }
  }
  if (key == '4') {
    if (nCs>=4){
    if (cSwitch[3]==true) cSwitch[3] = false;
    else if (cSwitch[3]==false) cSwitch[3] = true;
    }
  }
  if (key == '1') {
    if (nCs>=1){
    if (cSwitch[0]==true) cSwitch[0] = false;
    else if (cSwitch[0]==false) cSwitch[0] = true;
    }
  }
  if (key == '5') {
    if (nCs>=5){
    if (cSwitch[4]==true) cSwitch[4] = false;
    else if (cSwitch[4]==false) cSwitch[4] = true;
    }
  }
  if (key == '6') {
    if (nCs>=6){
    if (cSwitch[5]==true) cSwitch[5] = false;
    else if (cSwitch[5]==false) cSwitch[5] = true;
    }
  }
  
  // set camera modes
    if (key == 'r') { // road view
      cam.reset(0);   // immediate reset
      cam.setRotations(radians(30),0,0); // pitch up for angled view
      cam.setPitchRotationMode();  // allow pitch rotation only
      cam.setDistance(400);
      cam.pan(0,-height/4);
    }
    if (key == 'h') { // hanging view
      bead_type = 2;  // spirals on
      lSwitch = true; // labels on
      cam.reset(0);   // positioning
      cam.setRotations(PI/2,0,PI);
      cam.pan(colSpacing/2,250);
      cam.setPitchRotationMode(); // allow pitch rotation only
    }; 
    if (key == ' ') cam.setFreeRotationMode(); // unrestrict
  
}