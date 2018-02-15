Table overall_data;
int rows, cols;
float rowScalFactor = 0.5;
float[][] data_matrix;
float [][] display_y_delta;
int [] jlist;
String [] titles;
float [][] averageBorrowDays;

boolean move_cubicle = false;
boolean reset_Graph = false;

int which_to_move = 0;
int Baseindx = 0;

float min, max;

final int marginToLeft = 160, marginToTop = 40;
final int screenWid = 1280;
final int screenHei = 720;
int Movesteps = 100;
//Only run one time
public class cubicle {
cubicle(float cent_x, float cent_y, float w_, float h_) {
  c_x = cent_x; c_y = cent_y;
  w = w_;
  h = h_;
  delta_y = 0;
}
cubicle() {
  h = 0; w= 0; c_x = 0; c_y = 0; delta_y = 0;
}
public void move() {
  if (steps >= 0) {
    c_y += delta_y;
    steps --;
  }
}
  public float h;
  public float w;
  public float c_x;
  public float c_y;
  public int steps;
  public float delta_y;
};

cubicle [][] cubicles;

void ReadinAverageDay(int index, String fname) {
   String[] lines = loadStrings(fname);
  for (int i = 8 ; i < lines.length - 1; i++) {
    averageBorrowDays[index][ i - 8] = float(lines[i]);
  }
}

void setup() {
  size(1280, 720); // setup the size of the window
  surface.setResizable(true);
  println(hour() + ":" + minute() + ":" + second());
  overall_data = loadTable("query_result.csv", "header");
  int rows_total = overall_data.getRowCount();
  int cols_total = overall_data.getColumnCount();
  rows = rows_total - 8;
  cols = cols_total - 2;
  //println("rows: " + rows + " cols: " + cols);
  data_matrix = new float[cols][rows];
  display_y_delta = new float [cols][rows];
  jlist = new int[cols];
  max = -1; min = 99999999;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      data_matrix[i][j] = overall_data.getFloat(j + 8, i + 2);
      if (data_matrix[i][j] > max) max = data_matrix[i][j]; 
      if (data_matrix[i][j] < min) min = data_matrix[i][j]; 
    }
  }
  cubicles = new cubicle[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      cubicles[i][j] = new cubicle();
    }
  }
  InitCubiclesFromData(data_matrix, cubicles);
  
  println("rows: " + rows + "cols : " + cols);
  titles = new String[cols];
  titles[0] = "Star Trek";
  titles[1] = "Cloud Atlas";
  titles[2] = "Gravity";
  titles[3] = "Prometheus";
  averageBorrowDays = new float [cols][rows];
  ReadinAverageDay(3, "Prometheus_AveDays.txt");
  ReadinAverageDay(2, "Gravity_AveDays.txt");
  ReadinAverageDay(1, "CloudAtlas_AveDays.txt");
  ReadinAverageDay(0, "Star_treckAveDays.txt");
  float maxAveDay = -1;
  for (int j = 0; j < cols; j++) {
    for (int i = 0; i < rows; i++) {
      if (averageBorrowDays[j][i] > maxAveDay)
        maxAveDay = averageBorrowDays[j][i];
    }
  }
  
  /*for (int j = 0; j < cols; j++) {
    for (int i = 0; i < rows; i++) {
      averageBorrowDays[j][i] /= maxAveDay;
    }
  }*/
}

color heatColorMap(float val) {
  color c = color(0,0,0);
  color c0 = color(0,0,255); // blue - 0
  color c1 = color(0,255,255); // cyan - 0.25
  color c2 = color(0,255,0); // green - 0.5
  color c3 = color(240,240,0); // yellow - 0.75
  color c4 = color(255,0,0); // Red - 1.0
  if (val >= 0 && val <= 0.25) {
    c = lerpColor(c0, c1, val*4.0);
  } else if (val > 0.25 && val <= 0.5) {
    c = lerpColor(c1, c2, val*4.0 - 1.0);
  } else if (val > 0.5 && val <= 0.75) {
    c = lerpColor(c2,c3,val*4.0 - 2.0);
  } else if (val > 0.75 && val <= 1.0) {
    c = lerpColor(c3,c4,val*4.0 - 3.0);
  }
  return c;
}

