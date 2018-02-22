void displayDates(float sectorNumber)
        {
        pushMatrix();
        //rotate(sectorNumber* radians(30));
        rotate(sectorNumber* radians(30)+ 3*radians(30));
        translate(0,0,stepHeight*16+sectorNumber*stepHeight + 700);
        //textSize(40); 
        textAlign(LEFT);
        fill(Hue,Saturation,Brightness,250);
        rotateX(radians(-90));
        rotateY(radians(60));   
        //rotateZ(radians(90));      
        
        text("  " +Month[int(sectorNumber%12)] +" "+ ( 2005 + ( int (sectorNumber/12))), 1500/2, 1500/2 );
        popMatrix();
        }