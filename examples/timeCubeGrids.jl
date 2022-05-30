using BenchmarkTools
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation

include("../CAGD.jl/CAGD.jl")
include("../src/TGW3D.jl")

function generateCubeGrids(n=1, m=1, p=1)
    V,(VV,EV,FV,CV) = Lar.cuboidGrid([n,m,p],true)
    mybox = (V,CV,FV,EV)

    twocubs = Lar.Struct([mybox, Lar.t(.3,.4,.5), Lar.r(pi/5,0,0), Lar.r(0,0,pi/12), mybox])

    V,CV,FV,EV = Lar.struct2lar(twocubs)

    cop_EV = convert(Lar.ChainOp, Lar.coboundary_0(EV::Lar.Cells))
    cop_FE = Lar.coboundary_1(V, FV::Lar.Cells, EV::Lar.Cells);
    model = CAGD.Model(V)
    CAGD.addModelCells!(model, 1, cop_EV)
    CAGD.addModelCells!(model, 2, cop_FE)

    return V, cop_EV, cop_FE
end

V, EV, FE = generateCubeGrids(1, 1, 1)

@btime TGW3D.spatial_arrangement(V, EV, FE)