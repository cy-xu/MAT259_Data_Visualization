PGraphics chptr4;

PImage[] modules;

float tileSize = 25;
int gridResolutionX, gridResolutionY;
char[][] tiles;

boolean drawGrid = true;
boolean debugMode = false;

void initChptr4() {
  chptr4 = createGraphics((int)_w, (int)_h, P2D);
  
  chptr4.smooth();
  
  gridResolutionX = round(width/tileSize)+2;
  gridResolutionY = round(height/tileSize)+2;
  tiles = new char[gridResolutionX][gridResolutionY];
  initTiles();

  // load svg modules
  modules = new PImage[17]; 
  for (int i=0; i< modules.length-1; i++) { 
    modules[i] = loadImage("pngs/A_"+nf(i,2)+".png");
  }
  modules[16] = loadImage("pngs/A_15_.png");
}


void drawChptr4() {
  chptr4.beginDraw();
  
  chptr4.background(0,0);

  if (mousePressed && (mouseButton == LEFT)) setTile();
  if (mousePressed && (mouseButton == RIGHT)) unsetTile();

//  if (drawGrid) drawGrid();
  drawModules();

  updateGrid();

  chptr4.endDraw();
}


void initTiles() {
  for (int gridY=0; gridY< gridResolutionY; gridY++) {
    for (int gridX=0; gridX< gridResolutionX; gridX++) {  
      tiles[gridX][gridY] = random(1)> 0.8 ? '1' : '0';
    }
  }
}

void setTile() {
  // convert mouse position to grid coordinates
  int gridX = floor((float)mouseX/tileSize) + 1;
  gridX = constrain(gridX, 1, gridResolutionX-2);
  int gridY = floor((float)mouseY/tileSize) + 1;
  gridY = constrain(gridY, 1, gridResolutionY-2);
  tiles[gridX][gridY] = '1';
}

void unsetTile() {
  int gridX = floor((float)mouseX/tileSize) + 1;
  gridX = constrain(gridX, 1, gridResolutionX-2);
  int gridY = floor((float)mouseY/tileSize) + 1;
  gridY = constrain(gridY, 1, gridResolutionY-2);
  tiles[gridX][gridY] = '0';
}

void drawGrid() {
  chptr4.rectMode(CENTER);
  for (int gridY=0; gridY< gridResolutionY; gridY++) {
    for (int gridX=0; gridX< gridResolutionX; gridX++) {  
      float posX = tileSize*gridX - tileSize/2;
      float posY = tileSize*gridY - tileSize/2;
      chptr4.strokeWeight(0.15);
      chptr4.fill(255);
      if (debugMode) {
        if (tiles[gridX][gridY] == '1') chptr4.fill(220);
      }
      chptr4.rect(posX, posY, tileSize, tileSize);
    }
  }
}

void drawModules() {
  chptr4.imageMode(CENTER);
  for (int gridY=1; gridY< gridResolutionY-1; gridY++) {  
    for (int gridX=1; gridX< gridResolutionX-1; gridX++) { 
      // check the four neighbours, each can be 0 or 1
      String east = str(tiles[gridX+1][gridY]);
      String south = str(tiles[gridX][gridY+1]);
      String west = str(tiles[gridX-1][gridY]);
      String north = str(tiles[gridX][gridY-1]);
      // create a binary result out of it, eg. 1011
      String binaryResult = north + west + south + east;
      // convert the binary string to a decimal value from 0-15
      int decimalResult = unbinary(binaryResult);
      
      float posX = tileSize*gridX - tileSize/2;
      float posY = tileSize*gridY - tileSize/2;
      
      if(decimalResult == 15)
        decimalResult = 16;
      
      // use only active tiles
      if (tiles[gridX][gridY] == '1') {  
        // decimalResult is the also the index for the shape array
        //chptr4.tint(50, 200);
        chptr4.image(modules[decimalResult],posX, posY, tileSize, tileSize);
      }
    }
  }
}

void updateGrid() {
  for(int i = 0; i < 1024; i++){
    float amp = in.left.get(i)*10;
    if(amp > 0.5)
    {
      tiles[int(random(1,gridResolutionX-1))][int(random(1,gridResolutionY-1))] = '0';
    }
    else if(amp < -0.5)
    {
      tiles[int(random(1,gridResolutionX-1))][int(random(1,gridResolutionY-1))] = '1';
    }
  }
}


void keyReleased() {

  if (key == DELETE || key == BACKSPACE) initTiles();
  if (key == 'g' || key == 'G') drawGrid = !drawGrid;
  if (key == 'd' || key == 'D') debugMode = !debugMode;
}