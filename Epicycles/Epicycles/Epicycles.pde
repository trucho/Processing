

boolean unClicked = true;

int ntrail=50;

float[] px = new float[ntrail];
float[] py = new float[ntrail];
float g = 10;
float g2 = 1.5;

float x = 250;
float y = 50;

float cx = 250;
float cy = 200;

float vx = 3;
float vy = 0;

float x0 = mouseX;
float y0 = mouseY;
float x1=x0;
float y1=y0;

float rx = cx-x;
float ry = cy-y;
float r = sqrt(rx*rx + ry*ry);

float urx = rx/r;
float ury = ry/r;
float coeff = vx*urx + vy*ury;

void setup() {
    size(500,400);
    //PFont f = createFont("SourceCodePro-Regular.ttf", 20);
    //textFont(f);
    background(255);
    for(int n=0; n<ntrail; n++) {
        px[n] = x;
        py[n] = y;
    }
    ellipse(x,y,10,10);
}

void draw() {
    background(255);
    fill(0); stroke(0);
    ellipse(cx,cy,200,200);
    unClicked = false;
    if(mousePressed && unClicked) {
        unClicked = false;
        x0 = mouseX;
        y0 = mouseY;
        x1=x0;
        y1=y0;
        stroke(255,0,0);
        line(x0,y0,x1,y1);
    } else if(mousePressed && !unClicked) {
        x1 = mouseX;
        y1 = mouseY;
        stroke(255,0,0);
        line(x1,y1,x1,y1);
    } else {
        stroke(0);
        rx = cx-x;
        ry = cy-y;
        r = sqrt(rx*rx + ry*ry);
        urx = rx/r;
        ury = ry/r;
        vx =  vx + g*rx/(r*r);
        vy =  vy + g*ry/(r*r);
        x = x + vx;  // + g2*randomGaussian();
        y = y + vy;  // + g2*randomGaussian();
        coeff = vx*urx + vy*ury;
        
        if(r<105 && coeff>0) {
            float vpx = coeff*urx;
            float vpy = coeff*ury;
            vx = vx - 2*vpx;
            vy = vy - 2*vpy;
        } else if(r<105) {
            vx = vx - 0.0*g*rx/(r*r);
            vy = vy - 0.0*g*ry/(r*r);
        }
         
        for(int n=ntrail-1; n>0; n--) {
            px[n] = px[n-1];
            py[n] = py[n-1];
        }
        
        px[0] = x + g2*randomGaussian();;
        py[0] = y + g2*randomGaussian();;

        noFill(); 
        for(int n=ntrail-1; n>0; n--) {
            stroke(255*n/(ntrail)); strokeWeight(15*(1-n/ntrail));
            line(px[n-1],py[n-1],px[n],py[n]);
        }
        //bezier(px[0],py[0], px[ntrail/3],py[ntrail/3], px[2*ntrail/3],py[2*ntrail/3] ,px[20],py[20]);

        stroke(0);
        strokeWeight(1);
        fill(0);
        ellipse(x,y,10,10);
    }
    
    text("Click + drag to re-throw", 20, 25);
    
    if(r<95) {
        text("Sorry about that...gravity is quite basic here...", 20, 380);
    }
}



void mouseReleased() {

    unClicked = true;
    
    float x = x0;
    float y = y0;
    
    for(int n=0; n<ntrail; n++) {
        px[n] = x;
        py[n] = y;
    }
    
    float vx = 0.04*(x1-x0);
    float vy = 0.04*(y1-y0);

}