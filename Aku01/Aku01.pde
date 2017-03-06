
/* Trying to re-create Aku's face just for fun */
/* Will try to do everything modularly */
aku Aku = new aku(200,300,1);

void setup() {
  size(400, 600, P2D);
  smooth();
}

void draw() {
  background(0);
  Aku.display();
}