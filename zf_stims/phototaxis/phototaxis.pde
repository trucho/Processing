float x,y;
float r = 100;
color gColor = color(255);
color bColor = color(0);

void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  rectMode(CENTER);
  x = width*2/3;
  y = height/2-20;
}
 
void draw () {
  background(bColor);
  fill(gColor);
  ellipse(x,y,r,r);
}