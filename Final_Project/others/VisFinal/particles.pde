void drawParticleNew(PVector center, color C) {
  stroke(C);
  point(center.x, center.y, center.z);
}

void drawEnlargeCirc(PVector center, PVector normaldir, color c, float rad, float phase) {
  float indicator =  (millis() + phase*1000) % 1000 * 0.001;
  float radius = indicator*rad;
  float alpha = 1.0 - indicator;
  if (alpha < 0) {
    alpha = 0;
  }
  PVector normalizedD = new PVector();
  normalizedD.x = normaldir.x;
  normalizedD.y = normaldir.y;
  normalizedD.z = normaldir.z;
  normalizedD.normalize();
  float angleRad = 2*PI - acos(normalizedD.dot(new PVector(0,0,1)));
  PVector axis = normalizedD.cross(new PVector(0,0,1));
  axis.normalize();
  pushMatrix();
  translate(center.x, center.y, center.z);
  rotate(angleRad, axis.x, axis.y, axis.z);
  stroke(c);
  lineShader.set("weight", 5.0);
  // lineShader.set("extAlpha", 1.0);
  
  strokeWeight(5);
  noFill();
  ellipse(0, 0, radius, radius);
  
  fill(red(c), green(c), blue(c), 64);
  ellipse(0,0,radius,radius);
  popMatrix();
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
  void evolve(Vec3D grav) {
    if (sleepTime_ < 0) {
      position_.x += velocity_.x * dt;
      position_.y += velocity_.y * dt;
      position_.z += velocity_.z * dt;
      time_ += dt;
      velocity_.x += grav.x;
      velocity_.y += grav.y;
      velocity_.z += grav.z;
      if (time_ > life_) {
          reset_ = true;
      }
    } else {
      sleepTime_ --;
    }
  }
}

public class Psystem {
  Psystem(int numPart, float baseX, float baseY, float baseZ, color ptColor, PVector gravity, float mag) {
    particles_ = new particle[numPart];
    numParts_ = numPart;
    for (int i = 0; i < numPart; i++) {
      particles_[i] = new particle();
    }
    mag_ = mag * 0.2;
    partTimeAll_ = 30.0;
    numPartPerFrame_ = numPart / (int)partTimeAll_;
    
    baseX_ = baseX;
    baseY_ = baseY;
    baseZ_ = baseZ;

    initPtlLifeTime();
    ptColor_ = ptColor;
    direction_ = new PVector();
    direction_.x = gravity.x;
    direction_.y = gravity.y;
    direction_.z = gravity.z;
    direction_.normalize();
    dir_ = new Vec3D(direction_.x, direction_.y, direction_.z);
    grav_ = new Vec3D(dir_.x * 0.05 * mag_, dir_.y * 0.05 * mag_, dir_.z*0.05*mag_);
    
  }
  
  public void initPtlLifeTime() {
    for (int i=0; i<numParts_; i++) {
      particles_[i].life_ = 30;
       particles_[i].sleepTime_ = random(0,30);
    }
  }
  
  public void drawAllParticles() {
    translate(baseX_, baseY_, baseZ_);
    strokeWeight(0.5);
    for (int i=0; i<numParts_; i++) {
      float opacity = 1.0;
      if ( particles_[i].life_ != 0) {
        opacity = 1.0 - particles_[i].time_ / particles_[i].life_*0.5;
        opacity = opacity*opacity;
        if (opacity < 0 || opacity > 1.0) {
          println(opacity);
        }
      }
      drawParticleNew(particles_[i].position_, color(red(ptColor_), green(ptColor_), blue(ptColor_), opacity*256.0));
    }
    translate(-baseX_, -baseY_, -baseZ_);
  }
  
  public void evolveParticles() {
    for (int i=0; i < numParts_; i++) {
      particles_[i].evolve(grav_);
      if (particles_[i].reset_ == true) {
        Vec3D dirR = rndSampleSphere(1.0, 2*PI, dir_);
        
        particles_[i].position_.x = 0;
        particles_[i].position_.y = 0;
        particles_[i].position_.z = 0;
        particles_[i].velocity_.x = dirR.x * mag_;
        particles_[i].velocity_.y = dirR.y * mag_;
        particles_[i].velocity_.z = dirR.z * mag_;
        particles_[i].time_ = 0;
        particles_[i].life_ = 30;
        particles_[i].reset_ = false;
      }
    }
  }
  public particle [] particles_;
  public int numParts_;
  public int numPartPerFrame_;
  public float partTimeAll_;
  public PVector direction_;
  public Vec3D dir_;
  public Vec3D grav_;
  public float baseX_;
  public float baseY_;
  public float baseZ_;
  public int numList;
  public color ptColor_;
  public float mag_;
}