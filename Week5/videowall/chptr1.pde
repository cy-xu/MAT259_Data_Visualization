PGraphics chptr1;

// EDIT THESE
int resolutionX = 32;
int resolutionY = 32;
int octave = 8;

// Noise
PImage n;

//
int numPointsW;
int numPointsH_2pi;
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

void initializeSphere(int numPtsW, int numPtsH_2pi) {
  // The number of points around the width and height
  numPointsW = numPtsW + 1;
  numPointsH_2pi = numPtsH_2pi;  // How many actual pts around the sphere (not
                                 // just from top to bottom)
  numPointsH = ceil((float)numPointsH_2pi / 2) + 1;  // How many pts from top to
                                                     // bottom (abs(....) b/c of
                                                     // the possibility of an
                                                     // odd numPointsH_2pi)

  coorX =
      new float[numPointsW];  // All the x-coor in a horizontal circle radius 1
  coorY =
      new float[numPointsH];  // All the y-coor in a vertical circle radius 1
  coorZ =
      new float[numPointsW];  // All the z-coor in a horizontal circle radius 1
  multXZ = new float[numPointsH];  // The radius of each horizontal circle (that
                                   // you will multiply with coorX and coorZ)

  for (int i = 0; i < numPointsW; i++) {  // For all the points around the width
    float thetaW = i * 2 * PI / (numPointsW - 1);
    coorX[i] = sin(thetaW);
    coorZ[i] = cos(thetaW);
  }

  for (int i = 0; i < numPointsH; i++) {  // For all points from top to bottom
    if (int(numPointsH_2pi / 2) != (float)numPointsH_2pi / 2 &&
        i == numPointsH -
                 1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH = (i - 1) * 2 * PI / (numPointsH_2pi);
      coorY[i] = cos(PI + thetaH);
      multXZ[i] = 0;
    } else {
      // The numPointsH_2pi and 2 below allows there to be a flat bottom if the
      // numPointsH is odd
      float thetaH = i * 2 * PI / (numPointsH_2pi);

      // PI+ below makes the top always the point instead of the bottom.
      coorY[i] = cos(PI + thetaH);
      multXZ[i] = sin(thetaH);
    }
  }
}

void textureSphere(float rx, float ry, float rz, PImage n, PImage t) {
  // These are so we can map certain parts of the image on to the shape
  float changeU = t.width / (float)(numPointsW - 1);
  float changeV = t.height / (float)(numPointsH - 1);
  float u = 0;  // Width variable for the texture
  float v = 0;  // Height variable for the texture
  
  chptr1.rotateY(HALF_PI);
  chptr1.rotateX(HALF_PI);
  if(isWireframe){
    chptr1.strokeWeight(2);
    chptr1.stroke(130, 120);
  }
  else
    chptr1.noStroke();

  chptr1.beginShape(TRIANGLE_STRIP);
  if(isShaded)
    chptr1.texture(t);
  else
    chptr1.noFill();
    
  
  chptr1.rotate(noise(millis()/1000.)*TWO_PI*0.001, random(0,0.01), random(0,0.01), random(0,0.01));  
    
  for (int i = 0; i < (numPointsH - 1);
       i++) {  // For all the rings but top and bottom
    // Goes into the array here instead of loop to save time
    
    
    float coory = coorY[i];
    float cooryPlus = coorY[i + 1];

    float multxz = multXZ[i];
    float multxzPlus = multXZ[i + 1];

    for (int j = 0; j < numPointsW; j++) {  // For all the pts in the ring
      float disp_coeff = 0.5; // displacement coefficient

      color c = n.pixels[int(v * n.width + u)];
      float d = map(red(c)/3.+green(c)/3.+blue(c)/3., 0, 255, 1-disp_coeff, 1+disp_coeff);

      chptr1.normal(-coorX[j] * multxz, -coory, -coorZ[j] * multxz);
      chptr1.vertex(coorX[j] * multxz * (rx*d), coory * (ry*d), coorZ[j] * multxz * (rz*d),
             u, v);
    
      c = n.pixels[int((v+changeV) * n.width + u)%n.pixels.length];
      d = map(red(c)/3.+green(c)/3.+blue(c)/3., 0, 255, 1-disp_coeff, 1+disp_coeff);
    
      chptr1.normal(-coorX[j] * multxzPlus, -cooryPlus, -coorZ[j] * multxzPlus);
      chptr1.vertex(coorX[j] * multxzPlus * (rx*d), cooryPlus * (ry*d),
             coorZ[j] * multxzPlus * (rz*d), 
             u, v + changeV);
      u += changeU;
    }
    v += changeV;
    u = 0;
  }
  chptr1.endShape();
}

