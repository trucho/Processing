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
float zombifyProb = 0.1;
float infectionProb = 0.2;
Table nCounts = new Table();
int nFrame = 0;
int nS = 0;
int nI = 0;
int nZ = 0;



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
  nCounts.addColumn("nFrame");
  nCounts.addColumn("nS");
  nCounts.addColumn("nI");
  nCounts.addColumn("nZ");
  nCounts.addColumn("nT");
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
  }
  nS = 0;
  nI = 0;
  nZ = 0;
  for (int i=0; i<nGhosts; i++) {
    g[i].display();
    if (g[i].status=="susceptible" || g[i].status=="marked") {
      nS = nS + 1;
    } else if (g[i].status=="infected") {
      nI = nI + 1;
    } else if (g[i].status=="zombie") {
      nZ = nZ + 1;
    }
  }
  TableRow newRow = nCounts.addRow();
  newRow.setInt("nFrame", frameCount);
  newRow.setInt("nS", nS);
  newRow.setInt("nI", nI);
  newRow.setInt("nZ", nZ);
  newRow.setInt("nT", nGhosts);
  
  saveTable(nCounts, "data/nCounts.csv");
}