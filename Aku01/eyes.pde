class eyes {
 /* Pupil follows mouse */
 float x, y, r, iod, rPupil;
 float easing = 0.85;
 
 PVector eyeball3, eyeballL, eyeballR;
 float pupil3x, pupil3y;
 float pupilLx, pupilLy;
 float pupilRx, pupilRy;
 
 eyes (float faceX, float faceY, float eyeR) {
   x = faceX;
   y = faceY;
   r = eyeR;
   iod = eyeR;
   rPupil = r/4;
   
   eyeball3 = new PVector(x,y);
   eyeballL = new PVector(x-iod,y-iod);
   eyeballR = new PVector(x+iod,y-iod);
   
   pupil3x = eyeball3.x;
   pupil3y = eyeball3.y;
   
   pupilLx = eyeballL.x;
   pupilLy = eyeballL.y;
   pupilRx = eyeballR.x;
   pupilRy = eyeballR.y;
 }
 
 void display() {
  fill(255);
  stroke(183,67,58);
  ellipse(eyeballL.x,eyeballL.y,r,r); //leftEye
  ellipse(eyeballR.x,eyeballR.y,r,r); //right Eye
  noStroke();
  fill(0);
  
  PVector p3 = new PVector(mouseX,mouseY);
  if (dist(p3.x, p3.y, eyeball3.x, eyeball3.y) > (r-rPupil)/2) {
    p3.sub(eyeball3);
    p3.normalize();
    p3.mult((r-rPupil)/2);
    p3.add(eyeball3);
  }
  pupil3x = pupil3x + (p3.x - pupil3x) * easing;
  pupil3y = pupil3y + (p3.y - pupil3y) * easing;

  pupilLx = pupil3x-iod;
  pupilLy = pupil3y-iod;
  
  pupilRx = pupil3x+iod;
  pupilRy = pupil3y-iod;
  
  
  fill(125);
  ellipse(pupilLx,pupilLy,rPupil,rPupil); //leftPupil
  ellipse(pupilRx,pupilRy,rPupil,rPupil); //rightPupil
 }
}