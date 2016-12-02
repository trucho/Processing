// Ghost class: small animation updates depending on frameCount
// By default starts as susceptible. Marked when mouse hovers over it.
// Infected if clicked, then chance of zombifying. Zombies can infect
// nearby ghosts.

class jghost {
  float x, y, w, h; //x and y, width and heigth
  float d; //moving direction
  int sprite = 0; //animation statis
  boolean mouseOver = false; //detection of mouse hovering over
  String status = "susceptible"; // current status
  int name_i = int(random(4)); // identity
  String name;
  color c;

  jghost (float xpos, float ypos, float sze) {
    x = xpos;
    y = ypos;
    w = sze;
    h = w * 7 /8;
    d = random(0, TWO_PI);
    if (name_i == 1) {
      name = "blinky";
      c = color(255, 0, 0);
    } else if (name_i == 2) {
      name = "pinky";
      c = color(255, 184, 222);
    } else if (name_i == 2) {
      name = "inky";
      c = color(0, 255, 255);
    } else if (name_i == 2) {
      name = "clyde";
      c = color(255, 184, 71);
    } else {
      c = color(120, 120, 120);
    }
  }

  void display() {
    checkFrame();
    noStroke();
    fill(0);
    arc(x, y, w, h, -PI, 0, OPEN);
    rect(x, y+h/6, w, h*3/8);
    diffuse();
  }

  void infected() {
    drawBody(color(0, 0, 255/2, 200));
  }

  void susceptible() {
    drawBody(color(c));
    drawEyes();
  }

  void marked() {
    drawBody(color(0, 0, 255));
    drawEyes();
  }

  void zombie() {
    color zcolor = color(255, 238, 0);
    // body
    noStroke();
    fill(zcolor);
    arc(x, y, w, w, PI/6, TWO_PI-PI/6, PIE);
    if (sprite==0) {
      fill(zcolor);
    } else if (sprite==1) {
      fill(zcolor);
      arc(x, y, w, w, PI/24, TWO_PI -PI/24, PIE);
    }
  }

  void checkFrame() {
    // update animation state every 10 frames
    if (frameCount % 10 == 1) {
      if (sprite == 0) {
        sprite = 1;
      } else if (sprite == 1) {
        sprite = 0;
      }
    }
    // detect if mouse is hovering over ghost
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }

  void diffuse() {
    // move randomly in x and y
    x += (random(-w, w)/10) + w/10 * cos(d);
    y += (random(-h, h)/10) + h/10 * sin(d);
    // check if ghost is floating away from canvas
    if (x < 0) {
      d = random (-HALF_PI, HALF_PI);
    } else if (x > width) {
      d = random (HALF_PI, PI*3/4);
    } else if (y < 0) {
      d = random (0, PI);
    } else if (y > height) {
      d = random (PI, TWO_PI);
    }
    //if (x < 0) {
    //  x = 0 + w/2;
    //} else if (x > width) {
    //  x = width - w/2;
    //}
    //if (y < 0) {
    //  y = 0 + h/2;
    //} else if (y > height) {
    //  y = height + h/2;
    //}
  }
}