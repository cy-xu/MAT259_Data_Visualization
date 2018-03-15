void drawTitle()
{
  textFont(Monospaced);
  int textSize = 30;
  String title = "MOVIE CITY";
  String desc1 = "- a radial tree of cross-genre movies"; 
  String desc2 = "between genres, cross-genre, rating, budget,";
  String desc3 = "revenue, etc.";
  pushMatrix();
  translate(marginTop, (height - toggleHeight * toggleLabel.size()) / 2 + toggleHeight * toggleLabel.size(), 0);
  textSize(textSize);
  fill(#ffffff);
  text(title, 0, 0);
  textSize = 14;
  textSize(textSize);
  text(desc1, 0, marginTop);
  textSize = 12;
  textSize(textSize);
  text(desc2, 0, marginTop * 1.8);
  text(desc3, 0, marginTop * 2.5);
  popMatrix();
}
void drawCoordinateSys()
{
  stroke(255, 0, 0);
  line(0, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 1000);
}

void drawGraph()
{
  for (int i = 0; i < showGenre.length; i++)
  { 
    if (showGenre[i] == true)
    {
      ArrayList<Path> path = allPath[i];
      color c = getColor(i);
      pushMatrix();
      if (singleMode == false)
      {
        cam.setMaximumDistance(10000);
        translate(globalPos[i].x, globalPos[i].y, globalPos[i].z);
      }
      else
      {
        cam.setMaximumDistance(4000);
        translate(0, 0, 0);
      }
      if (i == genre.indexOf("Crime") || i == genre.indexOf("Family") || i == genre.indexOf("Mystery"))
      {
        drawMainGenre(i);
      }
      for (int j = 0; j < path.size(); j++)
      {
        drawPath(path.get(j), c);
      }
      popMatrix();
    }
  }
}

void drawPath(Path p, color c)
{
  for (int j = 0; j < p.path.size() - 1; j++)
  {
    PVector pos1 = p.path.get(j);
    PVector pos2 = p.path.get(j + 1);
    stroke(#ffffff, 50);
    strokeWeight(2);
    line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
  }
  drawMovieData(p.movieList, p.endPoint, c);
}

void drawMovieData(ArrayList<Movie> movieList, PVector point, color c)
{
  // float budget, String genres, String keywords, float popularity, String releasedDate, float revenue, float runtime, String tagline, String title, float score
  pushMatrix();
  translate(point.x, point.y, point.z);
  // draw genre
  drawGenre(movieList);
  // draw each movie under the same category
  for (int i = 0; i < movieList.size(); i++)
  {
    drawEachMovie(movieList.get(i), i, movieList.size(), c);
  }
  popMatrix();
}

void drawEachMovie(Movie movie, int i, int size, color genreColor)
{
  pushMatrix();
  color c;
  if (movie.revenue - movie.budget > 0)
    c = genreColor;
  else
    c = #EF2531;
  float score = exp(movie.score)/2; // as height
  float budget = map(movie.budget, 7000, 380000000, 2, 70);
  float runtime = map(movie.runtime, 41, 250, 1.0, size * 15);
  float index = map(i, 0, size, 0, TWO_PI);

  translate(runtime * cos(index), -budget, runtime * sin(index));
  // Draw pyramid
  if(singleMode == true)
  {
    drawDescription(movie.tagline, movie.keywords, score);
  }
  drawPyramid(budget, score, c);
  drawTitle(movie, score);
  //Draw tagline, keywords
  //popMatrix();
}

void drawDescription(String[] tagline, String[] keywords, float score)
{

  pushMatrix();
  translate(0, (score + 10), 0);
  rotateZ(PI/2);
  fill(#ffffff, 255);
  int init_height = 0;
  int textsize = 0;
  for (int i = 0; i < keywords.length; i++)
  {
    if (keywords[i].length() == 2)
      textsize = 45;
    else if (keywords[i].length() == 3)
      textsize = 40;
    else if (keywords[i].length() == 4)
      textsize = 35;
    else
      textsize = 10;
    textSize(textsize);

    text(keywords[i], init_height, 0, 0);
    init_height += keywords[i].length() * textsize;
  }
  popMatrix();
}

void drawTitle(Movie movie, float score)
{
  // Draw label
  fill(#ffffff, 255);
  noStroke();
  rect(-movie.title.length(), -(score + 5) - 10, 7.7 * movie.title.length(), 12, 7);

  fill(#000000, 255);
  textAlign(TOP);
  textSize(10);
  text(movie.title, 0, -(score + 5), 1);

  pushMatrix();
  fill(#000000, 255);
  rotateY(PI);
  translate(-6 * movie.title.length(), 0, 0);
  text(movie.title, 0, -(score + 5), 1);
  popMatrix();
  popMatrix();
}

void drawPyramid(float budget, float score, color c)
{
  pushMatrix();
  rotateX(PI/2);
  stroke(c, 200);
  strokeWeight(1);
  fill(c, 100);
  beginShape();
  vertex(-budget, -budget, -budget);
  vertex( budget, -budget, -budget);
  vertex(   0, 0, score);
  endShape();

  beginShape();
  vertex( budget, -budget, -budget);
  vertex( budget, budget, -budget);
  vertex(   0, 0, score);
  endShape();

  beginShape();
  vertex( budget, budget, -budget);
  vertex(-budget, budget, -budget);
  vertex(   0, 0, score);
  endShape();

  beginShape();
  vertex(-budget, budget, -budget);
  vertex(-budget, -budget, -budget);
  vertex(   0, 0, score);
  endShape();
  popMatrix();
}

void drawMainGenre(int index)
{
  Path p = allPath[index].get(0);
  PVector pos = p.path.get(0);
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  rotateX(PI/2);
  textAlign(CENTER, CENTER);
  fill(#ffffff, 255);
  textSize(map(0, 0, 6, 80, 15) + p.movieList.size() / 5);
  text(p.movieList.get(0).genres[0], 0, -1, 0);
  popMatrix();
}

void drawGenre(ArrayList<Movie> movieList)
{
  pushMatrix();
  rotateX(PI/2);
  textAlign(CENTER, CENTER);
  fill(#ffffff, 255);
  int size = movieList.get(0).genres.length;
  textSize( map(size, 0, 6, 80, 15) + movieList.size() / 5);
  text(movieList.get(0).genres[size - 1], 0, -1, 0);
  popMatrix();
}

void initGlobalPos()
{
  for(int i = 0; i < genreSize; i++)
  {
    globalPos[i] = new PVector(4000 * cos(TWO_PI/(genreSize - 1) * i), 0, 3000 * sin(TWO_PI/(genreSize - 1) * i));
    
  }
  globalPos[genre.indexOf("Action")] = new PVector(0, 0, 0);
  globalPos[genre.indexOf("Mystery")] = new PVector(1500, 0, 1500);
  globalPos[genre.indexOf("Music")] = new PVector(-1500, 0, -1500);
  PVector temp = new PVector(globalPos[genre.indexOf("History")].x, globalPos[genre.indexOf("History")].y, globalPos[genre.indexOf("History")].z);
  globalPos[genre.indexOf("History")] = globalPos[genre.indexOf("Comedy")];
  globalPos[genre.indexOf("Comedy")] = temp;
  temp = new PVector(globalPos[genre.indexOf("Western")].x, globalPos[genre.indexOf("Western")].y, globalPos[genre.indexOf("Western")].z);
  globalPos[genre.indexOf("Western")] = globalPos[genre.indexOf("Drama")];
  globalPos[genre.indexOf("Drama")] = temp;
  globalPos[genre.indexOf("Drama")] = new PVector(globalPos[genre.indexOf("Drama")].x , 0, globalPos[genre.indexOf("Drama")].z + 500);
  globalPos[genre.indexOf("Western")] = new PVector(-1500, 0, 1500);
  globalPos[genre.indexOf("War")] = new PVector(globalPos[genre.indexOf("War")].x , 0, globalPos[genre.indexOf("War")].z - 500);
  globalPos[genre.indexOf("Documentary")] = new PVector(globalPos[genre.indexOf("Family")].x - 500, 0, globalPos[genre.indexOf("Family")].z - 200);
  globalPos[genre.indexOf("Thriller")] = new PVector(-2500, 0, 500);

  
}