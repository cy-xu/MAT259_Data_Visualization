public class Arrow {
  float cc_x1, cc_y1, cc_z1, cc_x2, cc_y2, cc_z2;
 
  public Arrow (float x1, float y1,float z1, float x2, float y2,float z2) {
    cc_x1 = x1;
    cc_y1 = y1;
    cc_z1 = z1;
    cc_x2 = x2;
    cc_y2 = y2;
    cc_z2 = z2;
  }
 
  public void drawarrow(int rotateAxis) {
    
    
   stroke(255,255,255);
   line(cc_x1,cc_y1,cc_z1,cc_x2,cc_y2,cc_z2);
  //;
    pushMatrix();
    if (rotateAxis == 0) {
     rotateX(PI/2);
    } else if (rotateAxis == 1) {
     // rotateY(PI/2);
    }
    translate(cc_x2, cc_y2);
    float a = atan2(cc_x1-cc_x2, cc_y2-cc_y1);
    stroke(255,255,255);
    rotate(a);  
    line(0, 0,cc_z1, -3.25, -3.25,cc_z2);
    line(0, 0,cc_z1, 3.25, -3.25,cc_z2);
    popMatrix();
  }
}