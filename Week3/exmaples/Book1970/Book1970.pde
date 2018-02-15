//Needs to be done:
//1.Color Scheme
//2.Fade out animation
//3.Use keywords for the bottom

Table table;
int numRows, numCols;
float[] times;
String[] titles;
float[] dewey;
String[] deweyType;

float xPos = -580;
float yPos = 0;
float[] xPositions;

boolean mouseOn = false;
int arcNum;

void setup() {
  size(1280,800);
  background(230);
  colorMode(HSB,900);
  
  table = loadTable("1970Arc.csv");
  numRows = table.getRowCount();
  numCols = table.getColumnCount();
  
  times = new float[numRows];
  xPositions = new float[numRows];
  titles = new String[numRows];
  dewey = new float[numRows];
  deweyType = new String[10];
  
  for(int i=0; i<numRows-1;i++){
    //times
    times[i] = float(table.getInt(i+1,0));
    times[i] = times[i]*1.2;
    if(i == 0){
       xPos = xPos;
    }
    else{
      xPos += (times[i] + times[i-1])/2;
    }
    xPositions[i] = xPos;
    
    //title
    titles[i] = table.getString(numRows-1-i,2);
    
    //dewey
    dewey[i] = table.getFloat(numRows-1-i,1);
  }       
        
  for(int i=0;i<10;i++){      
        if(i == 9){
          deweyType[i] = "History & Geography";
        }
        if(i == 8){
          deweyType[i] = "Literature";
        }
        if(i == 7){
          deweyType[i] = "Arts & Recreation";
        }
        if(i == 6){
          deweyType[i] = "Technology";
        }
        if(i == 5){
          deweyType[i] = "Pure Science";
        }
        if(i == 4){
          deweyType[i] = "Language";
        }
        if(i == 3){
          deweyType[i] = "Social Sciences";
        }
        if(i == 2){
          deweyType[i] = "Religion";
        }
        if(i == 1){
          deweyType[i] = "Philosophy and Psychology";
        }
        if(i == 0){
          deweyType[i] = "General, CS & Info";
        }
  }
}

void draw(){
  background(800);
  
  translate(width/2, height/2+200);
  
  //draw texts and lines on the left side
  for(int i=0; i<10; i++){
    stroke(100*i,450,450,900);
    strokeWeight(2); 
    fill(0);
    textSize(10); 
    textAlign(LEFT);  
    if(!mouseOn){
      line(-width/2,-height/2-180+20*i,-width/2+30,-height/2-180+20*i);
      text(deweyType[i],-width/2+35,-height/2-178+20*i);
    }
    if(mouseOn && i == int(dewey[arcNum]/100)){
      line(-width/2,-height/2-180+20*int(dewey[arcNum]/100),
           -width/2+30,-height/2-180+20*int(dewey[arcNum]/100));
      line(-width/2+70,-height/2-160+20*int(dewey[arcNum]/100),
           -width/2+70,-height/2-170+20*int(dewey[arcNum]/100));
      text(deweyType[int(dewey[arcNum]/100)],-width/2+35,-height/2-178+20*int(dewey[arcNum]/100));
    }
  }
  //draw texts and lines on the left side
    
  strokeWeight(1);
  for(int i=0; i<numRows-1;i++){   
    
    //draw titles on the bottom and left side
    if(i == arcNum && mouseOn){
      pushMatrix();
      fill(0);
      textSize(10);
      textAlign(LEFT);
      text("\"" + titles[i] + "\"",-width/2+60, -height/2-150+20*int(dewey[arcNum]/100));
      popMatrix();
    }
    else{
      pushMatrix();
      rotate(PI*3/2);
      translate(-5,0);
      textAlign(RIGHT);
      fill(0);
      textSize(3);
      text(titles[i],yPos, xPositions[i]);
      popMatrix(); 
    }
    //draw titles on the bottom and left side
    
    //draw arcs
    for(int j=0; j<numRows-1;j++){
      if(dewey[i] == dewey[j]){
        noFill();
        stroke(dewey[j],450,450,200);
        if(mouseOn && j == arcNum){
          arc((xPositions[i]+xPositions[j])/2, yPos, dist(xPositions[i],yPos,xPositions[j],yPos),
               dist(xPositions[i],yPos,xPositions[j],yPos),PI,PI*2);
        }
        
        if(!mouseOn && i>j){
          arc((xPositions[i]+xPositions[j])/2, yPos, dist(xPositions[i],yPos,xPositions[j],yPos),
               dist(xPositions[i],yPos,xPositions[j],yPos),PI,PI*2);
        }
      }
    }
    //draw arcs
  } 
  
  //draw cricles
  for(int i=0; i<numRows-1;i++){ 

    fill(900);
    stroke(0,100);
    ellipse(xPositions[i], yPos, times[i],times[i]);
        
    if(dist(mouseX-width/2,mouseY-height/2-200,xPositions[i],yPos)<times[i]/2){
      mouseOn = true;
      arcNum = i;
    }
  }
    //assign dewey color to selected circles
  for(int i=0; i<numRows-1;i++){ 
    //assign dewey color to selected circles
      for(int j=0; j<numRows-1;j++){
        if(mouseOn && dewey[i] == dewey[j] && i == arcNum){       
           fill(dewey[j],450,450,200);
           ellipse(xPositions[j], yPos, times[j],times[j]);
        }
      }
    //assign dewey color to selected circles
  }
  //draw cricles
  
  if(mousePressed){
    mouseOn = false;
  } 
}

void keyPressed(){
  if(key == 's'){
    saveFrame("screens/screen-#####.png");
  }
}


  

