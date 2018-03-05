
void drawRects(color C, color StrokeC, float Xpos, float Ypos, int cellNumX, int  cellNumY, 
              float YS, float cellSizeX, float cellSizeY) {
  pushMatrix();
  translate(0,yGroundPos,0);
  rotateX(PI/2.0);
  fill(C);
  stroke(StrokeC);
  //rect(planceSize*0.5,planceSize*0.5,planceSize,planceSize);
  // float halfCellX = cellSizeX * 0.5;
  // Xpos = halfCellX - (planceSize)*scaleFactor;
  //float YS = halfCellY - (planceSize)*scaleFactor;
  Ypos = YS;
 
  for (int i=0; i < cellNumX; i++) {
    for (int j=0; j < cellNumY; j++) {
      rect(Xpos, Ypos, cellSizeX, cellSizeY);
      Ypos += cellSizeY;
    }
    Ypos = YS;
    Xpos += cellSizeX;
  }
  popMatrix();
}

void drawGround(int cellNumX, int cellNumY, float planeSizeX, float planeSizeY, boolean fade, int ufadeIdx, float fadeFrame) {
  
  float cellSizeX = planeSizeX / cellNumX;
  float cellSizeY = planeSizeY / cellNumY;
  float halfCellX = cellSizeX*0.5;
  float halfCellY = cellSizeY*0.5;
 
  boolean drawWhole = false;
  
    color [] StrokeC = new color[4];
    StrokeC[0] = StrokeCT[0];
    StrokeC[1] = StrokeCT[1];
    StrokeC[2] = StrokeCT[2];
    StrokeC[3] = StrokeCT[3];
    color [] C = new color[4];
    C[0] = CT[0];
    C[1] = CT[1];
    C[2] = CT[2];
    C[3] = CT[3];
    color [][] CSub = new color[4][4];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        CSub[i][j] = CSubT[i][j];
      }
    }

  float scaleFactor = 0.0;
  float fadeInFactor = 0.0;
  float eachStageFrame = fadeFrame / 3.0;
  float eachStageBack = fadeFrame * 0.5;
  boolean [] Draw = {true, true, true, true};
  
  if (fade) {
    if (fadeCounter <= eachStageFrame) {
      for (int i = 0; i < 4; i++) {
        if (i != ufadeIdx) {
          float fadeVal = (float)(fadeCounter) / eachStageFrame;
          C[i] = lerpColor(C[i], backGroundColor, fadeVal);
          StrokeC[i] = lerpColor(StrokeC[i], backGroundColor, fadeVal);
          if (fadeVal > 1.0) {
            fadeVal = 1.0;
            Draw[i] = false;
          }
        }
      }
    }
    if (fadeCounter > eachStageFrame && fadeCounter <= 2*eachStageFrame) {
      for (int i = 0; i < 4; i++)
        if (i!= ufadeIdx) Draw[i] = false;
      scaleFactor = (fadeCounter - eachStageFrame) / eachStageFrame;
      if (scaleFactor > 1.0)
          scaleFactor = 1.0;
      cellSizeX *= (1.0 + scaleFactor);
      cellSizeY *= (1.0 + scaleFactor);
      halfCellX *= (1.0 + scaleFactor);
      halfCellY *= (1.0 + scaleFactor);
    }
    
    if (fadeCounter > 2*eachStageFrame) {
      fadeInFactor = (fadeCounter - 2*eachStageFrame) / eachStageFrame;
      if (fadeInFactor > 1.0)
        fadeInFactor = 1.0;
        Draw[0] = true;
        Draw[1] = true;
        Draw[2] = true;
        Draw[3] = true;
        drawWhole = false;
       for (int i = 0; i < 4; i++) {
         C[i] = lerpColor(C[ufadeIdx],CSub[ufadeIdx][i],fadeInFactor);
         StrokeC[i] = lerpColor(C[ufadeIdx],StrokeC[i], fadeInFactor);
       }
    }
    if (fadeCounter <= 3*eachStageFrame) {
      fadeCounter ++;
    }
    if (fadeCounter > 3*eachStageFrame) {
      inTransit = false;
    }
    
    stage = ufadeIdx;
  }
  
  if (!fade && stage != -1) {
    //fadeCounter = 
    if (fadeCounter <= eachStageFrame) {
      float fadeVal = (float)(fadeCounter) / eachStageFrame;
      for (int i = 0; i < 4; i++) {
        C[i] = lerpColor(CSub[ufadeIdx][i], C[ufadeIdx], fadeVal);
        //StrokeC[i] = lerpColor(StrokeC[i], C[ufadeIdx], fadeVal);
        if (fadeVal > 1.0) {
          fadeVal = 1.0;
         }
        }
    }
    if ( fadeCounter > eachStageFrame && fadeCounter <= eachStageFrame*2.0 ) {
      drawWhole = true;
      for (int i = 0; i < 4; i++)
       Draw[i] = false;
      
      scaleFactor = (fadeCounter - eachStageFrame) / eachStageFrame; // 0 - 1
      if (scaleFactor > 1.0)
          scaleFactor = 1.0;
      StrokeC[ufadeIdx] = lerpColor(StrokeC[ufadeIdx],C[ufadeIdx], scaleFactor);
      cellSizeX *= (1.0 - scaleFactor*0.5);
      cellSizeY *= (1.0 - scaleFactor*0.5);
      
      halfCellX *= (1.0 - scaleFactor*0.5);
      halfCellY *= (1.0 - scaleFactor*0.5);
    }
    if (fadeCounter > 2*eachStageFrame) {
      fadeInFactor = (fadeCounter - 2*eachStageFrame) / eachStageFrame;
      for (int i = 0; i < 4; i++) Draw[i] = true;
      if (fadeInFactor > 1.0)
        fadeInFactor = 1.0;
      for (int i = 0; i < 4; i++) {
        if (i != ufadeIdx) {
          C[i] = lerpColor(backGroundColor, C[i], fadeInFactor);
          StrokeC[i] = lerpColor(backGroundColor, StrokeC[i], fadeInFactor);
        }
      }
       
    }    
    if (fadeCounter <= 3*eachStageFrame) {
      fadeCounter ++;
    }
    if (fadeCounter > 3*eachStageFrame) {
      inTransit = false;
    }
  }

  float Xpos = halfCellX;
  float Ypos = halfCellY;
  
  rectMode(CENTER);
  if (drawWhole) {
    float YS = 0;
    if (ufadeIdx == 0) {
      Xpos = halfCellX - planeSizeX * (1 - scaleFactor);
      YS = halfCellY -  planeSizeY * (1 - scaleFactor);
      Ypos = YS;
    }
    if (ufadeIdx == 1) {
      Xpos = -planeSizeX + halfCellX;
      YS = halfCellY - (planeSizeY)*(1 - scaleFactor);
      Ypos = YS;
    }
    if (ufadeIdx == 2) {
      Xpos = -planeSizeX + halfCellX;
      YS =  -planeSizeY + halfCellY;
      Ypos = YS;
    }
    if (ufadeIdx == 3) {
      Xpos = halfCellX - (planeSizeX)*(1 -  scaleFactor);
      YS =  -planeSizeY + halfCellY;
      Ypos = YS;
    }
    color Ct = C[ufadeIdx];
    color CSt = StrokeC[ufadeIdx];
    drawRects(Ct, CSt, Xpos, Ypos, cellNumX*2, cellNumY*2, YS, cellSizeX, cellSizeY);
  }
  
  if (Draw[0]) {
    Xpos = halfCellX - (planeSizeX)*scaleFactor;
    float YS = halfCellY - (planeSizeY)*scaleFactor;
    Ypos = YS;
    drawRects(C[0], StrokeC[0], Xpos, Ypos, cellNumX, cellNumY, YS, cellSizeX, cellSizeY);
  }
  
  if (Draw[1]) {
    Xpos = -planeSizeX + halfCellX;
    float YS = halfCellY - (planeSizeY)*scaleFactor;
    Ypos = YS;
    drawRects(C[1], StrokeC[1], Xpos, Ypos, cellNumX, cellNumY, YS, cellSizeX, cellSizeY);
  }

  if (Draw[2]) {
    Xpos = -planeSizeX + halfCellX;
    float YS =  -planeSizeY + halfCellY;
    Ypos = YS;
    drawRects(C[2], StrokeC[2], Xpos, Ypos, cellNumX, cellNumY, YS, cellSizeX, cellSizeY);
  }
  
  if (Draw[3]) {
    Xpos = halfCellX - (planeSizeX)*scaleFactor;
    float YS =  -planeSizeY + halfCellY;
    Ypos = YS;
    drawRects(C[3], StrokeC[3], Xpos, Ypos, cellNumX, cellNumY, YS, cellSizeX, cellSizeY);
  }
}