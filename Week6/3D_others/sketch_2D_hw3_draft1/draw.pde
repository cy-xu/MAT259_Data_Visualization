void draw() { 
        frameRate(60);
        background(0);
        fill(255);
        box(10);
        staticText();
        
        if (sectorFlag) {
            for (int sectorNumber=0 ; sectorNumber< sectors; sectorNumber++)
                {
                  if (circleFlag) {
                    drawCircles(sectorNumber + 10);
                  }
                  if (arcFlag) {
                    drawArc(sectorNumber + 10);
                  }
                  displayDates(sectorNumber);
                }
            }

        for (int pl=0; pl< noPL;pl++) { 
            for (int i=0; i< tableLength[pl];i++) {
               
                 stroke(pl*60+60,Saturation,Brightness,160);
                 strokeWeight(1);
                 noFill();  
                 if (randomFlag) {
                   stroke(250,150);  
                   ellipse(cinPositionsTable[pl][i][0], cinPositionsTable[pl][i][1], radius * (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6, (radius * (cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6));
                 }
               
                 if(pythonFlag && pl==0) {
                   stroke(#FF6363,150);  //watermelon red
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/3,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/3,
                         coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                   
                   endShape();
                   
                   /*bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                   */
                        
                   }
                 if(algorithmFlag && pl==1)  //green 
                   {
                   stroke(#63FF63,150);
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                   
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                  
                    endShape();

                   /*
                   bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                  */
                   }               
                 if(dataMiningFlag && pl==2) {     //light blue
                   stroke(#63FFFF,150);
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                   
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
              
                    endShape();
                       
                       /*bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                      */
                     } 
                 if(machineLearningFlag && pl==3) { //purple
                  
                   stroke(#6363FF,150);
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                          
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                   
                   
                    endShape();
                   /*bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                   */
                   } 
                 if(operatingSystemFlag && pl==4) { //peach pink
               
                   stroke(#FF63FF,150);
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                    endShape();
                   /*bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);  */
                   } 
                 if(aiFlag && pl==5) {  //yellow
                   
                   stroke(#FFB163,150);
                   beginShape();
                   vertex(-20, -30, 2500);
                   bezierVertex((cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); 
                          
                   bezierVertex(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                             (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]);
                    endShape();
                   
                   /*bezier(cinPositionsTable[pl][i][0],cinPositionsTable[pl][i][1],cinPositionsTable[pl][i][2],
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                         (cinPositionsTable[pl][i][0]+coutPositionsTable[pl][i][0])/6,(cinPositionsTable[pl][i][1]+coutPositionsTable[pl][i][1])/6,(cinPositionsTable[pl][i][2]+coutPositionsTable[pl][i][2])/1.78,
                          coutPositionsTable[pl][i][0],coutPositionsTable[pl][i][1],coutPositionsTable[pl][i][2]); */
                   }
                }
            }   
      }