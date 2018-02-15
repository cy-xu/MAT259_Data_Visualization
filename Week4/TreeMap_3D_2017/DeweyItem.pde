//DeweyItem class visually controls each single dewey category

class DeweyItem extends SimpleMapItem { 
  String dewey;
  float deweyColor;
  
  DeweyItem(String dewey){
    this.dewey = dewey;
    deweyColor = int(dewey);
  }
    
  void draw(){
    //It controls colors of the tree map layers
    colorMode(HSB);
    stroke(50,100);
    if(deweyColor != selectedDewey) fill(map(deweyColor, 0, 990, 0, 255), 255/2, 255/2, TRANS);
    else fill(map(deweyColor, 0, 990, 0, 255), 255/2, 255, TRANS*3);
    rect(x, y, w, h);
  }
}