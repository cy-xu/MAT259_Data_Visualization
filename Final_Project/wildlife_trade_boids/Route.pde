class Route {
  String importer;
  String exporter;
  String A2B;
  float quantity;

  ArrayList<Boid> boids; // An ArrayList for all the boids

  Route() {
    boids = new ArrayList<Boid>(); // Initialize all the ArrayLists
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  Trade t = hashMap.get("US2CN"); 

  void addBoid(Boid b) {
    //for (int i = 0; i < int(t.quantity); i++)
    boids.add(b);
  }
}