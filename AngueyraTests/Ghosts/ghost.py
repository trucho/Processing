class Ghost(object):
# Ghost class: small animation updates depending on frameCount
# By default starts as susceptible. Marked when mouse hovers over it.
# Infected if clicked, then chance of zombifying
# Still to do:
    # Diffusion every frame
    # Collisions
    # Infection

    # initialize function

    def __init__(self, xpos, ypos, sze):
        self.x = xpos  # x-coordinate
        self.y = ypos  # y-coordinate
        self.w = sze   # width
        self.h = self.w * 7 / 8  # heigth
        self.sprite = 0  # animation status
        self.status = 'susceptible'  # current status
        self.mouseOver = False
        names = 'blinky', 'pinky', 'inky', 'clyde', 'pacman'  # ghosts IDs
        name_i = int(random(4))  # pick from ghosts IDs at random
        self.name = names[name_i]
        # define color based on name
        if self.name == 'blinky':
            self.color = color(255, 0, 0)
        elif self.name == 'pinky':
            self.color = color(255, 184, 222)
        elif self.name == 'inky':
            self.color = color(0, 255, 255)
        elif self.name == 'clyde':
            self.color = color(255, 184, 71)
        elif self.name == 'pacman':
            self.color = color(255, 238, 0)
        else:
            self.color = color(120, 120, 120)

    # main draw function (called every frame)
    def display(self):
        self.checkFrame()
        if self.status == 'infected':
            if self.mouseOver:
                if mousePressed:
                    self.status = 'marked'
            self.diffuse()
            self.infected()
        else:
            if self.mouseOver:
                self.marked()
                self.status = 'marked'
                if mousePressed:
                    self.status = 'infected'
            else:
                self.diffuse()
                self.susceptible()

    def infected(self):
        self.drawBody(color(0, 0, 255 / 2, 200))

    def susceptible(self):
        self.drawBody(color(self.color,200))
        self.drawEyes()

    def marked(self):
        self.drawBody(color(0, 0, 255, 200))
        self.drawEyes()

    def drawBody(self, ghost_color):
        # body
        noStroke()
        fill(ghost_color)
        arc(self.x, self.y, self.w, self.h, -PI, 0, OPEN)
        noStroke()
        rect(self.x, self.y + self.h / 6, self.w, self.h * 3 / 8)
        if self.sprite == 0:
            # skirt
            noStroke()
            fill(ghost_color)
            triangle(self.x - self.w / 2, self.y, self.x - self.w / 2,
                     self.y + self.w / 2, self.x, self.y)
            triangle(self.x + self.w / 2, self.y, self.x + self.w / 2,
                     self.y + self.w / 2, self.x, self.y)
            triangle(self.x - self.w / 4, self.y + self.h / 4,
                     self.x, self.y + self.w / 2, self.x, self.y)
            triangle(self.x + self.w / 4, self.y + self.h / 4,
                     self.x, self.y + self.w / 2, self.x, self.y)
        elif self.sprite == 1:
            # skirt
            noStroke()
            fill(ghost_color)
            triangle(self.x - self.w / 2, self.y + self.h / 3, self.x - self.w /
                     5, self.y + self.h / 3, self.x - self.w / 2.5, self.y + self.w / 2)
            triangle(self.x + self.w / 2, self.y + self.h / 3, self.x + self.w /
                     5, self.y + self.h / 3, self.x + self.w / 2.5, self.y + self.w / 2)
            triangle(self.x - self.w * 2 / 8, self.y + self.h / 3, self.x,
                     self.y + self.h / 3, self.x - self.w / 8, self.y + self.w / 2)
            triangle(self.x + self.w * 2 / 8, self.y + self.h / 3, self.x,
                     self.y + self.h / 3, self.x + self.w / 8, self.y + self.w / 2)

    def drawEyes(self):
        # eyes
        fill(255)
        ellipse(self.x + self.w * 25 / 80, self.y -
                self.w / 16, self.w / 4, self.w / 4)
        ellipse(self.x - self.w * 5 / 80, self.y -
                self.w / 16, self.w / 4, self.w / 4)
        # pupils
        fill(0)
        ellipse(self.x + self.w * 30 / 80, self.y - self.w / 16,
                self.w * 6 / 80, self.w * 6 / 80)
        ellipse(self.x, self.y - self.w / 16, self.w * 6 / 80, self.w * 6 / 80)

    def checkFrame(self):
        # update animation state
        if frameCount % 10 == 1:
            if self.sprite == 0:
                self.sprite = 1
            elif self.sprite == 1:
                self.sprite = 0
        # detect if mouse is hovering over ghost
        if self.x - self.w / 2 < mouseX < self.x + self.w / 2\
                and self.y - self.h / 2 < mouseY < self.y + self.h / 2:
            self.mouseOver = True
        else:
            self.mouseOver = False
        #

    def diffuse(self):
        self.x = self.x + random(-self.w, self.w) / 10
        self.y = self.y + random(-self.h, self.h) / 10
        if self.x < 0:
            self.x = 0 + self.w
        elif self.x > width:
            self.x = width - self.w
        if self.y < 0:
            self.y = 0 + self.h
        elif self.y > height:
            self.y = height - self.h
