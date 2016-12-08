/** //<>//
 * Loading Tabular Data
 */

// A Table object
Table table;
int[] x = new int[4];
int[] y = new int[4];
float r = 20;

void setup() {
  size(240, 240);
  loadData();
  ellipseMode(CENTER);
}

void draw() {
  background(255);
  stroke(0);
  fill(0);
  for (int i=0; i<4; i++) {
    ellipse(x[i], y[i], r, r);
  }
}

void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  table = loadTable("test.csv", "header");
  // You can access iterate over all the rows in a table
  int rowCount = 0;
  for (TableRow row : table.rows()) {
    // You can access the fields via their column name (or index)
    x[rowCount] = row.getInt("x");
    y[rowCount] = row.getInt("y");
    rowCount++;
  }
}