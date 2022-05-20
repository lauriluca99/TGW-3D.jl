from pyplasm import *
batches=[]
batches+=Batch.openObj("two_cubes.obj")
octree=Octree(batches)
glcanvas=GLCanvas()
glcanvas.setOctree(octree)
glcanvas.runLoop()

