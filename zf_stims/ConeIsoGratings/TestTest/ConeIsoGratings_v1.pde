/**
 * Graphing 2D Equations
 * by Daniel Shiffman. 
 * 
 * Graphics the following equation: 
 * sin(n*cos(r) + 5*theta) 
 * where n is a function of horizontal mouse location.  
 */

float contrast = .99; //Weber contrast as fraction between 0 and 1 
 
int fps = 60;
float barWidth = 30; //10: not working well as of Mar18/20
float barSpeed = 5;//barWidth*5/fps; //*2: not working well as of Mar18/20
float x,y;
float r = 10;

color kColor = color(128-floor(128*contrast)); 
color wColor = color(128+floor(128*contrast));
//color nowColor = kColor; //initialize as ON
color nowColor = wColor; //initialize as OFF
int value = 1;
int direction = 1;
boolean upflag = true;
boolean directionFlag = false; 
int Timer_absStart = 0;
int Timer_absNow = 0;
int Timer_start = -1; // in ms
int Timer_now = -1; // in ms
int Timer_waitFor = 30 * 1000; // in ms
int Timer_runFor = 60 * 1000; // in ms
boolean autoRun = false;

void setup() {
  //size(800, 480, P2D); //adafruit screen
  size(1280, 800, P2D); //lcr4500
  frameRate(fps);
  noStroke();
  smooth();
  rectMode(CORNER);
  //gt = new grating(barWidth, barSpeed); //17.32*d2pixel = 125.96
  Timer_absStart = millis();
}

void draw() {
  loadPixels();
  //float d2pixel = 1280/110; // this should hold spatial calibration
  float dx = barWidth/width;    // Increment x this amount per pixel
  float dy = height;   // Increment y this amount per pixel
  x = 0;          // Start x at -1 * width / 2
  r = (r+(barSpeed*fps/1000));
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      float valMin = cos(x - r); // cos(x) c [-1 1]
      float valMinNorm = (valMin*contrast + 1.0)/2.0; // Scale to between 0 and 1
      float LminR = valMinNorm * 255;//0;
      float LminG = valMinNorm * 14;//14;
      float LminB = valMinNorm * 0;//255;
      float valMax = cos(x+PI - r); // cos(x+PI) c [-1 1]
      float valMaxNorm = (valMax*contrast + 1.0)/2.0; // Scale to between 0 and 1
      float LmaxR = valMaxNorm * 253;//255;
      float LmaxG = valMaxNorm * 13;//13;
      float LmaxB = valMaxNorm * 253;//253;
      
      color Liso = color(LmaxR+LminR,LmaxG+LminG,LmaxB+LminB);
      // Map resulting vale to color value
      pixels[i+j*width] = Liso;
      y += dy;                // Increment y
    }
    x += dx;                  // Increment x
  }
  updatePixels();
}
