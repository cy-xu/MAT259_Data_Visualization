String json_url = "https://itunes.apple.com/search?term=michael+jackson&country=cn&media=music";
PImage[] covers;
JSONArray items;
int rows = 5;
int cols = 10;
int index = 0;
void setup()
{
  size(1280, 720);
  JSONObject amy_winehouse = loadJSONObject(json_url);
  saveJSONObject(amy_winehouse, "data/amy_winehouse.json");  
  int result_counts = amy_winehouse.getInt("resultCount");
  println(result_counts);
  
  items = amy_winehouse.getJSONArray("results");
  println("item size:", items.size());
  covers = new PImage[items.size()];
  for(int i = 0; i < items.size(); i++)
  {
    String image_url = items.getJSONObject(i).getString("artworkUrl100");
    covers[i] = loadImage(image_url);
    println(image_url);
    
  }
}

void draw()
{
  while(index < items.size())
  {
    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < cols; j++)
      {
        image(covers[index], 100 + 100 * j, 100 + 100 * i);
        index += 1;
      }
    }
  }
}