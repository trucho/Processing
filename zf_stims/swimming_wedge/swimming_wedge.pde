float maskR = 750/2;
float canvasX = 1300;
float canvasY = 750;
donut Mask;
wedges rotStim;
color backC = color(255, 0,0);
color foreC = color(0, 20, 0);
float nowS;

int nWedges = 50; //keep this number as even (not odd)
float rotPeriod = 40; //in seconds per cycle
float rotNow = 0;

void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  rectMode(CENTER);
  Mask = new donut(0, 0, maskR, canvasX);
  rotStim = new wedges(0, 0, canvasX*1.5, nWedges, foreC);
}

void draw () {
  translate(canvasX/2, canvasY/2); // make reference middile of the canvas
  background(backC);
  nowS = millis() / 1000.0;
  rotNow = TWO_PI*nowS/rotPeriod;
  rotate(rotNow);
  rotStim.display();
  //filter(BLUR,1);
  Mask.display();
}