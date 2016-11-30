def layoutGhosts():
    rC = 200
    print ('Laying ghosts on canvas...')
    for i in range(200):
        for ghost in ghosts:
            for otherghost in ghosts:
                if ghost != otherghost:
                    # repulsion based on distance between ghosts
                    rsq = ((otherghost.x - ghost.x) * (otherghost.x - ghost.x) +
                        (otherghost.y - ghost.y) * (otherghost.y - ghost.y))
                    repulsionVector = PVector(
                        rC * (otherghost.x - ghost.x) / rsq, rC * (otherghost.y - ghost.y) / rsq)
                    if rsq < ghost.w * ghost.h:
                        ghost.x = ghost.x + repulsionVector.x
                        ghost.y = ghost.y + repulsionVector.y
                        if ghost.x < 0 or ghost.x > width:
                            ghost.x = -ghost.x/2
                        if ghost.y < 0 or ghost.y > height:
                            ghost.y = -ghost.y/2
    print ('...Done')