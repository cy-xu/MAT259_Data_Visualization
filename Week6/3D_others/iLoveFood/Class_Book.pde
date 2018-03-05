class Book {
  String title;
  float deweyClass;
  float count;
  float dirX, dirY, dirZ;
  float x, y, z;
  float std;
  float avg;

  Book(String title, float deweyClass, float count, float std, float avg, float x, float y, float z, float dirX, float dirY, float dirZ) {
    this.title = title;
    this.deweyClass = deweyClass;
    this.count = count;
    this.std = std;
    this.avg = avg;
    this.dirX = dirX;
    this.dirY = dirY;
    this.dirZ = dirZ;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  public void move() {
    float jitter = (random(-1, 1) < 0) ? -this.std : this.std;
    this.x+=this.dirX-jitter;
    this.y+=this.dirY-jitter;
    this.z+=this.dirZ-jitter;
  }

  public void bounce() {
    if (sq(this.x) + sq(this.y) + sq(this.z) > sq(225)) {
      this.dirX = -this.dirX; 
      this.dirY = -this.dirY;
      this.dirZ = -this.dirZ;
    }
  }

  public void eat(Book Book2) {

    if (dist(this.x, this.y, this.z, Book2.x, Book2.y, Book2.z) < (sqrt(this.count))) {
      this.count = map(this.count, 0, 5849, 5, 25); 
      this.avg = map(this.avg, 0, 482, 0, 5);
      this.std = map(this.std, 0, 223, 0, 5);

      if ( 0.5 <=(elementDetermine(this.deweyClass) ) && (elementDetermine(this.deweyClass) < 0.6)) {
        this.count += (Book2.count/2);
      } else {
        this.count += Book2.count;
      }

      this.title = this.title + "\n" + Book2.title;
      this.std = (this.std + Book2.std)/2;
      this.avg = (this.avg + Book2.avg)/2;
      Book2.title = null; 
      Book2.deweyClass = 0;
      Book2.count = 0;
      Book2.std = 0;
      Book2.avg = 0;
      Book2.x = 0;
      Book2.y = 0;
      Book2.z = 0;
    }
  }
}