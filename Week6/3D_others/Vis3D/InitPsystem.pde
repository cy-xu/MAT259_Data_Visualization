void AllInit() {
  float ptlScaleFactor = 0.5;
  for (int i = 0; i < cellNumX; i++) {
    for (int j = 0; j < cellNumY; j++) {
      int pt1 = int(AllCheckPerMonth[4][j+i*cellNumY] * ptlScaleFactor);
      int pt2 = int(AllCheckPerMonth[9][j+i*cellNumY] * ptlScaleFactor);
      int pt3 = int(AllCheckPerMonth[14][j+i*cellNumY] * ptlScaleFactor);
      int pt4 = int(AllCheckPerMonth[19][j+i*cellNumY] * ptlScaleFactor);
      IntList IntListCur1 = new IntList();
      IntList IntListCur2 = new IntList();
      IntList IntListCur3 = new IntList();
      IntList IntListCur4 = new IntList();
      IntListCur1.append(checkTimeAll[0].lists_[0][j+i*cellNumY]);
      IntListCur1.append(checkTimeAll[0].lists_[1][j+i*cellNumY]);
      IntListCur1.append(checkTimeAll[0].lists_[2][j+i*cellNumY]);
      IntListCur1.append(checkTimeAll[0].lists_[3][j+i*cellNumY]);
      IntListCur2.append(checkTimeAll[1].lists_[0][j+i*cellNumY]);
      IntListCur2.append(checkTimeAll[1].lists_[1][j+i*cellNumY]);
      IntListCur2.append(checkTimeAll[1].lists_[2][j+i*cellNumY]);
      IntListCur2.append(checkTimeAll[1].lists_[3][j+i*cellNumY]);
      
      IntListCur3.append(checkTimeAll[2].lists_[0][j+i*cellNumY]);
      IntListCur3.append(checkTimeAll[2].lists_[1][j+i*cellNumY]);
      IntListCur3.append(checkTimeAll[2].lists_[2][j+i*cellNumY]);
      IntListCur3.append(checkTimeAll[2].lists_[3][j+i*cellNumY]);
      
      IntListCur4.append(checkTimeAll[3].lists_[0][j+i*cellNumY]);
      IntListCur4.append(checkTimeAll[3].lists_[1][j+i*cellNumY]);
      IntListCur4.append(checkTimeAll[3].lists_[2][j+i*cellNumY]);
      IntListCur4.append(checkTimeAll[3].lists_[3][j+i*cellNumY]);
      
      psystems1[i][j] = new Psysem(pt1, cellSizeX*0.5 + cellSizeX*i, yGroundPos, cellSizeY*0.5 + cellSizeY*j,
          cellSizeX,cellSizeY, IntListCur1, PT[0]);
          
      psystems2[i][j] = new Psysem(pt2, cellSizeX*0.5 + cellSizeX*i - groundPlaneSizeX, yGroundPos, cellSizeY*0.5 + cellSizeY*j,
          cellSizeX,cellSizeY, IntListCur2, PT[1]);
          
      psystems3[i][j] = new Psysem(pt3, cellSizeX*0.5 + cellSizeX*i - groundPlaneSizeX, yGroundPos,
          cellSizeY*0.5 + cellSizeY*j - groundPlaneSizeY,
          cellSizeX,cellSizeY, IntListCur3, PT[2]);
          
      psystems4[i][j] = new Psysem(pt4, cellSizeX*0.5 + cellSizeX*i, yGroundPos, cellSizeY*0.5 + cellSizeY*j - groundPlaneSizeY,
          cellSizeX,cellSizeY, IntListCur4, PT[3]);
    }
  }
  
  labelText[0] = "Drama";
  labelText[1] = "Fantasy";
  labelText[2] = "History";
  labelText[3] = "Scifi";
}

void InitOne(int [] csvIdx, int CheckTimeIdx) {
  float ptlScaleFactor = 1.0;
  for (int i = 0; i < cellNumX; i++) {
    for (int j = 0; j < cellNumY; j++) {
      int pt1 = int(AllCheckPerMonth[csvIdx[0]][j+i*cellNumY] * ptlScaleFactor);
      int pt2 = int(AllCheckPerMonth[csvIdx[1]][j+i*cellNumY] * ptlScaleFactor);
      int pt3 = int(AllCheckPerMonth[csvIdx[2]][j+i*cellNumY] * ptlScaleFactor);
      int pt4 = int(AllCheckPerMonth[csvIdx[3]][j+i*cellNumY] * ptlScaleFactor);
      IntList IntListCur1 = new IntList();
      IntList IntListCur2 = new IntList();
      IntList IntListCur3 = new IntList();
      IntList IntListCur4 = new IntList();
      IntListCur1.append(checkTimeAll[CheckTimeIdx].lists_[0][j+i*cellNumY]);
      IntListCur2.append(checkTimeAll[CheckTimeIdx].lists_[1][j+i*cellNumY]);
      IntListCur3.append(checkTimeAll[CheckTimeIdx].lists_[2][j+i*cellNumY]); 
      IntListCur4.append(checkTimeAll[CheckTimeIdx].lists_[3][j+i*cellNumY]);

      psystems1[i][j] = new Psysem(pt1, cellSizeX*0.5 + cellSizeX*i, yGroundPos, cellSizeY*0.5 + cellSizeY*j,
          cellSizeX,cellSizeY, IntListCur1, PT[0]);
          
      psystems2[i][j] = new Psysem(pt2, cellSizeX*0.5 + cellSizeX*i - groundPlaneSizeX, yGroundPos, cellSizeY*0.5 + cellSizeY*j,
          cellSizeX,cellSizeY, IntListCur2, PT[1]);
          
      psystems3[i][j] = new Psysem(pt3, cellSizeX*0.5 + cellSizeX*i - groundPlaneSizeX, yGroundPos,
          cellSizeY*0.5 + cellSizeY*j - groundPlaneSizeY,
          cellSizeX,cellSizeY, IntListCur3, PT[2]);
          
      psystems4[i][j] = new Psysem(pt4, cellSizeX*0.5 + cellSizeX*i, yGroundPos, cellSizeY*0.5 + cellSizeY*j - groundPlaneSizeY,
          cellSizeX,cellSizeY, IntListCur4, PT[3]);
    }
  }
}

void InitDrama() {
  int [] csvIdx = {0,1,2,3};
  int CheckTimeIdx = 0;
  InitOne(csvIdx, CheckTimeIdx);
  labelText[0] = "American hustle";
  labelText[1] = "Grand Budapest Hotel";
  labelText[2] = "Great Gatsby";
  labelText[3] = "Silver Linings Playbook";
}

void InitFantasy() {
  int [] csvIdx = {5,6,7,8};
  int CheckTimeIdx = 1;
  InitOne(csvIdx, CheckTimeIdx);
  labelText[0] = "Cinderella";
  labelText[1] = "Descendants";
  labelText[2] = "Frozen";
  labelText[3] = "Into the Woods";
}

void InitHistory() {
  int [] csvIdx = {10,11,12,13};
  int CheckTimeIdx = 2;
  InitOne(csvIdx, CheckTimeIdx);
  labelText[0] = "12 Years a Slave";
  labelText[1] = "Imitation Game";
  labelText[2] = "Kings Speech";
  labelText[3] = "Lincoln";
}

void InitScifi() {
  int [] csvIdx = {15,16,17,18};
  int CheckTimeIdx = 3;
  InitOne(csvIdx, CheckTimeIdx);
    labelText[0] = "Gravity";
  labelText[1] = "Hunger Games";
  labelText[2] = "Interstellar";
  labelText[3] = "Star Trek into Darkness";
}