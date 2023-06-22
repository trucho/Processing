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
float barWidth = 12.6*16; // 25.2 definitely works in adafruit screen
float barSpeed = 126/fps;
float x,y;
float r = 50;
float d2pixel = 800/110;
color kColor = color(000,000,000);
color wColor = color(255,255,255);
color lColor = color(200,0,0);
//grating gt;
int value = 0;
boolean upflag = true;


void setup() {
  //size(800, 480, P2D); //adafruit screen
  size(1280, 800, P2D); //lcr4500
  frameRate(fps);
  noStroke();
  smooth();
  rectMode(CORNER);
  //gt = new grating(barWidth, barSpeed); //17.32*d2pixel = 125.96
  
}

void keyPressed() {
  if(key == 'b') {
    if (value == 0) {
      value = 255;
    } else {
      value = 0;
    }
  }
  else if(key == 's') {
    if (upflag == false) {
      upflag = true;
    } else {
      upflag = false;
    }
  }
} 

void draw () {
  background(kColor);
  noFill();
  //fill(kColor);
  fill(value);
  // grating
  ellipse(width/2+450,height/2-220,100,100);
  ellipse(width/2+450,height/2-20,100,100);
  ellipse(width/2+450,height/2+200,100,100);
}
