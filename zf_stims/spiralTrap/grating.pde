class grating {
  float x,y,h,w,dX;
  int nBars;
  float sp;
  float[] grateArray;
  
  grating (float grateX, float grateY, float grateH, float grateW, float deltaX, float grateSp) {
    x = grateX;
    y = grateY;
    h = grateH;
    w = grateW;
    dX = deltaX;
    sp = grateSp;
    
    nBars = floor(h/dX);
    //nBars = 1;
    
    grateArray = new float[floor(h)];
    for (int i = 0; i < nBars; i++) {
        grateArray[i] = -(dX*2*nBars/2) + (dX*2*i);
    }
    
  }
  
  void update() {
    for (int i = 0; i < nBars; i++) {
        //grateArray[i] = grateArray[i]+sp;
    }
  }
  
  void display() {
    for (int n = 0; n < nBars; n++){
      rect(x,grateArray[n],w,dX);
    }
  }
}
