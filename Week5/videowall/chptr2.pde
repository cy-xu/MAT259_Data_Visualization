PGraphics chptr2;


import ddf.minim.*;

Minim minim;
AudioInput in;


void initChptr2() {
  chptr2 = createGraphics((int)_w, (int)_h, P2D);
  
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  
  w = (int)_h - 2 * margin;
  h = w;
  w = (w) / 2;
  R = w;
  
  generateLabels();
  generateSimilarity();
}


float angle = 0;
void drawChptr2(){
  chptr2.beginDraw();
  chptr2.background(0,3);
  
  chptr2.translate(_w/2, _h/2);
  for (int i = 0; i < N; i++){
    // DRAW EDGES 
    for (int j = 0; j < nodes[i].connections.size(); j++) {
      Edge e = nodes[i].connections.get(j);
      Node other = e.otherNode;
      
      if(i < other.index){
        // curvy paths
        float opacity = 255;//useOpacityNodesText ? map(e.similarity, 0, 1, 30, 100) : e.similarity*255;
        if(e.isWiggly){
          
          chptr2.noFill();
          if(e.points.length <= 8){
            chptr2.stroke(green, opacity);
          }
          else if(e.points.length > 8 && e.points.length <= 11){
            chptr2.stroke(red, opacity);
          }
          else{
            chptr2.stroke(yellow, opacity);
          }
          
          
          chptr2.stroke(141, 177);
          //chptr2.stroke(yellow, opacity);
          chptr2.beginShape();
          for(int k = 0; k < e.points.length; k++){
            chptr2.curveVertex(e.points[k].x, e.points[k].y);
          }
          chptr2.endShape();
        }
        // straight paths
        //else {
        //  if(e.isGreen)
        //    chptr2.stroke(green, opacity);
        //  else
        //    chptr2.stroke(red, opacity);
        //  chptr2.line(nodes[i].p.x, nodes[i].p.y, other.p.x, other.p.y);
        //}
      }
      
      e.updateCurves(nodes[i]);
    }
  }
  
  // edit, add or remove edges
  updateEdges();
  
  chptr2.endDraw();
}


void updateEdges() {
  // shuffle edges
  if (millis()%shfl_time > 0 && millis()%shfl_time < 20){
    int rand_index = int(random(0, N));
    int i = int(random(0, N));
    
    if(rand_index != i && !isExist(nodes[i], rand_index)){
      nodes[i].setConnection(nodes[rand_index]);
      //println("xxx "+i+" -> "+rand_index);
    }
  }
  
  // add new edges
  if (millis()%add_time > 0 && millis()%add_time < 20){
    int rand_index = int(random(0, N));
    int i = int(random(0, N));
    
    if(rand_index != i && !isExist(nodes[i], rand_index)){
      nodes[i].addConnection(nodes[rand_index]);
      //println("+++ "+i+" -> "+rand_index);
    }
  }
  
  // remove edges
  if (millis()%rmv_time > 0 && millis()%rmv_time < 20){
    int i = int(random(0, N));
    
    nodes[i].removeConnection();
    //println("--- "+i);
  }
}

class Edge {
  Node otherNode;
  float similarity; 
  float closeness;
  boolean isWiggly;
  boolean isGreen;
  
  PVector[] points;
  
  Edge() {}
  Edge(Node n) {
    otherNode = n;
    
    similarity = random(0, 1);
    
    if(random(0,1) > 0.2) isWiggly = false;
    else                  isWiggly = true;
    
    if(random(0,1) > 0.9) isGreen = true;
    else                  isGreen = false;
  }
  
  void determinePoints(Node beg) {
    if(abs(beg.index-otherNode.index) >= N/2){
      closeness = N - abs(beg.index-otherNode.index);
    }
    else {
      closeness = abs(beg.index-otherNode.index);
    }
    
    if(isWiggly) {
      // size > 5
      // Modulating frequency based on closeness
      float closeness_factor = map(closeness, 1, N/2, 0.3, 1);
      int size = int(random(5,maxFrequency*closeness_factor));
      points = new PVector[size];
      
      points[0] = beg.p;
      points[1] = beg.p;
      for(int i = 2; i < size-2; i++){ 
        points[i] = interpolate(beg.p, otherNode.p, map(i, 2, size-2, 0.95, 0.05));
      }
      points[size-2] = otherNode.p;
      points[size-1] = otherNode.p;
    }
    else { 
      points = new PVector[2];
      points[0] = beg.p;
      points[1] = otherNode.p;
    }
  }
  
