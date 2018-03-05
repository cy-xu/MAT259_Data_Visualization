
void DefColors() {
    StrokeCT = new color[4];
    StrokeCT[0] = color(255,255,255, 128);
    StrokeCT[1] = color(255,255,255, 128);
    StrokeCT[2] = color(255,255,255, 128);
    StrokeCT[3] = color(255,255,255, 128);
    CT = new color[4];
    CT[0] = #98DBC6;//color(239, 11, 221, 255);
    CT[1] = #A2C523;//color(26, 44, 239, 255);
    CT[2] = #60779E;//color(32, 232, 92, 255);
    CT[3] = #4CB5F5;//color(0,255,255, 255);
    
    LableColor = new color[4];
    LableColor[0] = #98DBC6;
    LableColor[1] = #A2C523;
    LableColor[2] = #60779E;
    LableColor[3] = #4CB5F5;
    
    CSubT = new color[4][4];
    CSubT[0][0] = #98DBC6;//color(239, 11, 221, 255);
    CSubT[0][1] = #5BC8AC;//color(239, 11, 110, 255);
    CSubT[0][2] = #6AB187;//color(110, 11, 221, 255);
    CSubT[0][3] = #20948B;//color(150, 11, 150, 255);
    
    CSubT[1][0] = #A2C523;//color(26, 44, 239, 255);
    CSubT[1][1] = #598234;//color(122, 94, 224, 255);
    CSubT[1][2] = #486B00;//color(86, 185, 221, 255);
    CSubT[1][3] = #2E4600;//color(38, 217, 226, 255);
    
    CSubT[2][0] = #60779E;//color(32, 232, 92, 255);
    CSubT[2][1] = #98DBC6;//color(133, 232, 95, 255);
    CSubT[2][2] = #5BCA8C;//color(44, 224, 137, 255);
    CSubT[2][3] = #7DA3A1;//color(26, 119, 37,255);
    
    CSubT[3][0] = #4CB5F5;//color(0,64,64,255);
    CSubT[3][1] = #A1D6E2;//color(0,128,128,255);
    CSubT[3][2] = #1995AD;//color(0,192,192,255);
    CSubT[3][3] = #34888c;//color(0,255,255,255);
    
    PT = new color[4];
    PT[0] = #F0810F;
    PT[1] = #EC96A4;
    PT[2] = #BA5536;
    PT[3] = #FF420E;
  }
  
color heatColorMap(float val) {
  if (val > 1.0) {
    val = 1.0;
  }
  if (val < 0) {
    val = 0;
  }
  color c = color(0,0,0);
  color c0 = color(0,0,255); // blue - 0
  color c1 = color(0,255,255); // cyan - 0.25
  color c2 = color(0,255,0); // green - 0.5
  color c3 = color(240,240,0); // yellow - 0.75
  color c4 = color(255,0,0); // Red - 1.0
  if (val >= 0 && val <= 0.25) {
    c = lerpColor(c0, c1, val*4.0);
  } else if (val > 0.25 && val <= 0.5) {
    c = lerpColor(c1, c2, val*4.0 - 1.0);
  } else if (val > 0.5 && val <= 0.75) {
    c = lerpColor(c2,c3,val*4.0 - 2.0);
  } else if (val > 0.75 && val <= 1.0) {
    c = lerpColor(c3,c4,val*4.0 - 3.0);
  } else {
    c = c4;
  }
  return c;
}