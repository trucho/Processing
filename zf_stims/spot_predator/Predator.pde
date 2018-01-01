class Predator {
  float x, y, speed, theta, r;
  float ix, iy;
  color c;
  int n = 6;
  float[] randomwalk = new float[width];
  int randindex;
  //PShape P;
  
  Predator (float pX, float pY, float pR, float pSpeed, float pDirection, color pColor){
    x = pX+random(0,width/4);
    y = height*random(pY*100,(1-pY)*100)/100;
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
    
    if (x>width*.75){
      x = ix;
      y = height*random(iy*100,(1-iy)*100)/100;
      //speed = speed + random(-speed*100,+speed*100)/(100*2);
    }
  }
  void display() {
    //shape(P);
    fill(c);
    ellipse(x, y, r, r);
  }
}