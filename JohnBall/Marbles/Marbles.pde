//Create array to hold our balls. I wouldn't mess with this much!
int NBalls = 2;
Ball[] balls = new Ball[NBalls];


float dt = 0.1;           //Time scaling factor. Higher => faster, more unstable
boolean unClicked = true;       //Must be true for correct functioning

//Here's the set of parameters to play with
boolean quickAddMode = true;    //False-> one ball per click. True->hold to create many
boolean randomSizes = false;    //False-> same size for all. True->pick from range

float rad_min = 5;            //Smallest radius when randomSizes = true
float rad_max = 20;           // Largest radius when randomSizes = true
float rad_const = 25;         //Radius when randomSizes = false

float jiggle_coefficient = 10;     //Suggested range: 0.0->50.0 
float drag_coefficient = 1;       //Suggested range: 0.1->5.0
float push_coefficient = 20;      //Suggested range: 2.0->25.0
float pull_coefficient = 5;      //Suggested range: 0.1->20.0
    
void setup() {
    size(500,400);
    
    //Initialize the first few 
    for(int n=0; n < balls.length(); n++) {
        balls[n] = new Ball(250,200);
    }
}


void draw() {
    //Clear background
    background(0);
    
    //Accumulate push/pull forces for each possible pair
    for(int m=0; m<balls.length(); m++) {
      for(int n=0; n<balls.length(); n++) {
        if(m!=n) {
          balls[m].addForces(balls[n]);
        }
      }
    }
    
    //Draw each
    for(int n=0; n<balls.length(); n++) {
        balls[n].update();
    }
    
    //Add new members when the user clicks (quickAddMode adds them....rapidly)
    if(mousePressed && (unClicked || quickAddMode)) {
        balls = append(balls, new Ball(mouseX, mouseY));
        unClicked = false;
    }
    
    //One word tutorial:
    fill(255);
    text("Click!", 10, 25);
}


//Allows user to only add one ball per click if quickAddMode is false
void mouseReleased() {
    unClicked = true;
}