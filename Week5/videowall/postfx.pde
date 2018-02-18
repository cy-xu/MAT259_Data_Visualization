
float current_color = 0;
float inc = 0.1;

float glitchLasttime = 0;
float glitchTime = 0;

float strobeLasttime = 0;
float strobeTime = 0;
PShader lines, glow, brightContrast, pixelate;

void initFX(){
  f_init_Lines(); 
  f_init_Glow(); 
  f_init_Pixelate();
  f_init_BrightnessContrast();
}

void updateFX(){
  // animate color
  current_color += inc;
  if(current_color > 30. || current_color < 0.){
    inc = -inc;
  }
  
  // animate shader
  glow.set("brightness", map(sin(millis()/2000), -1, 1, 0.2, 0.5)); // 0-0.5
  glow.set("radius", map(sin(millis()/2000), -1, 1, 1, 3));        // 0-3
}

void drawFX(){
  filter(glow);
    
  glitchFx();
  strobeFx();
  
  filter(lines);
}

// Glitch Effect
void glitchFx(){
  if(glitchLasttime+glitchTime > millis()){
    pixelate.set("pixels", random(1, 0.1 * width), random(1, 0.1 * height));

    glow.set("mask_c", 0., .0);
    glow.set("mask_d", 0.8, 1.);
    pixelate.set("mask_c", 0., .0);
    pixelate.set("mask_d", 0.8, 1.);

    filter(glow);
    filter(pixelate);
  }
}

// Strobe effect
void strobeFx(){
  if(strobeLasttime + strobeTime > millis()){
    brightContrast.set("brightness", random(-5, 5));
    brightContrast.set("contrast", random(-5, 5));

    brightContrast.set("mask_c", 0., .0);
    brightContrast.set("mask_d", 0.8, 1.);

    filter(brightContrast);
  }
  else{
    brightContrast.set("brightness", 1.);
    brightContrast.set("contrast", 1.);
    filter(brightContrast);
  }
}


void f_init_Lines() {
  lines = loadShader("texture/lines.glsl");

  lines.set("lineStrength", 0.01);
  lines.set("lineSize", 2000.);
  lines.set("lineTilt", 0.45);
}

void f_init_BrightnessContrast() {
  brightContrast = loadShader("texture/brightContrast.glsl");

  brightContrast.set("brightness", 1.0);
  brightContrast.set("contrast", 1.0);

  brightContrast.set("mask_c", 0.0, .0);
  brightContrast.set("mask_d", 0.8, 1.);
}

void f_init_Pixelate() {
  pixelate = loadShader("texture/pixelate.glsl");

  pixelate.set("pixels", 0.1 * width, 0.1 * height);

  pixelate.set("mask_c", 0.0, .0);
  pixelate.set("mask_d", 0.8, 1.);
}

void f_init_Glow() {
  glow = loadShader("texture/glow.glsl");

  glow.set("brightness", 0.1); // 0-0.5
  glow.set("radius", 1);        // 0-3

  glow.set("mask_c", 0.0, .0);
  glow.set("mask_d", 0.8, 1.);
}