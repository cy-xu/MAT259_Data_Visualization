void staticText()
      {
      cam.beginHUD();
      position= cam.getPosition();
      textSize(22);
      //background(0,0,0,100);
      background(#383838);
      textAlign(LEFT,BASELINE);
      fill(209,61,100,250);
      text("MAT259 HW3 | April Cai | Winter 2018",20,80);
      text("How AI is Raising",20,40 );
      text("3D Interactive Visualization",20,60 );
      text("The visualization shows the relationship between the checkin and checkouts of AI related \nprogramming languages in the Seattle Public Library. The data is for 12 years from 2005-2017",20,100); 
      
      //text("Camera Position  X: " + position[0]+" Y: "+ position[1]+ " Z: "+ position[2],20,160);
      //text("framerate " + frameRate +" fps" ,20,180);
      fill(#FF6363); 
      text("Python | press p ", 20, 200); 
      fill(#63FF63);
      text("Algorithm | press a", 20, 220);
      fill(#63FFFF);
      text("Data Mining | press d", 20, 240);
      fill(#6363FF);
      text("Machine Learning | press m", 20, 260);
      fill(#FF63FF);
      text("Operating System | press o", 20, 280);
      fill(#FFB163);
      text("AI | press i", 20, 300);
      fill(250);
      text("Tower Shape | press t", 20, 320);
      cam.endHUD();
      }
      