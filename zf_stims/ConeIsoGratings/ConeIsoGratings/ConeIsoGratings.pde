// Created December 2024 (Angueyra: angueyra@umd.edu)
/*
Notes of OMR in larvae:
  Neuhauss, 1999: "The stimulus movie consists of 20 frames of a 60° sine wave grating drifting across the monitor at 4 Hz for 5 min"
  Sine-wave grating subtending 60 degres of visual field modulated at 4Hz
  
  Orger, 2000: 7dpf. Square-wave grating: each bar subtend 60 degrees of visual angle and drift at 1Hz for 30s. In methods, they explain angles are calculated for a fish located 15mm above screen
  Following SOHCAHTOA, and dividing triangle in half: barWidth = [15 mm * tan(30)] * 2 = 17.32 mm. So each bar is about 1.7 cm wide.
  Drift at 1Hz must mean that it moves 1.7 cm every second?
  
  Richards, 2008: 2cm-wide bars drifting at 1Hz for 15 s in a shallow 30 cm x 1 cm tank.
  
  Mu..., Ahrens, 2019: 2.5mm stripe width moving at 2.86 mm/s
*/

/*
  Sep 2025 (Angueyra): Implemented drawing of texture that follows a sine
  Nov 2025 (Angueyra): Re-implemented OKRBars automations that make experiments runable
  Oct 2025 (Angueyra/Apgar): re-designed everything to emulate Orger and Baier, 2005:
     Reference Grating: 
       fixed contrast
        drifts in one direction. 
        For tbx2 experiments, this should be M-cone isolating.
      Test grating:
        variable contrast
        drifts in opposite direction. 
        For tbx2a experiments, this should be L-cone isolating.
      Experiment: 
        find contrast of test grating that reverses OKR direction
        corresponding to L-cone activation that matched M-cone activation (equiluminance)
        In tbx2a experiments, it should be harder to reverse (I think), since L cones will be sensitive to reference grating
  Oct 2025 (Angueyra):
    In this setup we start from a base color and do deviations in the M and L direction
    If testing on human, use peripheral vision
*/

// Keyboard shortcuts:
// B = Blank screen
// I = Invert direction
// S = Stop drifting
// M = Manual start of trial: 30s blank, 15s R, 15s L, 15s R, 15s L, Blank

float contrast = .0090; // Test grating's weber contrast as fraction between 0 and 1 

int[] baseColor = {128,48,34}; // this puts all cones in kind of mid-point activation
//int[] baseColor = {128,128,0};

//// L-isolating direction (Oct 27, 2025)
int[] Liso = {51,0,0};
//int[] Liso = {102,0,0};
//int[] Liso = {0,0,0};

//// M-isolating direction (Oct 27, 2025)
int[] Miso = {-51,11,0};
//int[] Miso = {-102,22,0};
//int[] Miso = {-0,0,0};

//// S-isolating direction (Oct 27, 2025)
int[] Siso = {51,-13,+16};

float barWidth = 30; //30; //Oct2025: needs spatial calibration; 30 ~ default for OKR bars
float barSpeed = 4.5;//4.5;//5 //Oct2025: needs spatial calibration; 5 ~ default for OKR bars


int fps = 60;
float x,y;
float phaseDrift = 0;

float nowRefContrast = 0;
float nowTestContrast = 0;
boolean blankFlag = true;
boolean stopFlag = false;
boolean directionFlag = false; 
int Timer_absStart = 0;
int Timer_absNow = 0;
int Timer_start = -1; // in ms
int Timer_now = -1; // in ms
int Timer_waitFor = 3 * 1000; // in ms
int Timer_runFor = 6 * 1000; // in ms
boolean autoRun = false;


// Arduino Interaction
//import processing.serial.*;
//Serial AUno;
//int ledAmp = 0;

