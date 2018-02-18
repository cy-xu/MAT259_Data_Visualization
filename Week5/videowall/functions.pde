
/*
  TEXT OVERLAY (on corners)
*/
void drawTitleOnSides(boolean logo){
  textSize(200);
  fill(#BF1656);
  // re
  textAlign(RIGHT, TOP);
  text("re", width-_w+4, 20);
  // habi
  textAlign(LEFT, TOP);
  text("habi", -12, _h*0.4);
  // tuation
  textAlign(LEFT, TOP);
  text("tuation", _w-28, _h*0.6);
  
  if(logo){
    imageMode(CORNER);
    noStroke();
    image(mat_logo, 10, 10);
  }
}

/*
  TEXT OVERLAY (on center)
*/
void drawTitleOnCenter(boolean subtitle, boolean logo){
  textSize(180);
  fill(#BF1656);
  // re-habituation
  textAlign(CENTER, CENTER);
  text("re-habituation", 2*_w, _h/2.);
  
  if(subtitle){
    textSize(60);
    text("Welcome", 2*_w, _h*0.18);
    textSize(50);
    text("to", 2*_w, _h*0.27);
    
    textSize(45);
    text("End of the Year Show, 2017", 2*_w, _h*0.63);
    
    textSize(30);
    text("show.mat.ucsb.edu", 2*_w, _h*0.73);
  }
  
  if(logo){
    imageMode(CENTER);noStroke();
    image(mat_logo, 2*_w, _h*0.78);
    imageMode(CORNER);
  }
}

/*
  TEXT OVERLAY (on center) -- instructions
*/
void drawTitleMarkosNovak(boolean logo){
  image(marcos, 0, 0);
  
  if(logo){
    imageMode(CORNER);
    noStroke();
    image(mat_logo, 10, 10);
  }
}