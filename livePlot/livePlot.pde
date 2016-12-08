/** //<>//
 * Loading Tabular Data
 */

// A Table object
Table nCounts;
int[] nFrame;
int[] nT;
int[] nS;
int[] nI;
int[] nZ;
float r = 2;

void setup() {
  size(600, 600);
  ellipseMode(CENTER);
}

void draw() {
  loadData();
  background(255);
  stroke(0);
  //fill(0);
  noFill();
  beginShape();
  int rowCount = 0;
  for (int i=0; i < nCounts.getRowCount(); i++) {
    curveVertex(nFrame[i], nZ[i]);
  }
  endShape();
}

void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  nCounts = loadTable("nCounts.csv", "header");
  nFrame = new int[nCounts.getRowCount()]; //<>//
  nZ = new int[nCounts.getRowCount()];
  // You can access iterate over all the rows in a table
  for (int i=0; i < nCounts.getRowCount(); i++) {
    println(i);
    nFrame[i] = nCounts.getInt(i, "nFrame");
    nZ[i] = nCounts.getInt(i, "nZ");
  }
}