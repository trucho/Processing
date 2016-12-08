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
int nGhosts = 50;
float zombifyProb = 0.5;
float infectionProb = 0.001;

// Simulation modes:
// "normal" -> ghosts move semi-randomly towards a given direction and bounce on edges of canvas
// "panic" -> every ghosts tries to flee from nearest zombie and zombies try to get nearest ghost
// "fight" -> ghosts attempt to get rid of zombies
String mode = "panic";

ghost[] g = new ghost[nGhosts];
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
    g[i] = new ghost(initialX[i], initialY[i], 35);
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
      //check if zombie ghosts have adjacent ghosts that can be infected
      for (int other_i=0; other_i<nGhosts; other_i++) {
        if (g[other_i].status!="zombie" && g[other_i].status!="immune" && g[i].overlap(g[other_i]) && infectionProb > random(0, 1)) {
          g[other_i].status="infected";
        }
      }
    } 
    if (g[i].status == "susceptible" || g[i].status == "infected") {
      // try to flee from closest zombie
      for (int other_i=0; other_i<nGhosts; other_i++) {
        if (g[other_i].status=="zombie") {
          if (g[i].nearestZombie==g[i]) {
            g[i].nearestZombie = g[other_i];
          } else {
            if (g[i].calcDist(g[other_i]) < g[i].calcDist(g[i].nearestZombie)) {
              g[i].nearestZombie = g[other_i];
            }
          }
        }
      }
    }
  }
  for (int i=0; i<nGhosts; i++) {
    g[i].display(mode);
    // check who the nearest target is
    stroke(255);
    line(g[i].x,g[i].y,g[i].nearestZombie.x,g[i].nearestZombie.y);
  }
}