PerlinNoise noise;

void initChptr1()
{
   noise = new PerlinNoise();
   chptr1 = createGraphics((int)_w, (int)_h, P3D);
   
   n = createImage(resolutionX, resolutionY, RGB);
   updateNoise();
}

void drawChptr1()
{
  if(chptr1 != null){  
    
    updateNoise();
    
    float[][] perlinNoise = noise.DemoGradientMap(resolutionX, resolutionY, octave);
    color[][] c = noise.DemoColorify(perlinNoise);
    
    PImage noise = getPImage(perlinNoise);
    PImage coloredNoise = getPImage(c);
    
    chptr1.beginDraw();
    chptr1.translate(_w/2,_h/2,0);
    //chptr1.rotateX(PI*noise.pixels[0]); 
    chptr1.background(0,0);
    if(isLight){
      chptr1.lights();
    }
    //println("color: ", coloredNoise.width, coloredNoise.height);
    chptr1.translate(0,0,-_h);
    textureSphere(_h, _h, _h, n, n);
    chptr1.endDraw();
  }
  
}

void updateNoise() {
  float interval = 1000;
  
  n.loadPixels();
  for(int i = 0; i < n.height; i++){
    for(int j = 0; j < n.width; j++){
      float second = in.left.get(i*n.height+j)*10;
      
      // effects
      if(second > 0.75){
        glitchLasttime = millis();
        glitchTime = 100;
      }
      if(second < -.75){
        strobeLasttime = millis();
        strobeTime = 50;
      }
      
      float y = noise(second+j, second+i, second);
      n.pixels[i*n.width+j] = color((int)map(y, 0, 1, 100, 160));
    }
  }
  n.updatePixels();
}





class PerlinNoise {
  color gradientStart = color(255);
  color gradientEnd = color(0);

  void setGradientColors(color s, color e) {
    gradientStart = s;
    gradientEnd = e;
  }

  float[][] DemoGradientMap(int width, int height, int octaveCount) {
    if (octaveCount < 1) octaveCount = 8;

    return GeneratePerlinNoise(width, height, octaveCount);
  }
  
  color[][] DemoColorify(float[][] p){
    if(isColor)
      return ColorifyGradient(p);
    else{
      noise.setGradientColors(color(255), color(0));
      return MapGradient(gradientStart, gradientEnd, p);
    }
  }

  float[][] GeneratePerlinNoise(int w, int h, int octaveCount) {
    float[][] baseNoise = GenerateWhiteNoise(w, h);

    return GeneratePerlinNoise(baseNoise, octaveCount);
  }

