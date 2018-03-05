
float speed = 1.0;
float gravity = -0.05;


PVector positions[];
PVector velocities[];
int lifetimes[];  

int fcount, lastm;
float frate;
int fint = 3;

void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector();
  }  
}

void initVelocities() {
  velocities = new PVector[npartTotal];
  for (int n = 0; n < velocities.length; n++) {
    velocities[n] = new PVector();
  }
}

void initLifetimes() {
  // Initializing particles with negative lifetimes so they are added
  // progressively into the screen during the first frames of the sketch   
  lifetimes = new int[npartTotal];
  int t = -1;
  for (int n = 0; n < lifetimes.length; n++) {    
    if (n % npartPerFrame == 0) {
      t++;
    }
    lifetimes[n] = -t;
  }
}

void drawParticle(PVector center, float opacity, float ptsize) {
  pushMatrix();
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);
  
  beginShape(QUAD);
  // fill(255,0,0);
  noStroke();
  tint(255,255,255, opacity * 255);
  texture(sprite);
  normal(0, 0, 1);
  vertex(center.x - ptsize, center.y - ptsize, 0, 0);
  vertex(center.x + ptsize, center.y - ptsize, sprite.width, 0);
  vertex(center.x + ptsize, center.y + ptsize, sprite.width, sprite.height);
  vertex(center.x - ptsize, center.y + ptsize, 0, sprite.height);                
  endShape();
  popMatrix();
}

void drawParticleNew(PVector center, color C) {
  stroke(C);
  point(center.x, center.y, center.z);
}

public class particle {
  public PVector velocity_;
  public PVector position_;
  public float time_;
  public float life_;
  public boolean reset_;
  public float sleepTime_;
  particle(){
    velocity_ = new PVector();
    position_ = new PVector();
    velocity_.x = 0;
    velocity_.y = 0;
    velocity_.z = 0;
    position_.x = 0;
    position_.y = 0;
    position_.z = 0;
    time_ = 0;
    reset_ = true;
    life_ = 10.0;
  }
  void evolve(float partTimeAll_) {
    if (sleepTime_ < 0) {
      position_.x += velocity_.x * dt;
      position_.y += velocity_.y * dt;
      position_.z += velocity_.z * dt;
      time_ += dt;
      velocity_.y += gravity;
      if (time_ > life_) {
          reset_ = true;
      }
    } else {
      sleepTime_ --;
    }
  }
}

public class Psysem {
  Psysem(int numPart, float baseX, float baseY, float baseZ, float cellX, float cellY, IntList ptlLifeTime, color ptColor) {
    particles_ = new particle[numPart];
    //particles_ = new ArrayList<particle>();
    numParts_ = numPart;
    for (int i = 0; i < numPart; i++) {
      particles_[i] = new particle();
    }
    //println(particles_.length);
    partTimeAll_ = 30.0;
    numPartPerFrame_ = numPart / (int)partTimeAll_;
   
    
    baseX_ = baseX;
    baseY_ = baseY;
    baseZ_ = baseZ;
    cellX_ =cellX;
    cellY_ =cellY;
    numList = ptlLifeTime.size();

    ptlLifeTime_ = ptlLifeTime;
    initPtlLifeTime();
    ptColor_ = ptColor;
  }
  public void initPtlLifeTime() {
    float t = 0;
    for (int i=0; i<numParts_; i++) {
              float randv1 = random(-0.5,0.5);
        float randv2 = random(-0.5,0.5);
        particles_[i].position_.x = randv1*cellSizeX;
        particles_[i].position_.y = 0;
        particles_[i].position_.z = randv2*cellSizeY;
        particles_[i].velocity_.x = 0;
        particles_[i].velocity_.y = 0;
        particles_[i].velocity_.z = 0;
        particles_[i].time_ = 0;
        int randV = int(random(0,ptlLifeTime_.size()));
        float rlife = 0;
        if (ptlLifeTime_.size() > 0) {
           rlife = ptlLifeTime_.get(randV);
        } else {
          rlife = random(1,5);
        }
        particles_[i].life_ = rlife * 1.5;
        particles_[i].reset_ = false;
        particles_[i].sleepTime_ = rlife * 1.5;
    }
  }

  public void drawAllParticles() {
    translate(baseX_, baseY_, baseZ_);
    for (int i=0; i<numParts_; i++) {
      float opacity = 1.0;
      if ( particles_[i].life_ != 0) {
        opacity = 1.0 - particles_[i].time_ / particles_[i].life_*0.5;
        if (opacity < 0 || opacity > 1.0) {
          println(opacity);
        }
      }
      //color heatC = color(255,128,128);//heatColorMap(opacity);
      //color C =  color(red(ptColor_), green(ptColor_), blue(ptColor_), opacity);
      //println(particles_[i].position_.y);
      drawParticleNew(particles_[i].position_, color(red(ptColor_), green(ptColor_), blue(ptColor_), opacity*256.0));
      //drawParticle(particles_[i].position_, opacity, ptsizeHalf_);
    }
    translate(-baseX_, -baseY_, -baseZ_);
  }
  public void evolveParticles() {
    for (int i=0; i < numParts_; i++) {
      particles_[i].evolve(partTimeAll_);
      if (particles_[i].reset_ == true) {
        float randv1 = random(-0.5,0.5);
        float randv2 = random(-0.5,0.5);
        particles_[i].position_.x = randv1*cellSizeX;
        particles_[i].position_.y = 0;
        particles_[i].position_.z = randv2*cellSizeY;
        particles_[i].velocity_.x = 0;
        particles_[i].velocity_.y = 0;
        particles_[i].velocity_.z = 0;
        particles_[i].time_ = 0;
        int randV = int(random(0,numList));
        float rlife = 0;
        if (ptlLifeTime_.size() > 0) {
           rlife = ptlLifeTime_.get(randV);
        } else {
          rlife = random(1,5);
        }
        particles_[i].life_ =  1.5 * rlife;
        particles_[i].reset_ = false;
      }
    }
  }
  public float partTimeAll_;
  public int numParts_;
  public particle [] particles_;
  public int numPartPerFrame_;
  public float ptsizeHalf_ = 2.5;
  public float baseX_;
  public float baseY_;
  public float baseZ_;
  public float cellX_;
  public float cellY_;
  public int numList;
  IntList ptlLifeTime_;
  public color ptColor_;
};