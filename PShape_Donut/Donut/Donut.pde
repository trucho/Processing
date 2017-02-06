
/**
 * PrimitivePShape. 
 * 
 * Using a PShape to display a custom polygon. 
 */

// The PShape object
PShape s;

void setup() {
  size(640, 360, P2D);
  // First create the shape
  s = createShape();
  s.beginShape();
  // You can set fill and stroke
  s.fill(102);
  s.stroke(255);
  s.strokeWeight(2);
  // Here, we are hardcoding a series of vertices
  // Exterior part of shape
  float x = 0;
  // Calculate the path as a sine wave
  for (float a = 0; a < TWO_PI; a += 0.1) {
    s.vertex(cos(a)*100, sin(a)*100);
    x+= 5;
  }
  // Interior part of shape
  s.beginContour();
  for (float a = TWO_PI; a > 0; a -= 0.1) {
    s.vertex(cos(a)*20, sin(a)*20);
    x-= 5;
  }
  s.endContour();
  s.endShape(CLOSE);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(4);
  line(height/2,0,height/2,width);
  // We can use translate to move the PShape
  translate(mouseX, mouseY);
  //translate(width/2, height/2);
  // Display the shape
  shape(s);
}