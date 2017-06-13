float x, y;
float easing = 0.05;
PVector circle = new PVector(750/2, 750/2);
int diameter = 750/2;
 
void setup() {
  size(750, 750);
  x = y = width/2;
  noStroke();
  smooth();
}
 
void draw () {
  background(0);
  fill(255);
  ellipse(circle.x, circle.y, diameter, diameter);
 
  PVector m = new PVector(mouseX, mouseY);
  if (dist(m.x, m.y, circle.x, circle.y) > diameter/2) {
    m.sub(circle);
    m.normalize();
    m.mult(diameter/2);
    m.add(circle);
  }
 
  fill(0, 0, 0);
  ellipse(m.x, m.y, 6, 6);
 
  x = x + (m.x - x) * easing;
  y = y + (m.y - y) * easing;
 
  fill(0, 0, 0);
  ellipse(x, y, 50, 50);
}