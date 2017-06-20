float pSpeed = 3;
float pTheta = 0;
float pRadius = 20;
color pColor = color(125, 0, 0);
Predator p;
 
void setup() {
  size(500, 500, P2D);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  p = new Predator (0, height/2, pRadius, pSpeed, pTheta, pColor);
}
 
void draw () {
  background(0);
  p.update();
  p.display();
}