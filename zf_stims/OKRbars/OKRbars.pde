// Created December 2019 (Angueyra: angueyra@nih.gov)
// Notes of OMR in larvae:
  // Neuhauss, 1999: "The stimulus movie consists of 20 frames of a 60° sine wave grating drifting across the monitor at 4 Hz for 5 min"
  // Sine-wave grating usbtending 60 degres of visual field modulated at 4Hz
  
  // Orger, 2000: 7dpf. Square-wave grating: each bar subtend 60 degrees of visual angle and drift at 1Hz for 30s. In methods, they explain angles are calculated for a fish located 15mm above screen
  // Following SOHCAHTOA, and dividing triangle in half: barWidth = [15 mm * tan(30)] * 2 = 17.32 mm. So each bar is about 1.7 cm wide.
  // Drift at 1Hz must mean that it moves 1.7 cm every second?
  
  // Richards, 2008: 2cm-wide bars drifting at 1Hz for 15 s in a shallow 30 cm x 1 cm tank.
  
  //Mu..., Ahrens, 2019: 2.5mm stripe width moving at 2.86 mm/s

  // The best way to do this would be to implement drawing of texture so that it would be possible to do sine vs square
  // Nov 2019: implemented bars that move but code was too limited requiring separate vertical and horizontal gratings and difficult masking (not done) to get corners.
  // Dec 2019: probably most economic way is to generate a matrix for x,y,phi and each bar loops through it. During first loop, opacity could ramp up.
  // Also, given dimensions of adafruit screen (5'' diagonal = 110 mm x 670 mm = 800 x 480pixels) 2 lids of 4-well plates could be tested at once.
  // Dec 2019: after calculating size of bar vs. size of lid, decided not worth taking a spiral approach. Made new chamber with 12-well plate lid and 3 channels with sylgard and will just have a linear stimulus following published work.

int fps = 60;
//float barWidth = 12.6*2; // 25.2 definitely works in adafruit screen
//float barWidth = 12.6*8; // 25.2 definitely works in adafruit screen
//float barSpeed = 126/fps;
// Read paper stating that they use sine wave with 56 mm wavelength and .98Hz frequency
// This should roughly translate to barWidth of 32 mm = 3.2 cm (HUGE!)
float barWidth = 125; //10: not working well as of Mar18/20
float barSpeed = barWidth*5/fps; //*2: not working well as of Mar18/20
float x,y;
float r = 50;
float d2pixel = 800/110;
float contrast = .5; //Weber contrast as fraction between 0 and 1
color kColor = color(128-floor(128*contrast)); 
color wColor = color(128+floor(128*contrast));
//color nowColor = kColor; //initialize as ON
color nowColor = wColor; //initialize as OFF
grating gt;
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
  gt = new grating(barWidth, barSpeed); //17.32*d2pixel = 125.96
  Timer_absStart = millis();
}

void keyPressed() {
  if(key == 'b') {
    if (value == 0) {
      value = 1;
      nowColor = wColor;
    } else {
      value = 0;
      nowColor = kColor;
    }
  }
  else if(key == 's') {
    if (upflag == false) {
      upflag = true;
    } else {
      upflag = false;
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
  value = 1;
  nowColor = wColor;
  Timer_start = Timer_absNow;
  autoRun = true;
}

void startStim(){
  value = 0;
  nowColor = kColor;
  //Timer_start = Timer_absNow;
  autoRun = true;
}

void stopStim(){
  value = 1;
  nowColor = wColor;
  Timer_start = -1;
  autoRun = false;
}

void draw () {
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
  
  background(wColor);
  noFill();
  fill(nowColor);
  // grating
  gt.update(upflag, directionFlag);
  gt.display();
}
