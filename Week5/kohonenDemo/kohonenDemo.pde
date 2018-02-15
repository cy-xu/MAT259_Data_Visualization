/*
Demo created by Mike Godwin for M259 class in 2006
http://www.mat.ucsb.edu/~g.legrady/academic/courses/06w259/projs/mg/KohonenSpectrum/

The project begins by generating a set of random colors which are featured on the right side. When the program runs
the left area shows the iterative application of the kohonen algorithm to eventually reach a state
of relative proximity for each of the random sample colors on the right. These are represented by the dots in the
left sketch. 

Colors are a good example as they have 3 attributes: r,g,b

For a semantic ordering, a csv table would need to be created with a number of attributes, the more the better.
This table would then be read using values by which to order the items in the table. 
For instance if fruits were to be organized, each fruit could have attribute values for shape, color, size, 
texture, region, etc. Any system can work as long as the assigned values are numeric. For colors, there can be
a system where red=1, orange=2, yellow=3, green=4....there can also be boolean values pos=1, neg=0, etc.
A column with labels should be added and these could be positioned on top of the map once it completes 
its organization. 
*/
import java.util.*;

KohonenSet klist = new KohonenSet();

float colorList[][]; // each single item
int numColors = 200; // input numb

void setup(){
  noStroke();
  size(660,500);
  createColorList();
  klist.kset = colorList;
  klist.initWeights(50, 50, 3); // first two for n * m grid, last one for attributes
  ellipseMode(CENTER);
}

void draw(){
  background(230);
  if(klist.mapMode == 0) klist.map();
  if(klist.mapMode == 1) klist.errorMap();
  klist.legend();
  klist.bmuLabels();
  klist.train();
}

void createColorList(){
  colorList = new float[numColors][3];
  for (int i=0; i<numColors; i++){
    for (int j=0; j<3; j++){
      colorList[i][j] = random(255);
    }
  }
}

void keyReleased(){
  if (key == '=') klist.mapMode = 0;
  if (key == '-') klist.mapMode = 1;
}