void drawCubicles(cubicle [][] cubicles) {
  int l = cubicles[0].length;
  int num = cubicles.length;
  //println("Num: " + num + " cubb: : " + averageBorrowDays[0].length + " l: " + l);
  for (int i = 0; i < l; i++) {
    for (int j = 0; j < num; j++) {
      color c1Max = color(10,64,128); color c1Min = color(256, 256 , 256);
      color c2Max = color(10,128,256);
      color c3Max = color(64,128,10);
      color c4Max = color(128,64,200);
      color c = color(0,0,0);
      float aveD = averageBorrowDays[j][i] / 15;
      //if (!(aveD <= 1.0 && aveD >=0.0) ) {
        //println("aveD: " + aveD);
      //}
      if (j == 0) {
        c = lerpColor(c1Min, c1Max, aveD);
      }
      if (j == 1) {
        c = lerpColor(c1Min, c2Max, aveD);
      }
      if (j == 2) {
        c = lerpColor(c1Min, c3Max, aveD);
      }
      if (j == 3) {
        c = lerpColor(c1Min, c4Max, aveD);
      }
      
      fill(c);
      rectMode(CENTER);
      cubicle cub = cubicles[j][i];
      rect(cub.c_x, cub.c_y, cub.w, cub.h);
    }
  }
}

void InitCubiclesFromData(float [][]  data_in, cubicle[][] cubicles) {
  if (data_in.length != cubicles.length || data_in[0].length != cubicles[0].length) {
    println("Dimension does not match");
    exit();
  }
  int l = data_in[0].length;
  int num = data_in.length;
  float delta = (screenWid - marginToLeft  + 2) / l;
  for (int i = 0; i < l; i++) {
    float BASE_START = 600 + marginToTop*0.5;
    for (int j = 0; j < num; j++) {
      float h = data_in[j][i] * rowScalFactor;
      cubicles[j][i].c_x = i*delta + marginToLeft;
      cubicles[j][i].c_y = BASE_START - h*0.5;
      cubicles[j][i].w = delta;
      cubicles[j][i].h = h;
      //rect(i*delta + marginToLeft, BASE_START - h*0.5, delta, h);
      BASE_START = BASE_START - h;
    }
  }
}

void AssignSpeedCubicle(float [][] data_in) {
  int l = data_in[0].length;
  int num = data_in.length;
  float delta = (screenWid - marginToLeft  + 2) / l;

  for (int i = 0 ;i < l; i++) {
    float h = data_in[which_to_move][i] * rowScalFactor;
    color c = color(60,0,0);
      //fill(c);
      //rectMode(CENTER);
      //rect(i*delta + marginToLeft, 40 + h*0.5, delta, h);
      cubicles[which_to_move][i].delta_y = (40 + h*0.5 - cubicles[which_to_move][i].c_y) / Movesteps;
      cubicles[which_to_move][i].steps = Movesteps - 1;
  }
  for (int i = 0 ;i < l; i++) {
    float BASE_START = 600 + marginToTop*0.5;
    for (int jindx = 0; jindx < num; jindx++) {
      int j = jlist[jindx];
      if (j != which_to_move) {
        float h = data_in[j][i] * rowScalFactor;
        cubicles[j][i].delta_y = (BASE_START - h*0.5 - cubicles[j][i].c_y) / Movesteps;
        cubicles[j][i].steps = Movesteps - 1;
        BASE_START = BASE_START - h;
      }
    }
  }
}

void BuildJlist() {
  for (int j = 0, i = 1; j < cols; j++) {
    if (j != Baseindx) {
      jlist[i++] = j;
    }
  }
  jlist[0] = Baseindx;
}

