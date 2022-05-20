using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using Plasm

V,(VV,EV,FV,CV) = Lar.cuboid([1,1,1],true);

hpc = Plasm.mkpol(V,EV)
Plasm.view(hpc)

Plasm.mkpol(V,CV)

Plasm.view(V,CV)

Plasm.view(Lar.cuboid([1,1,1],true))

Plasm.view( (V,FV) )
