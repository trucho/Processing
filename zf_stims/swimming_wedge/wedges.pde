class wedges {
  /* Using a donut to make aperture mask to restrict stimulus to arena size */
  float x, y, r, phase;
  int n;
  color c;
  PShape[] ws;

  wedges (float wedgeX, float wedgeY, float wedgeR, int wedgeN, color foreC) {
    x = wedgeX; // x position
    y = wedgeY; // y position
    r = wedgeR; // radius
    n = wedgeN; // number of divisions
    c = foreC; // foreground color
    phase = 0;
    ws = new PShape[n];

    // First create the shape
    for (int a = 0; a <= n-1; a += 2) {
      ws[a] = createShape(ARC, x, y, r, r, a*TWO_PI/n, (a+1)*TWO_PI/n, PIE);
      ws[a].setFill(c);
    }
  }

  void display() {
    for (int a = 0; a <= n-1; a += 2) {
      shape(ws[a]);
    }
  }
}