void setup() {
  //size(800, 480, P2D); //adafruit screen
  size(1280, 800, P2D); //lcr4500
  frameRate(fps);
  noStroke();
  smooth();
  rectMode(CORNER);
  if (blankFlag == false) {
      nowRefContrast = 1.00;
      nowTestContrast = contrast;
  } else {
    nowRefContrast = 0.00;
    nowTestContrast = 0.00;
  }
  Timer_absStart = millis();
}

void keyPressed() {
  if(key == 'b') {
    if (blankFlag == false) {
      blankFlag = true;
      nowRefContrast = 1.00;
      nowTestContrast = contrast;
    } else {
      blankFlag = false;
      nowRefContrast = 0.00;
      nowTestContrast = 0.00;
    }
  }
  else if(key == 's') {
    if (stopFlag == false) {
      stopFlag = true;
    } else {
      stopFlag = false;
    }
  }
  else if(key == 'm') {
      print("autoRun START\n");
      waitStim();
  }
  else if(key == 'i') {
      print("direction change\n");
      switchDirection();
  }
} 

void switchDirection(){
  if (directionFlag) {directionFlag = false;}
    else {directionFlag = true;}
}

void waitStim(){
  blankFlag = true;
  nowRefContrast = 0.00;
  nowTestContrast = 0.00;
  Timer_start = Timer_absNow;
  autoRun = true;
}

void startStim(){
  blankFlag = false;
  nowRefContrast = 1.00;
  nowTestContrast = contrast;
  autoRun = true;
}

void stopStim(){
  blankFlag = true;
  nowRefContrast = 0.00;
  nowTestContrast = 0.00;
  Timer_start = -1;
  autoRun = false;
}

void draw() {
  
  Timer_absNow = millis()- Timer_absStart;
  if(autoRun == true) {
    if (Timer_absNow>(Timer_start+Timer_waitFor)) {
      if (Timer_absNow>(Timer_start+Timer_waitFor+Timer_runFor)) {
        stopStim();
        print("autoRun END\n\n");
      }
      else {
        if (Timer_absNow>Timer_start+Timer_waitFor+Timer_runFor*3/4) {directionFlag = true;}
        else if ((Timer_absNow>Timer_start+Timer_waitFor+Timer_runFor/4) && (Timer_absNow<Timer_start+Timer_waitFor+Timer_runFor/2)) {directionFlag = true;}
        else {directionFlag = false;} 
        startStim();
      }
    }
  }
  
  loadPixels();
  //float d2pixel = 1280/110; // this should hold spatial calibration
  float dx = barWidth/width;    // Increment x this amount per pixel
  float dy = height;   // Increment y this amount per pixel
  x = 0;          // Start x at -1 * width / 2
  if (stopFlag==false) {
    if (directionFlag) {
      phaseDrift = (phaseDrift-(barSpeed*fps/1000));
    }
    else {
      phaseDrift = (phaseDrift+(barSpeed*fps/1000));
    }
  }
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      float valTest = cos(x - phaseDrift); // cos(x) c [-1 1]
      float valTestNorm = nowTestContrast*((valTest + 1.0)/2.0); // Scale to between 0 and 1
      float TestR = valTestNorm * Liso[0];
      float TestG = valTestNorm * Liso[1];
      float TestB = valTestNorm * Liso[2];
      float valRef = cos(x+PI + phaseDrift); // cos(x+PI) c [-1 1]
      float valRefNorm = nowRefContrast*((valRef + 1.0)/2.0); // Scale to between 0 and 1
      float RefR = valRefNorm * Miso[0];
      float RefG = valRefNorm * Miso[1];
      float RefB = valRefNorm * Miso[2];
      
      color ConeIso = color(baseColor[0]+TestR+RefR,baseColor[1]+TestG+RefG,baseColor[2]+TestB+RefB);
      // Map resulting vale to color value
      pixels[i+j*width] = ConeIso;
      y += dy;                // Increment y
    }
    x += dx;                  // Increment x
  }
  updatePixels();
  //fill(0);
  //rect(120, 80, 220, 220);
}
