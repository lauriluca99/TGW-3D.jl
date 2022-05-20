using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using Plasm

using PyCall
p = pyimport("pyplasm")

geom_0 = hcat([[x] for x=0.:10]...)
topol_0 = [[i,i+1] for i=1:9]
geom_1 = hcat([[0.],[1.],[2.]]...)
topol_1 = [[1,2],[2,3]]

model_0 = (geom_0,topol_0)
model_1 = (geom_1,topol_1)
model_2 = Lar.larModelProduct(model_0, model_1)
model_3 = Lar.larModelProduct(model_2, model_1)

p["VIEW"](Plasm.lar2hpc(model_3...))
V,CV = model_3

hpc = Plasm.hpc_exploded( (V,[CV]) )(1.5,1.5,1.5)
Plasm.view(hpc)

hpc = Plasm.lar2exploded_hpc(model_3[1], model_3[2])(1.5,1.5,1.5)
Plasm.view(hpc)

shape = [10,10,2]
cubes = Lar.larCuboids(shape,true)
V,FV = cubes[1],cubes[2][3]
Plasm.viewexploded(V,FV)()

V,EV = Lar.larCuboids([30])
V1 = hcat( map(u->[u; 0.0], V )...)
W = hcat( map(u->[cos(u*(2π/30)); sin(u*(2π/30))], V )...)
Plasm.viewexploded(V1,EV)()
Plasm.viewexploded(W,EV)()

V,FV = Lar.larCuboids([30,6])
V2 = [2π/30 0; 0 1/6] * V
W = [V2[:,k] for k=1:size(V,2)]
Z = hcat( map(p->let (u,v) = p; [v*cos(u); v*sin(u)] end, W) ...)
Plasm.viewexploded(V2,FV)()
Plasm.viewexploded(Z,FV)()

V,CV = Lar.larCuboids([16,32,1])
V3 = [π/16 0 0; 0 2π/32 0; 0 0 1] * V 
W = [V3[:,k]-[π/2,π,1/2] for k=1:size(V3,2)] 
Z = hcat( map(p->let (u,v,w) = p; [w*cos(u)*cos(v); w*cos(u)*sin(v); w*sin(u)] end, W) ...)
Plasm.viewexploded(V3,CV)()
Plasm.viewexploded(Z,CV)(2,2,2)


