
class checkTimeFour {
  
  checkTimeFour(String fname) {
    String[] lines = loadStrings(fname + "0.txt");
    int totalN = lines.length;
    lists_ = new IntList[4][totalN];
     for (int i = 0; i < 4; i++) {
       for (int j = 0; j < totalN; j++) {
          lists_[i][j] = new IntList();
        }
    }
    for (int k = 0; k < 4; k++) {
      String curfname = fname + str(k) + ".txt";
      String[] LineIn = loadStrings(curfname);
      
      for (int i=0; i < totalN; i++) {
        String [] num = splitTokens(LineIn[i]);
        if (num.length == 1) {
          continue;
        } else {
          for (int j = 1; j < num.length; j++) {
            //print(num[j]);
            lists_[k][i].append(int(num[j]));
          }
        }
      }
    }
  }
 public IntList [][] lists_; 
};