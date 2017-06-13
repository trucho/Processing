class donut {
  /* Using a donut to make aperture mask to restrict stimulus to arena size */
  float x, y, ri, ro;
  PShape s;

  donut (float donutX, float donutY, float innerR, float outerR) {
    x = donutX;
    y = donutY;
    ri = innerR;
    ro = outerR;

    // First create the shape
    s = createShape();
    s.beginShape();
    // Set fill and stroke
    s.fill(00);
    noStroke();
    // Exterior part of shape
    for (float a = 0; a < TWO_PI; a += 0.1) {
      s.vertex(cos(a)*ro, sin(a)*ro);
    }
    // Interior part of shape
    s.beginContour();
    for (float a = TWO_PI; a > 0; a -= 0.1) {
      s.vertex(cos(a)*ri, sin(a)*ri);
    }
    s.endContour();
    s.endShape(CLOSE);
  }
  
  void display(){
    translate(x,y);
    shape(s);
  }
}