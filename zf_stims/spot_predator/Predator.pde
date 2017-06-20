class Predator {
  float x, y, speed, theta, r;
  float ix, iy;
  color c;
  int n = 6;
  //PShape P;
  
  Predator (float pX, float pY, float pR, float pSpeed, float pDirection, color pColor){
    x = pX;
    y = pY;
    ix = pX;
    iy = pY;
    r = pR;
    speed = pSpeed;
    theta = pDirection;
    c = pColor;
    
    //P = createShape(ELLIPSE,x,y,r,r);
    //P.setFill(c);
  }
  
  void update() {
    x = x + cos(theta)*speed;
    y = y + random(-r/5, r/5) + sin(theta)*speed;
    
    if (x>width){
      x = ix;
      y = iy;
    }
  }
  void display() {
    //shape(P);
    fill(c);
    ellipse(x, y, r, r);
  }
}