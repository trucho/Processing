class Predator {
  float x, y, speed, theta, r;
  float ix, iy;
  color c;
  int n = 6;
  float[] randomwalk = new float[width];
  int randindex;
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
    
    for (int i=0; i==width+r; i++){
      randomwalk[i] = random(-r/5, r/5);
    }
  }
  
  void update() {
    x = x + cos(theta)*speed;
    y = y + sin(theta)*speed;
    //y = y + randomwalk[round(x)] + sin(theta)*speed;
    
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