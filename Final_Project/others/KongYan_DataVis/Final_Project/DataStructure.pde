class Movie
{
  float budget, revenue, runtime;
  String[] genres;
  String[] keywords;
  String[] tagline;
  String title;
  Date releasedDate;
  float score, popularity;

  Movie(float budget, String genres, String keywords, float popularity, String releasedDate, float revenue, float runtime, String tagline, String title, float score)
  {
    this.budget = budget;
    this.revenue = revenue;
    this.title = title;
    this.score = score;
    this.popularity = popularity;
    this.runtime = runtime;
    this.releasedDate = new Date(releasedDate);
    this.tagline = tagline.split(" ");
    this.genres = genres.split(",");
    this.keywords = keywords.split(",");

    //println("title: ", this.title, "score: ", this.score, "tagline: ", tagline,
    //        "releasedDate: ", this.releasedDate.year, this.releasedDate.month, this.releasedDate.day, 
    //        "budget: ", this.budget, "revenue: ", this.revenue);
    ////print("keywords: ");
    ////printArrayList(this.keywords);
    //print("genres: ");
    //printArrayList(this.genres);
  }

  void printArrayList(String[] s)
  {
    for (int i = 0; i < s.length; i++) 
    {
      print(s[i] + " ");
    }
    println();
  }
}

class Date
{
  int year, month, day;
  Date(String released_date)
  {
    String[] array = released_date.split("/");
    this.month = Integer.parseInt(array[0]);
    this.day = Integer.parseInt(array[1]);
    this.year = Integer.parseInt(array[2]);
  }
}

class Path
{
  ArrayList<PVector> path;
  ArrayList<Movie> movieList;
  PVector endPoint;

  Path(ArrayList<Movie> movieList)
  {
    this.path = new ArrayList<PVector>();
    this.movieList = movieList;
  }

  void addNode(PVector point)
  {
    this.path.add(point);
  }

  void setEnd(PVector point)
  {
    this.endPoint = point;
  }
}


void generateHashtable()
{
  ArrayList<ArrayList<String>>[] keyLists = new ArrayList[genreSize];
  for (int i = 0; i < genreSize; i++)
  {
    keyLists[i] = new ArrayList<ArrayList<String>>();
  }
  for (int i = 0; i < movies.size(); i++)
  {
    Movie movie = movies.get(i);
    ArrayList<String> k =  new ArrayList<String>(Arrays.asList(movie.genres));
    //printArray(k);
    int index = genre.indexOf(k.get(0));
    if (!movieMap[index].containsKey(k))
    {
      ArrayList<Movie> list = new ArrayList<Movie>();
      list.add(movie);
      movieMap[index].put(k, list);

      keyLists[index].add(k);
    } else
    {
      ArrayList<Movie> list = movieMap[index].get(k);
      list.add(movie);
      movieMap[index].put(k, list);
    }
  }

  for (int i = 0; i < genreSize; i++)
  {
    Iterator iter = movieMap[i].entrySet().iterator();

    while (iter.hasNext()) {
      Map.Entry pair = (Map.Entry)iter.next();
      ArrayList<String> key1 = (ArrayList<String>)pair.getKey();
      ArrayList<Movie> value = (ArrayList<Movie>)pair.getValue();
      if (value.size() <= 1 && key1.size() > 1)
        iter.remove();
    }
    //println(key1+":", movieMap.get(key1).size());
    //println("movieMap size:", movieMap[i].size());
  }
}


void generateGraph()
{
  for (int i = 0; i < genreSize; i++)
  {
    Set<ArrayList<String>> keys = movieMap[i].keySet();
    for (ArrayList<String> key1 : keys)
    {
      //println(key1+":", movieMap[i].get(key1).size());
      Path p = new Path(movieMap[i].get(key1));
      PVector point = new PVector(0, 0, 0);
      float arc = 0.0;
      for (int j = 0; j < key1.size(); j++)
      {
        arc = arc + getArc(j, genre.indexOf(key1.get(j)));
        // print(genre.indexOf(key1.get(i)),"->");
        PVector newPoint = new PVector(point.x + radius[j] * cos(arc), 0, point.z + radius[j] * sin(arc));
        p.addNode(newPoint);
        point.x = newPoint.x;
        point.y = newPoint.y;
        point.z = newPoint.z;
      }
      p.setEnd(point);
      //println();
      //printArray(path);
      allPath[i].add(p);
    }
    //println(i, "path length", allPath[i].size());
  }
  //println("allPath:", allPath.length);
}

float getArc(int layer, int index)
{
  float arc = 0.0;
  switch(layer)
  {
  case 0: arc = 0; break;
  case 1: arc = TWO_PI / genreSize * index; break;
  case 2: arc = TWO_PI / 6 / (genreSize - 1) * index - TWO_PI / 12; break;
  case 3: arc = TWO_PI / 12 / (genreSize - 2) * index - TWO_PI / 24; break;
  case 4: arc = TWO_PI / 20 / (genreSize - 3) * index - TWO_PI / 40; break;
  case 5: arc = TWO_PI / 30 / (genreSize - 4) * index - TWO_PI / 60; break;
  case 6: arc = TWO_PI / 30 / (genreSize - 5) * index - TWO_PI / 60; break;
  case 7: arc = TWO_PI / 20 / (genreSize - 6) * index - TWO_PI / 40; break;
  }
  return arc;
}