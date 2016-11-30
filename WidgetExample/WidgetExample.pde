float dx=10;  // Inital x position
float dy=620; // Inital y position
float dyi=620;
float vx=0;  // Inital x velocity
float vy=0; //Inital v velocity, remember negative y is up
float t=.1;  // Time steps
float g=9.8; // Acceleration due to gravity, where each pixel = 1 meter
float vyf=0; // Final Velocity
float r=.85; // Coeficient of Restitution (Bounciness)
float aimX=50;
float aimY=320;
int angle = 0;
int dySlider=25;
int vi=0;
boolean launch=false;
float time=0.000;
float projAngle;
float projV;

void setup()
{
  size(900, 630);
  smooth();
  background(100);
//  frameRate (30/t);
  textSize(20);
}

void draw ()
{
  background(100);
  strokeWeight(1);
  fill(255);
  ellipse (50, height/2, 50, 50);
  ellipse (dx, dy, 20, 20);
//  ellipse (10, dy, 20,20);
//  if(dy<619)
//  {
//  vectors();
//  }
  fill(180);
  rect(25, 25, 90, 25);
  rect(25, 75, 90, 25);
  strokeWeight(6);
  line(dySlider, 25, dySlider, 50);
  text(620-dyi+" m", 125, 50);
//  text("m", 215, 50);
  line(vi+25, 75, vi+25, 100);
  text(vi+" m/s", 125, 100);
//  text("m/s", 155, 100);
  text("Time =", 700,50);
  text(time, 770,50);
  text("s",835,50);
  pushMatrix();
  translate(50, height/2);
  rotate(radians(angle));
  line(0, 0, vi, 0);
  line(vi, 0, vi-10, -10);
  line(vi, 0, vi-10, 10);
  popMatrix();
  if (launch)
  {
    vyf=vy+g*t;
    dy=dy+vy*t+.5*(vyf-vy)*t;
    vy=vyf;
    dx=dx+vx*t;
    if(dy<height-10)
    {
    time=time+t;
    }
  }
  if (dy>(height-10))
  {
    dy=height-10;
    vy=0;
    vx=0;
    if (dx<770)
    {
    text(dx-10+"m", dx+15, height-2);
//    text("m", dx+90, height-2);
    }
    else
    {
    text(dx-10+"m", dx-110, height-2);
//    text("m", dx-30, height-2);
    }    
  }

  if (dx>(width-10))
  {
    dx=width-10;
    vx=vx*(-r);
  }
}

void mouseDragged()
{
  if (mouseX > 25 && mouseX < 115  && mouseY > 25 && mouseY < 50 && dx<11)
  {
    dySlider=mouseX;
    dyi=map(mouseX, 25,115,620,150);
    dy=dyi;
  }
  else if (mouseX > 25 && mouseX < 115  && mouseY > 75 && mouseY < 100 && dx<11)
  {
    vi=mouseX-25;
  }
}

void mouseReleased()
{
  if (dx<11)
  {
    vx=vi;
    launch=true;
    time=0;
  }
}

void mousePressed()
{
  launch=false;
  dx=10;
  dy=dyi;
  vy=0;
}

//void vectors()
//{
//  strokeWeight(2);
//  line(dx,dy,vx+dx,dy);
//  line(vx+dx,dy,vx+dx-5,dy-5);
//  line(vx+dx,dy,vx+dx-5,dy+5);
//  line(dx,dy,dx,dy+vy);
//  if (vy!=0)
//  {
//  line(dx,dy+vy,dx-5,dy+vy-5*vy/abs(vy));
//  line(dx,dy+vy,dx+5,dy+vy-5*vy/abs(vy));
//  }
////  projV=sqrt(vx*vx+vy*vy);
//////  projV = dist(dx,dy,dx+vx,dy+vy);
////  projAngle = sin(vy/projV);
////  println(degrees(projAngle));
////  pushMatrix();
////  translate(dx,dy);
////  rotate(projAngle);
////  line(0,0,projV,0);
////  line(projV,0,projV-5,-5);
////  line(projV,0,projV-5,+5);
////  popMatrix();
//  
//  strokeWeight(1);
//}

//void keyPressed()
//{
//  save("Default.png");
//}
