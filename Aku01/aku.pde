class aku {
 /* Pupil follows mouse */
 float x, y;
 float aku_scale;
 eyes Eyes;
 nose Nose;
 
 aku (float faceX, float faceY, float faceScale) {
    x = faceX;
    y = faceY;
    aku_scale = faceScale;
    Eyes = new eyes(x,y,50);
    Nose = new nose(x,y);
 }
 
 void display() {
   Eyes.display();
   //Nose.display();
 }
}