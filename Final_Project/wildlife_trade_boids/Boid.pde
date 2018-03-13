class Boid {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector origin, destination;
  float r;
  float maxforce; // max steering force
  color c;

  Boid(PVector exporter, PVector importer, color cc) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = exporter.copy();
    origin = exporter.copy();
    destination = importer.copy();
    r = 4.0;
    maxspeed = 3;
    maxforce = 0.05;
    c = cc;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    //borders();
    render();
  }

  void applyForce(PVector force, PVector target) {
    target.add(force);
  }

  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);
    PVector ali = align(boids);
    PVector coh = cohesion(boids);
    PVector dest = seek(destination);

    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    dest.mult(1.0);

    applyForce(sep, acceleration);
    applyForce(ali, acceleration);
    applyForce(coh, acceleration);
    applyForce(dest, acceleration);
  }

  void update() {
    float toDest = location.dist(destination);
    if (toDest < 30) {
      location = origin.copy();
    } 
    velocity.add(acceleration); // update velocity
    velocity.limit(maxspeed);   // limit speed
    location.add(velocity);     // update location
    acceleration.mult(0);       // reset accceleration to 0 each cycle
  }

  PVector separate(ArrayList<Boid> boids) {
    float desiredSeparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // for every boid in system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < desiredSeparation)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;
      }
    }
    // average
    if (count > 0) {
      steer.div((float)count);
    }

    // as long as the vector is 
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0, 0);
    }
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location); // A vector pointing from the position to the target
    float d = desired.mag();
    desired.normalize();
    if (d < 200) {
      float m = map(d, 0, 200, 0, maxspeed);
      desired.mult(m);
    } else {
      desired.mult(maxspeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(c);
    stroke(50);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  //Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}