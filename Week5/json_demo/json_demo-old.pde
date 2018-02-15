String json_url = "https://itunes.apple.com/search?term=michael+jackson&country=cn&media=music";
PImage[] covers;

int rows = 5;
int cols = 10;
int index = 0;

void setup() {
  size(1200, 800);

  JSONObject jacksonCN = loadJSONObject( "data/jacksonCN.json");
  // saveJSONObject(jacksonCN, "data/jacksonCN.json");

  int result_counts = jacksonCN.getInt("resultCount");
  println("Counts: " + result_counts);

  JSONArray items = jacksonCN.getJSONArray("results");
  println("Items size: " + items.size());

  covers = new PImage[items.size()];
  for (int i=0; i<items.size(); i++) {
    String image_url = items.getJSONObject(i).getString("artworkUrl100");
    covers[i] = loadImage(image_url);
    println(image_url);
  }
}

void draw() {

  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; i++) {
      image(covers[0], 100+100*j, 100*i);
      if ( index < 48) {
        index+=1;
      }
    }
  }
}