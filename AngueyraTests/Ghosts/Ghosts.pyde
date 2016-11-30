
from ghost import Ghost
from pacman import Pacman

canvasX = 600
canvasY = 600
canvasC = 255 / 2

nGhosts = 200
initialX = []
initialY = []
ghosts = []
for i in range(nGhosts):
    initialX.append(random(0, canvasX))
    initialY.append(random(0, canvasY))
    ghosts.append(Ghost(initialX[i], initialY[i], 40))

pacman = Pacman(250, 250, 40)

def setup():  # happens once
    size(canvasX, canvasY)  # always first line of setup
    ellipseMode(CENTER)
    rectMode(CENTER)
    background(canvasC)
    frameRate(40)
    startButton()

def draw():  # happens every frame
    global canvasC
    background(canvasC)
    # check if infected ghosts have neighbors
    for ghost in ghosts:
        if ghost.status == 'infected':
            for otherghost in ghosts:
                if ghost != otherghost and \
                   ghost.x - ghost.w < otherghost.x < ghost.x + ghost.w and \
                       ghost.y - ghost.h < otherghost.y < ghost.y + ghost.h:
                       otherghost.status = 'infected'
                    # infectionRoulette = random(0,1)
                    
    
    for ghost in ghosts:
            ghost.display()
    pacman.display()

def startButton():  # starts simulation
    rect(20, 10, 20, 10)

