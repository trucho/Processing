//Numerical simulation of SIRZ model
//Created Nov_2016 (jangueyra@bard.edu)

//Description:
//    Population is laid out on canvas randomly
//    Each subject makes a 2D random walk
//    Mouse hovering over subjects interrupts random walk
//    Mouse clicking a subject infects it
//    Infected subjects have chance to become zombies
//    Zombies infect nearby subjects

// Simulation parameters
int canvasX = 600;
int canvasY = 600;
float canvasC = 255/2;
int nGhosts = 200;
float zombifyProb = 0.005;
float infectionProb = 0.1;

jghost[] g = new jghost[nGhosts];
int[] initialX = new int[nGhosts];
int[] initialY = new int[nGhosts];

// SETUP happens once (Processing default)
void setup() {
  size(600, 600, P2D);
  ellipseMode(CENTER);
  rectMode(CENTER);
  background(canvasC);
  frameRate(40);
  //initialize ghosts with random starting position
  for (int i=0; i<nGhosts; i++) {
    initialX[i] = int(random(0, canvasX));
    initialY[i] = int(random(0, canvasY));
    g[i] = new jghost(initialX[i], initialY[i], 35);
  }
}

// DRAW happens every frame (Processing default)
void draw() {
  background(canvasC);
  for (int i=0; i<nGhosts; i++) {
    if (g[i].status == "infected") {
      //infected ghosts can become zombies
      if (zombifyProb > random(0, 1)) {
        g[i].status = "zombie";
      }
    } else if (g[i].status == "zombie") {
      //check if zombie ghosts have neighbors that can be infected
      for (int other_i=0; other_i<nGhosts; other_i++) {
        if (g[other_i].status!="zombie" && g[i].overlap(g[other_i]) && infectionProb > random(0, 1)) {
          g[other_i].status="infected";
        }
      }
    }
  }
  for (int i=0; i<nGhosts; i++) {
    g[i].display();
  }
}