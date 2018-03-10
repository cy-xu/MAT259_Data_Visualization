Table tradeData;
int rows, cols;
float[][] matrix;
float flMax, flMin = 0;

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
    if (hashMap.containsKey(t.A2B)) {
      Trade updateTrade = hashMap.get(t.A2B);
      updateTrade.quantity += t.quantity;
      hashMap.put(t.A2B, updateTrade);
    } else {
      hashMap.put(t.A2B, t);
      println(t.A2B, t.quantity);
      tempCount++;
    }
  }
  println(tempCount);
}

String inTop10(String A, String B) {
  StringList top10 = new StringList("US", "JP", "DE", "FR", "HK", "CH", "CN", "SG", "AE", "CA", "NL", "ID", "IT", "EC");
  if (top10.hasValue(A) && top10.hasValue(B)) {
    return A.concat("2").concat(B);
  } else {
    return "Test";
  }
}

class Trade {

  String importer;
  String exporter;
  String A2B;
  float quantity;

  Trade(TableRow row) {
    importer = row.getString("Importer");
    exporter = row.getString("Exporter");
    A2B = inTop10(exporter, importer); 

    float quantityI = row.getFloat("Importer reported quantity");
    float quantityE = row.getFloat("Exporter reported quantity");
    quantity = bigger(quantityI, quantityE);
  }
}