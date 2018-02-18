PGraphics chptr3;

int size;
String[]  part_names;
PVector[] pos;

void initChptr3() {
  chptr3 = createGraphics((int)_w, (int)_h, P3D);
  
  part_names = loadStrings("labels.txt");
  
  size = part_names.length;
  pos = new PVector[size];
  
  for (int i = 0; i < size; i++){
    pos[i] = new PVector(random(-_w*0.5, _w*0.5), random(-_h/2, _h/2), random(-_w/4, _w/4));
  }
}

void drawChptr3(){
  chptr3.beginDraw();
  chptr3.textAlign(CENTER,CENTER);
  chptr3.background(0,0);
  chptr3.fill(180, 150);
  chptr3.translate(_w/2., _h/2., 0);
  for(int i = 0; i < size; i++){
    if(part_names != null && part_names[i] != null){
      chptr3.pushMatrix();
      chptr3.translate(pos[i].x,pos[i].y,pos[i].z);
      chptr3.textFont(font, 13);
      chptr3.text(part_names[i],0,0,0);
      chptr3.popMatrix();
    }
  }
  
  updatePositions();
  
  chptr3.endDraw();
}

void updatePositions(){
  for (int i = 0; i < size; i++){
    float off = abs(in.left.get(i)*10);
    pos[i].add(new PVector(random(-off,off),random(-off,off),0));
  }
}