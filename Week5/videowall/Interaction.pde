boolean isWireframe = true;
boolean isColor = false;
boolean isLight = false;
boolean isShaded = false;
boolean isSave = false;

int isCentered = 0;

boolean saveOneFrame = false;
boolean randomCurveUpdate = false;
boolean autoRotate = true;
boolean useOpacityNodesText = false;

void keyPressed(){
  if(key == '1'){
    isWireframe = !isWireframe;
  }
  if(key == '2'){
    isShaded = !isShaded;
  }
  else if(key == '3'){
    isColor = !isColor;
  }
  else if(key == '4'){
    isLight = !isLight;
  }
  else if(key == 's'){
    g.save(millis()+".png");
  }
  
  
  if (key == ' ') {
    isCentered = isCentered++>3 ? isCentered=0: isCentered; 
  }
  else if (key == 'w'){
    randomCurveUpdate = !randomCurveUpdate;
  }
  else if (key == 'q'){
    useOpacityNodesText = !useOpacityNodesText;
  }

  if(key == 'h'){
    for (int gridY=1; gridY< gridResolutionY-1; gridY++) {  
      for (int gridX=1; gridX< gridResolutionX-1; gridX++) { 
        print(tiles[gridX][gridY]);
      }
      println(' ');
    }
  }

  else if (key == 'l'){
    glitchLasttime = millis();
    glitchTime = 750;
  }
  else if (key == 'k'){
    strobeLasttime = millis();
    strobeTime = 400;
  }

}