
from ghost import Ghost
from pacman import Pacman

canvasX = 600
canvasY = 600
canvasC = 255 / 2

nGhosts = 20
initialX = []
initialY = []
ghosts = []
for i in range(nGhosts):
    initialX.append(random(0, canvasX))
    initialY.append(random(0, canvasY))
    ghosts.append(Ghost(initialX[i], initialY[i], 50))

pacman = Pacman(250, 250, 50)

def setup():  # happens once
    size(canvasX, canvasY)  # always first line of setup
    ellipseMode(CENTER)
    rectMode(CENTER)
    background(canvasC)
    frameRate(10)
    startButton()

def draw():  # happens every frame
    global canvasC
    background(canvasC)
    rC = 20
    aC = .006
    for ghost in ghosts:
        for otherghost in ghosts:
            if ghost == otherghost:
                stroke(0)
            else:
                # repulsion based on distance between ghosts
                stroke(0)
                line(ghost.x, ghost.y, otherghost.x, otherghost.y)
                rsq = ((otherghost.x - ghost.x) * (otherghost.x - ghost.x) +
                       (otherghost.y - ghost.y) * (otherghost.y - ghost.y))
                repulsionVector = PVector(
                    rC * (otherghost.x - ghost.x) / rsq, rC * (otherghost.y - ghost.y) / rsq)
                # attraction between ghosts
                attractionVector = PVector(aC * (ghost.x - otherghost.x), aC * (ghost.y - otherghost.y))
                ghost.x = ghost.x + repulsionVector.x - attractionVector.x
                ghost.y = ghost.y + repulsionVector.y - attractionVector.y
        # repulsion from corners of canvas
        line(ghost.x, ghost.y, 0, 0)
        line(ghost.x, ghost.y, width / 2, 0)
        line(ghost.x, ghost.y, width, 0)
        line(ghost.x, ghost.y, 0, height / 2)
        line(ghost.x, ghost.y, width / 2, height)
        line(ghost.x, ghost.y, 0, height)
        line(ghost.x, ghost.y, width, height)
        line(ghost.x, ghost.y, width, height / 2)
        rsq1 = ((0 - ghost.x) * (0 - ghost.x) +
                       (0 - ghost.y) * (0 - ghost.y))
        repulsionVector1 = PVector(
            rC * (0 - ghost.x) / rsq1, rC * (0 - ghost.y) / rsq1)
        rsq2 = ((width / 2 - ghost.x) * (width / 2 - ghost.x) +
                       (0 - ghost.y) * (0 - ghost.y))
        repulsionVector2 = PVector(
            rC * (width / 2 - ghost.x) / rsq2, rC * (0 - ghost.y) / rsq2)
        rsq3 = ((width - ghost.x) * (width - ghost.x) +
                       (0 - ghost.y) * (0 - ghost.y))
        repulsionVector3 = PVector(
            rC * (width - ghost.x) / rsq3, rC * (0 - ghost.y) / rsq3)
        rsq4 = ((0 - ghost.x) * (0 - ghost.x) +
                       (height / rC - ghost.y) * (height / rC - ghost.y))
        repulsionVector4 = PVector(
            rC * (0 - ghost.x) / rsq4, rC * (height / rC - ghost.y) / rsq4)
        rsq5 = ((width / 2 - ghost.x) * (width / 2 - ghost.x) +
                       (height- ghost.y) * (height - ghost.y))
        repulsionVector5 = PVector(
            rC * (width / 2 - ghost.x) / rsq5, rC * (height - ghost.y) / rsq5)
        rsq6 = ((0 - ghost.x) * (0 - ghost.x) +
                       (height - ghost.y) * (height - ghost.y))
        repulsionVector6 = PVector(
            rC * (0 - ghost.x) / rsq6, rC * (height - ghost.y) / rsq6)
        rsq7 = ((width - ghost.x) * (width - ghost.x) +
                       (height - ghost.y) * (height - ghost.y))
        repulsionVector7 = PVector(
            rC * (width - ghost.x) / rsq7, rC * (height / 2 - ghost.y) / rsq7)
        rsq8 = ((width - ghost.x) * (width - ghost.x) +
                       (height - ghost.y) * (height - ghost.y))
        repulsionVector8 = PVector(
            rC * (width - ghost.x) / rsq8, rC * (height - ghost.y) / rsq8)
        sumVector = PVector(0, 0)
        sumVector.add(repulsionVector1)
        sumVector.add(repulsionVector2)
        sumVector.add(repulsionVector3)
        sumVector.add(repulsionVector4)
        sumVector.add(repulsionVector5)
        sumVector.add(repulsionVector6)
        sumVector.add(repulsionVector7)
        sumVector.add(repulsionVector8)
        ghost.x = ghost.x + sumVector.x
        ghost.y = ghost.y + sumVector.y
    for ghost in ghosts:
        ghost.display()
    pacman.display()
# blinky.display()
# pinky.display()
# inky.display()
# clyde.display()
# pacman.display()

def startButton():  # starts simulation
    rect(20, 10, 20, 10)
