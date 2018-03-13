Table tradeData;
int rows, cols;
float[][] matrix;
float flMax, flMin = 0;
StringList topStates = new StringList("US", "JP", "DE", "FR", "HK", "CH", "CN", "SG", "AE", "CA", "NL", "ID", "IT", "EC");
//StringList topImporters = new StringList("US", "JP", "DE", "FR", "HK", "CH", "CN", "SG", "AE", "CA");
//StringList topExporters = new StringList("NL", "ID", "IT", "US", "FR", "DE", "CN", "EC", "SG", "CH");

HashMap<String, Trade> hashMap = new HashMap<String, Trade>();

void loadCSV() {
  tradeData = loadTable("comptab_2018-01-29_16_00_comma_separated.csv", "header");
  rows = tradeData.getRowCount();
  cols = tradeData.getColumnCount();
}

void loadAllTrade() {
  int tempCount = 0;
  for (TableRow row : tradeData.rows()) {
    Trade t = new Trade(row);
    //if (t.quantity > 100) {
      if (t.A2B != null) {
        if (hashMap.containsKey(t.A2B)) {
          Trade updateTrade = hashMap.get(t.A2B);
          updateTrade.quantity += t.quantity;
          hashMap.put(t.A2B, updateTrade);
        } else {
          hashMap.put(t.A2B, t);
          println("Country " + t.A2B + " = " + t.quantity);
          tempCount++;
        }
      }
    //}
  }
  println(tempCount + " unique trade between two countries found, data loading finished");
}

String inTop10(String A, String B) {
  //if (topExporters.hasValue(A) && topImporters.hasValue(B)) {
  //if (topStates.hasValue(A) && topStates.hasValue(B)) {
  if (topStates.hasValue(A) || topStates.hasValue(B)) {
    return A.concat("2").concat(B);
  } else {
    return null;
  }
}

class Trade {

  String importer;
  String exporter;
  String A2B;
  float quantity;

  Trade() {
  }

  Trade(TableRow row) {
    importer = row.getString("Importer");
    exporter = row.getString("Exporter");
    A2B = inTop10(exporter, importer); 

    float quantityI = row.getFloat("Importer reported quantity");
    float quantityE = row.getFloat("Exporter reported quantity");
    quantity = bigger(quantityI, quantityE);
  }
}