  // Calculates the corresponding point along y = (x/())^8
  private float calculatePointOnCurve(float x, float wow) {
    return pow(x/(N*wow), 8);
  }
  void updateCurves(Node beg) {
    for (int i = 0; i < beg.connections.size(); i++){
      Edge e = beg.connections.get(i);
      e.similarity += random(-similarity_update, similarity_update);
    }
    
    if(isWiggly) {
      for(int i = 2; i < points.length-2; i++){ 
        PVector v1 = PVector.sub(beg.p, otherNode.p);       
        
        // normals
        // (-dy, dx) (dy, -dx)
        PVector normal;
        PVector n2;
        if (randomCurveUpdate){
          normal = random(0,1) > 0.5 ? new PVector(-v1.y, v1.x) : new PVector(v1.y, -v1.x);
          n2 = random(0,1) > 0.5 ? new PVector(-points[i].y, points[i].x) : new PVector(points[i].y, -points[i].x);
        }
        else{
          if (i % 2 == 1){
            normal = new PVector(-v1.y, v1.x);
            n2 = new PVector(-points[i].y, points[i].x);
          }
          else
          {
            normal = new PVector(v1.y, -v1.x);
            n2 = new PVector(points[i].y, -points[i].x);
          }
        }
        
        // speed modulation of increase normal addition
        //float wow = 0.65;//constrain(map(millis(), 0, initialUpdateTime, 0.5, 0.95), 0.5, 0.95);
        //float weight = map(in.left.get(i), 0, 1, 
        //                   calculatePointOnCurve(0, wow), 
        //                   calculatePointOnCurve(1, wow));
        
        float weight = in.left.get(i)*10;
        points[i] = PVector.add(normal.normalize().mult(weight*random(-harmonics, harmonics)), points[i]); 
        
        // disturb perfect order
        //points[i] = PVector.add(n2.normalize().mult(weight), points[i]);
      }
    }
  }
}

class Node {
  String title = "----";
  ArrayList<Edge> connections = new ArrayList<Edge>(1);
  
  int index = 0;
  boolean filled;
  PVector p;
  
  Node() {}
  Node(String s, int i) {
    title = s;
    index = i;
    
    if (random(0,1) > 0.6) // filled with a prob of 0.4
      filled = true;
    else
      filled = false;
    
    p = index2euc(i,R);
  }
  
  void addConnection(Node n){
    Edge e = new Edge(n);
    e.determinePoints(this);
    connections.add(e);
    max_connections = max(max_connections, connections.size());
  }
  
  void setConnection(Node n){
    if(connections.size() > 0){
      Edge e = new Edge(n);
      e.determinePoints(this);
      connections.set(int(random(0, connections.size())), e);
    }
  }
  
  void removeConnection(){
    if(connections.size() > 1){
      connections.remove(int(random(connections.size()-1)));
    }
  }
}

import processing.pdf.*;

// NUMBER OF NODES
int b = 2;
int N;

// NODES
Node[] nodes;
int max_outgoing_edge = b*3;
int max_connections = 0;

// EDGE UPDATE PARAMETERS
float similarity_update = 0.05;
float curve_update = 0.1; // max 1
long initialUpdateTime = 10000;
float maxFrequency = 30;
int harmonics = 6;

// DRAW PARAMETERS
int margin = 0, w, h, R;
float node_margin = 10;
float node_radius = 4;
float text_margin = 20;
float text_size = 12;

// COLORS

//color red = color(10);
//color yellow = color(30);
//color blue = color(92);
//color green = color(83);

color red = color(231, 71, 99);
color yellow = color(242, 205, 55);
color blue = color(92,140,176);
color green = color(83,186, 156);
color back = color(20);

// UPDATE TIMES
int  rmv_time = 2000;
int  add_time = 2000;
int shfl_time = 500;

//////////// FUNCTIONS ////////////////

// generates random labels for nodes
void generateLabels() {
  String labels[] = loadStrings("names.txt");
  
  N = labels.length*b;
  nodes = new Node[N];
  
  for (int i = 0; i < N; i++){
    String title = "-----";
    if(i%b == 0)
      title = labels[int(i/b)];
    
    nodes[i] = new Node(title, i);
  }
}

// generates random edges between nodes
void generateSimilarity() {
  for (int i = 0; i < N; i++){
    int neigbor_count = int(random(0, max_outgoing_edge));
    
    for (int j = 0; j < neigbor_count; j++){
      int k = int(random(0, N));
      if(k != i && !isExist(nodes[i], k)){
        nodes[i].addConnection(nodes[k]);
      }
    }
  }
}


// UTILITY
boolean isExist(Node n, int k) {
  for(int i = 0; i < n.connections.size(); i++){
    if(n.connections.get(i).otherNode.index == k){
      return true;
    }
  }
  return false;
}
PVector index2euc(int index, float _r) {
  float angle = TWO_PI/N*index;
  return new PVector(_r * cos(angle), _r * sin(angle));
}
PVector interpolate(PVector p1, PVector p2, float amount) {
  return new PVector(p1.x*amount+p2.x*(1-amount), p1.y*amount+p2.y*(1-amount));
}