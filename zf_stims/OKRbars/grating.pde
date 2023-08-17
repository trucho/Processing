class grating {
  float barW, barSp, barH, barMax, barMin;
  int nBars;
  float[] barX;
  float[] barY;
  float[] barR;
  
  grating (float barWidth, float barSpeed) {
    barW = barWidth;
    barSp = barSpeed;
    barH = height;
    
    nBars = ceil((width)/barW);
    if (isEven(nBars)) {
     nBars = nBars+1; 
    }
    barMax = (barW * nBars)+ barW*2;
    barMin = -barW;
    barX = new float[nBars];
    barY = new float[nBars];
    barR = new float[nBars];
    for (int n = 0; n < nBars; n++){
      barX[n] = (barW*(n)*2)-barW;
      barY[n] = 0;
      barR[n] = 0;
    }
    
  }
  
  void update(boolean upflag, boolean directionFlag) {
    if (upflag) {
      for (int n = 0; n < nBars; n++){
        if (directionFlag) {
          barX[n] = barX[n] + barSp;
          if (barX[n]>barMax) {barX[n] = -barW;}
        }
        else {
          barX[n] = barX[n] - barSp;
          if (barX[n]<barMin) {barX[n] = barMax;}
        }
      }
    }
  }
  
  boolean isEven(int n) {
      return (n & 1) == 0;
    }
  
  void display() {
    for (int n = 0; n < nBars; n++){
      //translate(x[n],y[n]);
      //rotate(rho[n]);
      //translate(dY/2,dX/2);
      rect(barX[n],barY[n],barW,barH);
      //translate(-dY/2,-dX/2);
      //rotate(-rho[n]);
      //translate(-x[n],-y[n]);
    }
  }
}