  float[][] GenerateWhiteNoise(int width, int height) {
    float[][] noise = new float[width][height];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        noise[i][j] = noise(in.right.get(i*width+j)*10, i, j );
      }
    }

    return noise;
  }

  float Interpolate(float x0, float x1, float alpha) {
    return x0 * alpha + (1-alpha) * x1;
  }

  color Interpolate(color col0, color col1, float alpha) {
    float beta = 1 - alpha;
    return color((int)(red(col0) * alpha + red(col1) * beta),
                 (int)(green(col0) * alpha + green(col1) * beta),
                 (int)(blue(col0) * alpha + blue(col1) * beta));
  }

  color Getcolor(color gradientStart, color gradientEnd, float t) {
    float u = 1 - t;

    color c = color((int)(red(gradientStart) * u + red(gradientEnd) * t),
                    (int)(green(gradientStart) * u + green(gradientEnd) * t),
                    (int)(blue(gradientStart) * u + blue(gradientEnd) * t));

    return c;
  }

  color[][] ColorifyGradient(float[][] perlinNoise) {
    int width = perlinNoise.length;
    int height = perlinNoise[0].length;

    color[][] image = new color[width][height];

    float maxPerlin = 0, minPerlin = 999;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        minPerlin = min(perlinNoise[i][j], minPerlin);
        maxPerlin = max(perlinNoise[i][j], maxPerlin);
      }
    }
    
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        float v = map(perlinNoise[i][j], minPerlin, maxPerlin, -0.5, 1);
        if(v < -0.2500)
          image[i][j] = Interpolate(color(0,0,128), color(0,0,255), map(v, -1, -0.25, 0, 1));
        else if(v < 0.0)
          image[i][j] = Interpolate(color(0,0,255), color(0, 128, 255), map(v, -0.25, 0, 0, 1));
        else if(v < 0.0625)
          image[i][j] = Interpolate(color(0, 128, 255), color(240, 240,  64), map(v, 0, 0.0625, 0, 1));
        else if(v < 0.1250)
          image[i][j] = Interpolate(color(240, 240,  64), color(32, 160,   0), map(v, 0.0625, 0.1250, 0, 1));
        else if(v < 0.3750)
          image[i][j] = Interpolate(color(32, 160,   0), color(224, 224,   0), map(v, 0.1250, 0.3750, 0, 1));
        else if(v < 0.7500)
          image[i][j] = Interpolate(color(224, 224,   0), color(128, 128, 128), map(v, 0.3750, 0.75, 0, 1));
        else if(v < 1.0)
          image[i][j] = Interpolate(color(128, 128, 128), color(255), map(v, 0.75, 1, 0, 1));
      }
    }
    return image;
  }

  color[][] MapGradient(color gradientStart, color gradientEnd,
                        float[][] perlinNoise) {
    int width = perlinNoise.length;
    int height = perlinNoise[0].length;

    color[][] image = new color[width][height];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        image[i][j] = Getcolor(gradientStart, gradientEnd, perlinNoise[i][j]);
      }
    }

    return image;
  }

  float[][] GenerateSmoothNoise(float[][] baseNoise, int octave) {
    int width = baseNoise.length;
    int height = baseNoise[0].length;

    float[][] smoothNoise = new float[width][height];

    int samplePeriod = 1 << octave;  // calculates 2 ^ k
    float sampleFrequency = 1.0f / samplePeriod;

    for (int i = 0; i < width; i++) {
      // calculate the horizontal sampling indices
      int sample_i0 = (i / samplePeriod) * samplePeriod;
      int sample_i1 = (sample_i0 + samplePeriod) % width;  // wrap around
      float horizontal_blend = (i - sample_i0) * sampleFrequency;

      for (int j = 0; j < height; j++) {
        // calculate the vertical sampling indices
        int sample_j0 = (j / samplePeriod) * samplePeriod;
        int sample_j1 = (sample_j0 + samplePeriod) % height;  // wrap around
        float vertical_blend = (j - sample_j0) * sampleFrequency;

        float top =
            Interpolate(baseNoise[sample_i0][sample_j0],
                        baseNoise[sample_i1][sample_j1], horizontal_blend);

        // blend the bottom two corners
        float bottom =
            Interpolate(baseNoise[sample_i0][sample_j1],
                        baseNoise[sample_i1][sample_j1], horizontal_blend);

        // final blend
        smoothNoise[i][j] = Interpolate(top, bottom, vertical_blend);
      }
    }

    return smoothNoise;
  }

  float[][] GeneratePerlinNoise(float[][] baseNoise, int octaveCount) {
    int width = baseNoise.length;
    int height = baseNoise[0].length;

    float[][][] smoothNoise =
        new float[octaveCount][][];  // an array of 2D arrays containing

    float persistance = 0.7f;

    // generate smooth noise
    for (int i = 0; i < octaveCount; i++) {
      smoothNoise[i] = GenerateSmoothNoise(baseNoise, i);
    }

    float[][] perlinNoise = new float[width][height];

    float amplitude = 1.0f;
    float totalAmplitude = 0.0f;

    // blend noise together
    for (int octave = octaveCount - 1; octave >= 0; octave--) {
      amplitude *= persistance;
      totalAmplitude += amplitude;
      
      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          perlinNoise[i][j] += smoothNoise[octave][i][j] * amplitude;
        }
      }
      
    }

    // normalisation
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        perlinNoise[i][j] /= totalAmplitude;
      }
    }

    return perlinNoise;
  }

  color[][] MapToGrey(float[][] greyValues) {
    int width = greyValues.length;
    int height = greyValues[0].length;

    color[][] image = new color[width][height];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int grey = (int)(255 * greyValues[i][j]);

        image[i][j] = color(grey);
      }
    }

    return image;
  }

  color[][] BlendImages(color[][] image1, color[][] image2,
                        float[][] perlinNoise) {
    int width = image1.length;
    int height = image1[0].length;

    color[][] image = new color[width][height];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        image[i][j] =
            Interpolate(image1[i][j], image2[i][j], perlinNoise[i][j]);
      }
    }

    return image;
  }

  float[][] AdjustLevels(float[][] image, float low, float high) {
    int width = image.length;
    int height = image[0].length;

    float[][] newImage = new float[width][height];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        float col = image[i][j];

        if (col <= low) {
          newImage[i][j] = 0;
        } else if (col >= high) {
          newImage[i][j] = 1;
        } else {
          newImage[i][j] = (col - low) / (high - low);
        }
      }
    }

    return newImage;
  }

  color[][][] AnimateTransition(color[][] image1, color[][] image2,
                                int frameCount) {
    color[][][] animation = new color[frameCount][][];

    float low = 0;
    float increment = 1.0f / frameCount;
    float high = increment;

    float[][] perlinNoise = AdjustLevels(
        GeneratePerlinNoise(image1.length, image1[0].length, 9), 0.2f, 0.8f);

    for (int i = 0; i < frameCount; i++) {
      AdjustLevels(perlinNoise, low, high);
      float[][] blendMask = AdjustLevels(perlinNoise, low, high);
      animation[i] = BlendImages(image1, image2, blendMask);
      // SaveImage(animation[i], "blend_animation" + i + ".png");
      // image(MapToGrey(blendMask), 0, 0);
      low = high;
      high += increment;
    }

    return animation;
  }
}

void printMatrix(color[][] c){
  for (int i = 0; i < c.length; i++) {
    for (int j = 0; j < c[0].length; j++) {
      print(c[i][j]);
    }
    println(' ');
  }
}

void printMatrix(float[][] c) {
  for (int i = 0; i < c.length; i++) {
    for (int j = 0; j < c[0].length; j++) {
      print(c[i][j]);
    }
    println(' ');
  }
}

PImage getPImage(color[][] c) {
  PImage temp = createImage(c.length, c[0].length, RGB);
  temp.loadPixels();
  for (int i = 0; i < c.length; i++) {
    for (int j = 0; j < c[0].length; j++) {
      temp.pixels[i * c[0].length + j] = c[i][j];
    }
  }
  temp.updatePixels();

  return temp;
}

PImage getPImage(float[][] c) {
  PImage temp = createImage(c.length, c[0].length, RGB);
  temp.loadPixels();
  for (int i = 0; i < c.length; i++) {
    for (int j = 0; j < c[0].length; j++) {
      temp.pixels[i * c[0].length + j] = color(map(c[i][j], 0, 1, 0, 255));
    }
  }
  temp.updatePixels();

  return temp;
}