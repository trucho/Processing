class Predator {
  float x, y;
  float ri, rf, rnow;
  float speed;
  color c, bg;
  //PShape P;
  
  Predator (int pX, int pY, float pRi, float pRf, float pSpeed, color pColor, color bgColor){
    x = pX;
    y = pY;
    ri = pRi;
    rf = pRf;
    rnow = pRf;
    speed = pSpeed;
    c = pColor;
    bg = bgColor;
  }
  
  void update() {
    if (rnow<rf){
      rnow = rnow + speed;
    }
    //timer here and make disappear
  }
  
  void reset() {
    rnow = ri;
    c = pColor;
  }
  
  void display(color nowColor, color isiColor, boolean ref) {
    if (ref) {
      // ref lines
      stroke(0);
      strokeWeight(4);  // Default
      line(x, 0, x, y-(rf*1.1));
      line(x, y+(rf*1.1), x, displayHeight);
      line(0, y, x-(rf*1.1), y);
      line(x+(rf*1.1), y, displayWidth, y);
      stroke(isiColor);
      line(0, y, x-(rf*1.1), y);
    }
    //shape(P);
    noStroke();
    fill(nowColor);
    ellipse(x, y, rnow, rnow);
    
  }
}
