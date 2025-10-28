float pix2mm = 24; //needs calibrated everytime setup moves;
int fps = 30; //frames per s

int pX = 490; //in pixels
int pY = 360; //in pixels

float pRiRW = 10/10000; //initial radius in mm
float pRfRW = 10; //final radius in mm
float pRi = pRiRW * pix2mm; //initial radius in pixels
float pRf = pRfRW * pix2mm; //final radius in pixels

float pSpeedRW = 10; //in mm/s (Real World)
float pSpeed = pSpeedRW * pix2mm / fps ; //in pixels/frame
float pContrast = 1; // dark predator over white background

color pColor = color(255 - (255*pContrast),255 - (255*pContrast),255 - (255*pContrast));
color bgColor = color(255,255,255);
color nowColor = color(255);

int Timer_absStart = 0;
int Timer_absNow = 0;
int Timer_now = 0; // in ms
int Timer_start = 0; // in ms
int Timer_runFor = 5 * 1000; // in ms
int Timer_waitFor = 1 * 10 * 1000; // in ms

boolean ref = true;
boolean firstRun = true;
color isiColor = color(0);

int np = 1;

Predator[] p = new Predator[np];
 
void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  for (int i=0; i<np; i++){
    p[i] = new Predator (pX, pY, pRi, pRf, pSpeed, pColor, bgColor);
  }
  Timer_absStart = millis(); //timestamp of sketch start
  // should have here option of saving csv log of sketch run
  // should have here arduino code to trigger stimulus with camera or trigger camera with stimulus
}

void keyPressed() {
  if(key == 'b') {
    for (int i=0; i<np; i++){
      p[i].reset();
    }
  }
  
  if(key == 's') {
    firstRun = false;
    for (int i=0; i<np; i++){
      p[i].reset();
    }
    startStim();
  }
} 

void startStim(){
  nowColor = pColor;
  Timer_now = 0;
  Timer_start = Timer_absNow;
}

void draw () {
  Timer_absNow = millis()- Timer_absStart;
  background(bgColor);
  if (!firstRun) {
    if (Timer_absNow>(Timer_start+Timer_runFor)) {
      nowColor = bgColor;
    }
    else {
      nowColor = pColor;
    }
    
    if (Timer_absNow>(Timer_start+Timer_waitFor)) {
      isiColor = color(0);
    }
    else {
      isiColor = color(255,0,0);
    }
  }
  for (int i=0; i<np; i++){
    p[i].update();
    p[i].display(nowColor, isiColor, ref);
  }
}
