float _w, _h;
PFont font;
PImage mat_logo;
PImage marcos;

void setup()
{
  fullScreen(P2D, 2);
  //size(1280,720,P2D);
  
  _w = width * 0.2;
  _h = height;
  
  initFX();

  initChptr2();
  initChptr1();
  initChptr3();
  initChptr4(); 
  
  chptr1.smooth();
  chptr2.smooth();
  chptr3.smooth();
  chptr4.smooth();
  
  initializeSphere(resolutionX, resolutionY);
  
  marcos = loadImage("marcos.png");
  mat_logo = loadImage("logo.png");
  
  font = createFont("AVGARDD.TTF", 200);
  textFont(font);
  
  noStroke();
}

void draw(){
  background(0);
  
  /*
    PART 1: Visual
  */
  fill(current_color+20);
  rect(0,0,_w,_h);
  drawChptr1();
  image(chptr1, 0, 0);
  
  /*
    PART 2: Audio
  */
  fill(current_color+15);
  rect(_w,0,_w,_h);
  drawChptr2();
  image(chptr2, _w, 0);

  
  /*
    PART 3: Conceptual
  */
  fill(current_color+10);
  rect(2*_w,0,_w,_h);
  drawChptr3();
  image(chptr3, 2*_w, 0);
  
  /*
    PART 4: Hardware/Software
  */
  fill(current_color+5);
  rect(3*_w,0,_w,_h); 
  drawChptr4();
  image(chptr4, 3*_w, 0);
  
  drawFX();
  
  if(isCentered == 0)
    drawTitleOnSides(true);
  else if(isCentered == 1)
    drawTitleOnCenter(true, true);
  else if(isCentered == 2)
    drawTitleMarkosNovak(true);
    
  updateFX();
}