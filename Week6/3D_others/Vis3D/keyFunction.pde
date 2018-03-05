void keyPressed() {
  if (key == '1') whichSelect = 0;
  if (key == '2') whichSelect = 1;
  if (key == '3') whichSelect = 2;
  if (key == '4') whichSelect = 3;
  if (key == '1' || key == '2' || key == '3' || key == '4') {
    displayAll = !displayAll;
    transit = !transit;
    inTransit = true;
    fadeCounter = 0;
  
    if (displayAll) {
      //whichSelect = -1;
      AllInit();
    }
    if (!displayAll) {
      if (whichSelect == 0) {
        InitDrama();
      } else if (whichSelect == 1) {
        InitFantasy();
      } else if (whichSelect == 2) {
        InitHistory();
      } else {
        InitScifi();
      }
    }
  }
}