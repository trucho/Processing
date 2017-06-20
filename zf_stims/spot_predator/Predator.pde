class Predator {
  float x, y, speed, theta, r;
  color c;
  int n = 6;
  //PShape P;
  
  Predator (float pX, float pY, float pR, float pSpeed, float pDirection, color pColor){
    x = pX;
    y = pY;
    r = pR;
    speed = pSpeed;
    theta = pDirection;
    c = pColor;
    
    //P = createShape(ELLIPSE,x,y,r,r);
    //P.setFill(c);
  }
  
  void update() {
    x = x + cos(theta)*speed;
    y = y + random(-r/20, r/20) + sin(theta)*speed;
    
    if (x>width){x=-r;}
  }
  void display() {
    //shape(P);
    fill(c);
    ellipse(x, y, r, r);
  }
}