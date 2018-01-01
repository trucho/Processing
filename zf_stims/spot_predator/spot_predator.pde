float pSpeed = 2; //in pixels/frame
float pTheta = 0; //direction in rad
float pRadius = 100; //in pixels
color pColor = color(000,000,000);
color bColor = color(255,255,255);
int np = 5;
Predator[] p = new Predator[np];
 
void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  for (int i=0; i<np; i++){
    p[i] = new Predator (200, .3, pRadius, pSpeed, pTheta, pColor);
  }
}
 
void draw () {
  background(bColor);
  for (int i=0; i<np; i++){
    p[i].update();
    p[i].display();
  }
}