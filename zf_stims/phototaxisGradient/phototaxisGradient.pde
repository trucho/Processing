// Created January 2020 (Angueyra: angueyra@nih.gov)
// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
color backColor;
int fps = 60;
boolean direction = true;


void setup() {
  //size(800, 480, P2D); //adafruit screen
  size(1280, 800, P2D); //lcr4500
  frameRate(fps);
  backColor = color(0);
  // Define colors
  b1 = color(255);
  b2 = color(0);
  //c1 = color(204, 102, 0);
  //c2 = color(0, 102, 153);
}

void keyPressed() {
  if(key == 'b') {
    if (b1 == color(255)) {
      b1 = color(0);
      b2 = color(0);
      backColor = color(0);
    } else {
      b1 = color(255);
      b2 = color(0);
      backColor = color(0);
    }
  }
  else if(key == 'w') {
    if (b2 == color(0)) {
      b1 = color(255);
      b2 = color(255);
      backColor = color(255);
    } else {
      b1 = color(255);
      b2 = color(0);
      backColor = color(0);
    }
  }
  else if(key == 'g') {
      b1 = color(255);
      b2 = color(0);
      backColor = color(0);
  }
  else if(key == 'l') {
    if (direction) {
      direction = false;
    } else {
      direction = true;
    }
  }
} 

void draw() {
  fill(backColor);
  rect(0,0,width,height);
  // Background
  if(direction) {
    setGradient(0, 0, round(width*.75), height, b1, b2, X_AXIS);
  }
  else {
    setGradient(round(width*.25), 0, width, height, b2, b1, X_AXIS);
  }
  // Foreground
  //setGradient(50, 90, 540, 80, c1, c2, Y_AXIS);
  //setGradient(50, 190, 540, 80, c2, c1, X_AXIS);
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
