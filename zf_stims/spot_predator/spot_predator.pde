float pSpeed = 3;
float pTheta = 0;
float pRadius = 100;
color pColor = color(0);
int np = 5;
Predator[] p = new Predator[np];
 
void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  for (int i=0; i<np; i++){
    p[i] = new Predator (0, random(0,height), pRadius, pSpeed+random(0,10), pTheta, pColor);
  }
}
 
void draw () {
  background(255);
  for (int i=0; i<np; i++){
    p[i].update();
    p[i].display();
  }
}