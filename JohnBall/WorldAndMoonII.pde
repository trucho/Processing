size(500,400);

void setup() {
    background(255);
    fill(0); stroke(0);
    
    //Strength of gravitational pull
    g = 5;
    
    //Damping force on moon (stabilizes motion a bit)
    g2 = 0.002;
    
    //Initial location of the "world"
    cx = 250;
    cy = 200;
    
    //Initial location of the ...moon?
    x = 250;
    y = 50;
    
    //Initial moon velocity
    vx = 1;
    vy = 0;
}

void draw() {

    background(255);
    fill(0); stroke(0);
    
    if(mousePressed) {
    
    
        cx_new = mouseX;
        cy_new = mouseY;
        
        vcx = cx_new - cx;
        vcy = cy_new - cy;
        
        cx = cx_new; cy = cy_new;
    }
    
    
    rx = cx - x;
    ry = cy - y;
    
    r = sqrt(rx*rx + ry*ry);
    
    urx = rx/r;
    ury = ry/r;
    
    coeff = vx*urx + vy*ury;
    
    
    vx = vx + g*rx/(r*r) - g2*vx;
    vy = vy + g*ry/(r*r) - g2*vy;
    
    x = x + vx;
    y = y + vy;
    
    
    if(coeff>0 && r<15) {
        vpx = coeff*urx;
        vpy = coeff*ury;
    
        vx = vx - 2*vpx + 1*vcx;
        vy = vy - 2*vpy + 1*vcy;
    }
    
    if(x<0 && vx<0) {
        vx = -vx;
    }
    if(y<0 && vy<0) {
        vy = -vy;
    }
    if(x>500 && vx>0) {
        vx = -vx;
    }
    if(y>400 && vy>0) {
        vy = -vy;
    }
    
    
    ellipse(cx,cy,25,25);
    
    ellipse(x,y,5,5);
    
    text("click to move the world...",15,15);
}








