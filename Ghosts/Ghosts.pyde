# Numerical simulation of SIRD model
# Created Nov_2016 (jangueyra@bard.edu)
 
# Description:
#     Population is laid out on canvas randomly
#     Each subject makes a 2D random walk
#     Mouse hovering over subjects interrupts random walk
#     Mouse clicking a subject infects it
#     Infected subjects have chance to become zombies
#     Zombies infect nearby subjects
from ghost import Ghost
# simulation parameters
canvasX = 600
canvasY = 600
canvasC = 255 / 2

nGhosts = 200
zombifyProb = .05
infectionProb = .01

initialX = []
initialY = []
ghosts = []
# initialize ghosts starting position randomly
for i in range(nGhosts):
    initialX.append(random(0, canvasX))
    initialY.append(random(0, canvasY))
    ghosts.append(Ghost(initialX[i], initialY[i], 40))

def setup():  # happens once (Processing default)
    size(canvasX, canvasY, P2D)  # always first line of setup
    ellipseMode(CENTER)
    rectMode(CENTER)
    background(canvasC)
    frameRate(40)

def draw():  # happens every frame (Processing default)
    global canvasC
    background(canvasC)
    for ghost in ghosts:
        # infected ghosts can become infectious zombies
        if ghost.status == 'infected':
            if zombifyProb > random(0, 1):
                ghost.status = 'zombie'
        # check if zombie ghosts have neighbors that can be infected
        elif ghost.status == 'zombie':
            for otherghost in ghosts:
                if ghost != otherghost and \
                   ghost.x - ghost.w < otherghost.x < ghost.x + ghost.w and \
                   ghost.y - ghost.h < otherghost.y < ghost.y + ghost.h and \
                       otherghost.status != 'zombie':
                    if infectionProb > random(0, 1):
                        otherghost.status = 'infected'
    # update all ghosts
    for ghost in ghosts:
        ghost.display()