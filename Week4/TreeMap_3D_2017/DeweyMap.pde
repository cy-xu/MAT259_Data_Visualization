//DeweyMap class contains all DeweyItems 

class DeweyMap extends SimpleMapModel { 
  HashMap deweys;
  
  DeweyMap(){
    deweys = new HashMap();
  }
  
  void addDewey(String dewey, int count){
    DeweyItem item = new DeweyItem(dewey);
    deweys.put(dewey, item);
    item.setSize(count);
  }
  
  void finishAdd(){
   items = new DeweyItem[deweys.size()];
   deweys.values().toArray(items);
  }
}