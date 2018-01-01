float x,y;
float r = 50;
color gColor = color(000,000,000);
color bColor = color(255,255,255);

void setup() {
  size(1300, 750, P2D);
  noStroke();
  smooth();
  rectMode(CENTER);
  x = width/4;
  y = height/2;
}
 
void draw () {
  background(bColor);
  fill(gColor);
  ellipse(x,y,r,r);
}