size(500,400);

float[] ppx = {250,250,250,250};
float[] ppy = {  0, 75,150,225};


Ball A = new Ball();

dt = 0.1;

void setup() {
    
}

void draw() {
    background(242-50,120-50,130-50);

    
    if(mousePressed) {
        A.Pull(mouseX,mouseY);
    }
    
    A.Move();
    A.Update();
}


class Ball {
    float px,py, ax, ay, vx, vy;
    float R, f, f2, r;
    float rpx, rpy;
    
    Ball() {
        ax = 0; ay = 0;
        vx = 0; vy = 0;
        
        px = 350; py = 100;
        f = 1; f2 = 0.05;
        R = 25;
        
        rpx = 1, rpy = 0;
    }
    
    void Pull(float X, float Y) {
        rx = X-px; ry = Y-py;
        r = sqrt(rx*rx + ry*ry);
        urx = rx/r; ury = ry/r;
        
        ax = ax + 5*r*urx - 1*vx;
        ay = ay + 5*r*ury - 1*vy;
    }
    
    void Move() {
        rx = px-250;
        ry = py-0;
        
        r = sqrt(rx*rx + ry*ry);
        
        urx = rx/r; ury = ry/r;
        
        //ppx = {250+0*rx, 250+0.25*rx, 250+0.85*rx, px};
        //ppy = {0*ry, 0.25*ry, 0.85*ry, py};
        
        rpx = ury; rpy = -urx;
        
        ax = ax + 0*randomGaussian();
        ay = ay + 0*randomGaussian() + 9.8;
        
        if(r>200) {
            ax = ax - f*(r-200)*urx;
            ay = ay - f*(r-200)*ury;
        }
        
        ax = ax - f2*vx; ay = ay - f2*vy;
        
        vx = vx + dt*ax; vy = vy + dt*ay;
        px = px + dt*vx; py = py + dt*vy;
        
        ax = 0; ay = 0;
        
        ppx = {250+0*rx, 250+0.05*rx, 250+0.65*rx, px};
        ppy = {0*ry, 0.05*ry, 0.65*ry, py};
    }
    
    void Update() {
        fill(242,120,130); stroke(242,120,130);
        ellipse(px,py,0.85*2*R,0.85*2*R);
        line(px,py,250,0);
        quad(px+0.85*R*rpx,py+0.85*R*rpy,250+0.8*R,0,250-0.8*R,0,px-0.85*R*rpx,py-0.85*R*rpy);
        
        if(r<100) {
            wid = 0.75;
        } else {
            wid = 0.75*exp(-(r-100)/100);
        }
        
        fill(242-50,120-50,130-50); stroke(242-50,120-50,130-50);
        bezier(ppx[3]+1*R*rpx,ppy[3]+1*R*rpy,ppx[2]+wid*R*rpx,ppy[2]+wid*R*rpy,ppx[1]+wid*R*rpx,ppy[1]+wid*R*rpy,ppx[0]+0.9*R,0);
        bezier(ppx[3]-1*R*rpx,ppy[3]-1*R*rpy,ppx[2]-wid*R*rpx,ppy[2]-wid*R*rpy,ppx[1]-wid*R*rpx,ppy[1]-wid*R*rpy,ppx[0]-0.9*R,0);
        
        //stroke(255,0,0);
        
        //for(int n=0; n<4; n++) {
        //  line(ppx[n],ppy[n],ppx[n]+25*rpx,ppy[n]+25*rpy);
        //  line(ppx[n],ppy[n],ppx[n]-25*rpx,ppy[n]-25*rpy);
        //}
        
    }
}





