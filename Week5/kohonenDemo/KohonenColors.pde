class KohonenSet{
  float learningRate= .25;
  int numNodes, numWeights;
  int vNodes, hNodes;
  float MAX_ITERATIONS = 250;
  int iterationCounter = 0;
  float neighborDist;
  float weightArray[][]; //an array of 'node' by 'weight' dimensions
  float kset[][];  //values to be sorted
  Integer ksetRandomOrder[];
  int mapMode = 0;

  void KohonenSet(){
  }

  void initWeights(int hNodes, int vNodes, int numWeights){
    weightArray = new float[vNodes*hNodes][numWeights];
    numNodes = vNodes*hNodes;
    this.hNodes = hNodes;
    this.vNodes = vNodes;
    this.numWeights = numWeights;
    for (int i=0; i<numNodes; i++){
      for (int j=0; j<numWeights; j++){
        weightArray[i][j] = random(255);
      }
    }
    ksetRandomOrder = new Integer[kset.length];
    for (int i=0; i<kset.length; i++){
      ksetRandomOrder[i] = new Integer(i);
    }
  }

  void train(){
    Collections.shuffle(Arrays.asList(ksetRandomOrder));    
    if (iterationCounter<MAX_ITERATIONS){
      //      neighborDist = 30+100-(100*(iterationCounter/MAX_ITERATIONS));
      neighborDist = 32+(height/4*(1-(iterationCounter/MAX_ITERATIONS)));
      for (int k=0; k<kset.length; k++){
        int bmu = bestMatchingUnit(ksetRandomOrder[k].intValue());
        for (int node=0; node<numNodes; node++){
          float nodeX = 500/hNodes*(node%hNodes);
          float nodeY = 500/vNodes*(node/hNodes);
          float bmuX = 500/hNodes*(bmu%hNodes);
          float bmuY = 500/vNodes*(bmu/hNodes);
          float nodeDist = constrain(dist(nodeX,nodeY,bmuX, bmuY),0,neighborDist);
          for (int i=0; i<numWeights; i++){
            if (nodeDist == 0){
              weightArray[node][i] = kset[ksetRandomOrder[k].intValue()][i];
            }
            else {
              float percent = learningRate*(1-(nodeDist/neighborDist));
              weightArray[node][i] = (1-percent)*weightArray[node][i] + percent*kset[ksetRandomOrder[k].intValue()][i];
            }
          }
        }
      }
    } 
    iterationCounter++;
  }

  int bestMatchingUnit(int inputNode){
    int bmu=0; //arbitrary
    float bestFitDistance = 1000; //arbitrarily high
    for (int node=0; node<numNodes; node++){
      float sum = 0;
      for (int i=0; i<numWeights; i++){
        sum += sq(kset[inputNode][i]-weightArray[node][i]);
      }
      float distance = sqrt(sum);
      if (distance <= bestFitDistance){
        bestFitDistance = distance;
        bmu = node;
      }
    }
    return(bmu);
  }

  void map(){
    for (int node=0; node<numNodes; node++){
      pushMatrix();
      translate(500/hNodes*(node%hNodes),500/vNodes*(node/hNodes));
      fill(weightArray[node][0],weightArray[node][1],weightArray[node][2]);
      rect(0,0,500/hNodes,500/vNodes);
      popMatrix();
    }
  }

  void errorMap(){
    for (int node=0; node<numNodes; node++){
      float nodeValue=0;
      for (int i=0; i<numWeights; i++){
        float adjacentWeights=0;
        int numWeightsChecked=0;
        if(node%hNodes != 0){
          adjacentWeights += weightArray[node-1][i]; //if you're along the left side of the screen don't check node to left
          numWeightsChecked++;
        }
        if(node%hNodes != hNodes-1){
          adjacentWeights += weightArray[node+1][i];//if you're along the right don't check to the right
          numWeightsChecked++;
        }
        if(node>=hNodes){
          adjacentWeights += weightArray[node-hNodes][i];//if you're along the top don't check above you
          numWeightsChecked++;
        }
        if(node<(numNodes-hNodes)){
          adjacentWeights += weightArray[node+hNodes][i];//if you're along the bottem don't check below yourself
          numWeightsChecked++;
        }
        //        nodeValue += weightArray[node][i];
        nodeValue += abs(weightArray[node][i] - (adjacentWeights/numWeightsChecked));
      }
      //      fill(255-abs(nodeValue/numWeights - adjacentWeights/numWeightsChecked));
      fill(255-5*nodeValue);
      pushMatrix();
      translate(500/hNodes*(node%hNodes),500/vNodes*(node/hNodes));
      rect(0,0,500/hNodes,500/vNodes);
      popMatrix();
    }
  }

  void listMap(){
    float m=.5; //a multiplier for easier visualization
    for(int node=0; node<numNodes; node++){
      pushMatrix();
      translate(0,500/vNodes*(node/hNodes));
      fill(255,0,0);
      rect(0,0,m*weightArray[node][0],500/vNodes);
      fill(0,255,0);
      rect(m*weightArray[node][0],0,m*(weightArray[node][1]),500/vNodes);
      fill(0,0,255);
      rect(m*(weightArray[node][0]+weightArray[node][1]),0,m*(weightArray[node][2]),500/vNodes);
      popMatrix();
    }
  }
  
  void listMapTwo(){
    background(230);
    float m=.5; //a multiplier for easier visualization
    for(int node=0; node<numNodes; node++){
      pushMatrix();
      translate(0,500/vNodes*(node/hNodes));
      fill(255,0,0);
      rect(0,0,m*weightArray[node][0],500/vNodes);
      fill(0,255,0);
      rect(150,0,m*(weightArray[node][1]),500/vNodes);
      fill(0,0,255);
      rect(300,0,m*(weightArray[node][2]),500/vNodes);
      popMatrix();
    }
  }

  void legend(){
    for (int samples=0; samples<colorList.length; samples++){
      pushMatrix();
      translate(500+(samples/25)*20,20*(samples%25));
      fill(colorList[samples][0],colorList[samples][1],colorList[samples][2]);
      rect(0,0,20,20);
      popMatrix();
    }
  }

  void bmuLabels(){
    //dots for the BMUs
    for (int i=0; i<kset.length; i++){
      int bmu = bestMatchingUnit(i);
      pushMatrix();
      translate((500/(2*hNodes))+500/hNodes*(bmu%hNodes),(500/(2*vNodes))+500/vNodes*(bmu/hNodes));
      fill(0,0,0);
      ellipse(0,0,3,3);
      popMatrix();
    }    
  }

  String toString(){
    for (int node=0; node<kset.length; node++){
      print("node: " + node + "\t value: ");
      for (int i=0; i<numWeights; i++){
        print(kset[node][i] + "\t");
      }
      println();
    }
    return("");
  }
}