float x,y;
float r = 50;
float d2pixel = 1100 /800;
float lidx = 625 * d2pixel/2; 
float wall_w = 2 * d2pixel;
color gColor = color(000,000,000);
color bColor = color(255,255,255);
color lColor = color(200,200,200);
grating gt;

void setup() {
  size(800, 480, P2D); //screen physical size = 1100 mm x 670 mm
  noStroke();
  smooth();
  rectMode(CORNER);
  
  gt = new grating(lidx*2/3,0,lidx,lidx/3,40,.2);
  
}
 
void draw () {
  background(bColor);
  noFill();
  stroke(lColor);
  rect(0,0,lidx,lidx);
  fill(lColor);
  rect((lidx*2/3)-wall_w,0,wall_w,lidx*2/3);
  rect(lidx/3,lidx*2/3,lidx/3,wall_w);
  rect(lidx/3,lidx/3,wall_w,lidx/3);
  
  noStroke();
  fill(gColor);
  gt.update();
  gt.display();
}
