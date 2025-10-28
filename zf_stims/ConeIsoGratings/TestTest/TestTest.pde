/**
 * Graphing 2D Equations
 * by Daniel Shiffman. 
 * 
 * Graphics the following equation: 
 * sin(n*cos(r) + 5*theta) 
 * where n is a function of horizontal mouse location.  
 */
 
int fps = 60;
float barWidth = 6.4; //10: not working well as of Mar18/20
float barSpeed = barWidth*5/fps; //*2: not working well as of Mar18/20
float x,y;
float r = 50;
float d2pixel = 800/110;
float contrast = .50; //Weber contrast as fraction between 0 and 1
PVector Lmin_coeffs = new PVector(0,14,255);
PVector Lmax_coeffs = new PVector(255,13,253);
PVector Liso;
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

void calcPixelColor(float x){
  float valMin = cos(x);
  float valMinNorm = (valMin*contrast + 1.0)/2.0; // Scale to between 0 and 1
  PVector Lmin = Lmin_coeffs;
  Lmin = Lmin.mult(valMinNorm);
  
  
  print(Lmin);
}

void draw() {
  noLoop();
  print(Lmin_coeffs);
  float w = 32.0;         // 2D space width
  float dx = barWidth/width;    // Increment x this amount per pixel
  float dy = height;   // Increment y this amount per pixel
  float x = 0;          // Start x at -1 * width / 2
  float valMin = cos(x);
  float valMinNorm = (valMin*contrast + 1.0)/2.0; // Scale to between 0 and 1
  calcPixelColor(x);
  Lmin = Lmin_coeffs;
  
  float valMax = sin(x);
  float valMaxNorm = (valMax*contrast + 1.0)/2.0; // Scale to between 0 and 1
  Lmax = Lmax_coeffs.mult(valMaxNorm);
  
  Liso = Lmin.sub(Lmax);
  Liso = Liso.mult(255);
      
  print(Lmin);
}
