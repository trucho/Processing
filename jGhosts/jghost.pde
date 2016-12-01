// Ghost class: small animation updates depending on frameCount
// By default starts as susceptible. Marked when mouse hovers over it.
// Infected if clicked, then chance of zombifying. Zombies can infect
// nearby ghosts.

class jghost {
  int x, y, w, h;
  int sprite = 0;
  boolean mouseOver = false;
  int name_i = int(random(4));
  String status = "susceptible";
  StringList names;
  //names.append("blinky");
  //names.append("pinky");
  //names.append("inky");
  //names.append("clyde");
  
  jghost (int xpos, int ypos, int sze) {
    x = xpos;
    y = ypos;
    w = sze;
    h = w * 7 /8;
    
  }
  
  void display(){
    noStroke();
    fill(0);
    arc(x,y,w,h,-PI,0,OPEN);
    rect(x,y+h/6,w,h*3/8);
  }
}