void ResetSpeedCubicle(float [][] data_in) {
  int l = data_in[0].length;
  int num = data_in.length;
  BuildJlist();
  for (int i = 0 ;i < l; i++) {
    float BASE_START = 600 + marginToTop*0.5;
    for (int jidx = 0; jidx < num; jidx++) {
      int j = jlist[jidx];
      float h = data_in[j][i] * rowScalFactor;
      cubicles[j][i].delta_y = (BASE_START - h*0.5 - cubicles[j][i].c_y) / Movesteps;
      cubicles[j][i].steps = Movesteps - 1;
      BASE_START = BASE_START - h;
    }
  }
}

void keyPressed() {
  if (key == '1') which_to_move = 0;
  if (key == '2') which_to_move = 1;
  if (key == '3') which_to_move = 2;
  if (key == '4') which_to_move = 3;
  if (key == '1' || key == '2' || key == '3' || key == '4') {
    AssignSpeedCubicle(data_matrix);
    move_cubicle = true;
  }
  if (key == 'R' || key == 'r') {
    ResetSpeedCubicle(data_matrix);
    move_cubicle = true;
  }
  if (key == 's' || key == 'S') {
    Baseindx = (Baseindx + 1) % cols;
    ResetSpeedCubicle(data_matrix);
  }
}

void MoveCubicles() {
  if (move_cubicle) {
    for (int j = 0; j < cubicles.length; j++) {
      for (int i = 0; i < cubicles[0].length; i++) {
        cubicles[j][i].move();
      }
    }
  }
}

void DrawTitles() {
  fill(50);
  textSize(16);
  for (int i = 0; i < cols; i++) {
    float avepos = 0;
    for (int j = 0; j < rows; j++) {
      avepos += cubicles[i][j].c_y;
    }
    avepos /= rows;
    color c1Max = color(10,64,128); color c1Min = color(100, 200, 256);
    color c = color(0,0,0);
    if (i == 0) c = c1Max;
    if (i == 1) c = color(10,128,256);
    if (i == 2) c = color(64,128,10);
    if (i == 3) c = color(128,64,200);
    fill(c);
    text(titles[i], 40, avepos);  // Text wraps within text box
    if (i == 0) {
      text("Into Darkness", 25, avepos+20);
    }
  }
  // Axis labels
  fill(color(0,0,0));
  textSize(10);
  float delta_x = cubicles[0][0].w;
  float start_x = cubicles[0][0].c_x;
  for (int i = 0; i < rows; i++) {
    text(str(i), marginToLeft + i*delta_x - 3, screenHei - marginToTop*2); 
  }
  for (int i = 0; i < rows; i++) {
    text(str(i), marginToLeft + i*delta_x - 3, marginToTop - 10); 
  }
  textSize(16);
  text("Month (start from Jan 2012)", screenWid / 2.0 - 60, screenHei - marginToTop*2 + 30);
  
  pushMatrix();
  translate(screenWid - 20, screenHei*0.5 + 30);
  rotate(-HALF_PI);
  text("# checkouts per month",0, 0);
  popMatrix();
  
  line((start_x - delta_x*0.5), (screenHei - marginToTop*2 - 20), (start_x - delta_x*0.5), marginToTop);
  line((screenWid - marginToLeft + 6*delta_x), (screenHei - marginToTop*2 - 20), (screenWid - marginToLeft + 6*delta_x), marginToTop);
  line((start_x - delta_x*0.5), marginToTop, (screenWid - marginToLeft + 6*delta_x), marginToTop);
  line((start_x - delta_x*0.5), (screenHei - marginToTop*2 - 20),(screenWid - marginToLeft + 6*delta_x), (screenHei - marginToTop*2 - 20));
  
}

//Refresh the canvas every frame
void draw() {
  background(255);
  //color from = color(255, 0, 0);
  //color to = color(0, 0, 255);
  // plotColumnGraph(data_matrix);
  
  drawCubicles(cubicles);
  MoveCubicles();
  DrawTitles();
  //AssignSpeedCubicle(data_matrix);
}