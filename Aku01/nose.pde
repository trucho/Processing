class nose {
 /* Nose */
 float x, y;
 float rd = 10;
 
 
 nose (float faceX, float faceY) {
   x = faceX;
   y = faceY;
 }
 
 void display() {
  fill(255,0,0);
  noStroke();
  translate(x,y-20);
  ellipse(0,0,rd,rd);
  ellipse(-42,-25,rd,rd);
  ellipse(-48,-15,rd,rd);
  ellipse(-21,11,rd,rd);
  ellipse(-61,-1,rd,rd);
  ellipse(-66,30,rd,rd);
  ellipse(0,67,rd,rd);
  
 }
}