let scaleFactor = 1;
let canvasSize;
let sBars = [];
let nBars = 4
let xValues = [];
let wBars;
let modeFlag;
let interval = 0.2;

// still need to make variable intervals for gray frame 

class splitBar {
  constructor(x, y, w, h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.color1 = '#1BCC07';
    this.color2 = '#BF141B';
  }
  
  display(mode) {
    //noStroke();
    if (mode==1) {
      fill(this.color1);
      rect(this.x,this.y,this.w,this.h);}
    else if(mode==3) {
      fill(this.color1);
      rect(this.x+this.w/2,this.y,this.w,this.h);}
    else if(mode==2) {

    }
  }
}

function setup() {
  canvasSize = 1024/scaleFactor;
  createCanvas(canvasSize, canvasSize);
  modeFlag = 1;
  wBars = canvasSize/(2*nBars);
  for (let i = 0; i < nBars; i++) {
    xValues[i] = wBars * 2 * i;
    sBars.push(new splitBar(xValues[i],0,wBars,height));
  }
  frameRate(30);
}


function draw() {
  //background('#BF141B');
  if(frameCount % (interval * 30) == 0){
    if(modeFlag==1){
      modeFlag=2;
      background('#888888');
      //background('#1BCC07');
    }
    else if(modeFlag==2){
      modeFlag=3;
      background('#BF141B');
    }
    else if(modeFlag==3){
      modeFlag=1;
      background('#BF141B');
    }
  }
  for (let i = 0; i < nBars; i++) {
    sBars[i].display(modeFlag)
  }

}
