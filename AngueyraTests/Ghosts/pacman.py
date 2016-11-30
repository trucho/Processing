class Pacman(object):
    def __init__(self,xpos,ypos,sze):
        self.x = xpos
        self.y = ypos
        self.w = sze
        self.name = 'pacman'
        self.state = 0
        self.color = color(255,238,0)

    def display(self):
        if frameCount % 10 == 1:
            if self.state == 0:
                self.state = 1
            elif self.state == 1:
                self.state = 0
        # body
        noStroke()
        fill(self.color)
        #ellipse(self.x,self.y,self.w,self.h)
        arc(self.x,self.y,self.w,self.w,PI/6,2*PI-PI/6,PIE)
        if self.state == 0:
            # skirt
            fill(self.color)
        elif self.state == 1:
            # skirt
            fill(self.color)
            arc(self.x,self.y,self.w,self.w,PI/24,2*PI-PI/24,PIE)