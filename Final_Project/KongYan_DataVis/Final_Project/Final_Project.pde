import peasy.*;
import java.util.*;
import javafx.util.*;
import controlP5.*;

ControlP5 cp5;
List<String> genre = Arrays.asList("Foreign", "Documentary", "Western", "Mystery", "Family", "Animation",
                                   "Crime",  "Comedy", "Action", "Adventure", "Drama", "Science Fiction",
                                   "Romance", "Horror", "Thriller", "Fantasy",  "Music", "War", "History");
List<String> toggleLabel = Arrays.asList("SingleGenre", "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary",  "Drama", "Family", "Fantasy",
                                         "History", "Horror", "Music", "Mystery", "Romance", "ScienceFiction", "Thriller", "War", "Western");                                   
int toggled = #f18e8e, untoggled = #bdff8c;
int genreSize = genre.size();  
int maxGenreLength = 7;
PVector[] globalPos = new PVector[genreSize];
ArrayList<Movie> movies = new ArrayList();
HashMap<ArrayList<String>, ArrayList<Movie>>[] movieMap = new HashMap[genreSize];
ArrayList<Path>[] allPath = new ArrayList[genreSize];
Table table;
float[] radius = {0, 500, 600, 400, 400, 400, 300};
PeasyCam cam;
float toggleHeight = 30;
float marginLeft = 100;
float marginTop = 20;
boolean singleMode = true;
boolean[] showGenre = new boolean[genreSize];
PFont SansSerif;
PFont Monospaced;
boolean initState = false;
void setup()
{
  //size(1280, 640, P3D);
  fullScreen(P3D);
  // camera setup
  cam = new PeasyCam(this, 1000);
  float  cameraZ = (height / 2.0) / tan(PI * 60.0 / 360.0);
  perspective(PI/3.0, float(width) / float(height), cameraZ / 10.0, cameraZ * 1000.0); //set near clip to 0.001 to go inside data
  //cam.setWheelScale(0.9);
  //cam.setMinimumDistance(100);
  cam.setMaximumDistance(4000);  // clamp zooming
  SansSerif = createFont("SansSerif", 100);
  Monospaced = createFont("Monospaced", 100);
  // UI
  cp5 = new ControlP5(this);
  setUpToggle();

  // load data
  table = loadTable("tmdb_movies.csv", "header");
  int rows = table.getRowCount();
  for (int i = 0; i < rows; i++)
  {
    TableRow row = table.getRow(i);
    // Movie(int budget, String genres, String keywords, float popularity, String releasedDate, int revenue, int runtime, String tagline, String title, float score)
    movies.add(new Movie(row.getFloat("budget"), row.getString("genres"), row.getString("keywords"), row.getFloat("popularity"), row.getString("release_date"), 
      row.getFloat("revenue"), row.getFloat("runtime"), row.getString("tagline"), row.getString("title"), 
      row.getFloat("vote_average")));
  }
  
  // get hashmap and pathes
  for(int i = 0; i < genreSize; i++)
  {
    movieMap[i] = new HashMap<ArrayList<String>, ArrayList<Movie>>();
    allPath[i] = new ArrayList<Path>();
  }
  
  // initializa global position
  initGlobalPos();
  
  generateHashtable();
  generateGraph();
  
}

void draw()
{
 
  
  
  textFont(SansSerif);
  background(#303030);
  pushMatrix();
  //translate(1000, 1000, -1000);
  drawGraph();
  popMatrix();
  
  gui();
  
}