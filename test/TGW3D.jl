using Test
using Distributed
using TGW3D
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation


V = [0.3229956 0.8459234 0.3091824 0.8321101 0.3233606 0.8462884 0.3095474 0.8324751 0.822632 0.8740866 0.8719075 0.923362 0.9865184 1.0379729 1.0357938 1.0872484; 
    0.5770385 0.5632252 0.0548407 0.0410274 0.6046603 0.590847 0.0824624 0.0686491 0.4321656 0.4814411 0.591786 0.6410615 0.368702 0.4179775 0.5283224 0.5775979; 
    0.0769021 0.0772671 0.1045238 0.1048888 0.5992825 0.5996475 0.6269042 0.6272692 0.1754594 0.3393458 0.1119958 0.2758822 0.1430863 0.3069727 0.0796228 0.2435091]
CV = [[1, 2, 3, 4, 5, 6, 7, 8], [9, 10, 11, 12, 13, 14, 15, 16]]
FV = [[1, 2, 3, 4], [5, 6, 7, 8], [1, 2, 5, 6], [3, 4, 7, 8], [1, 3, 5, 7], [2, 4, 6, 8], [9, 10, 11, 12], [13, 14, 15, 16], [9, 10, 13, 14], [11, 12, 15, 16], [9, 11, 13, 15], [10, 12, 14, 16]]
EV = [[1, 2], [3, 4], [5, 6], [7, 8], [1, 3], [2, 4], [5, 7], [6, 8], [1, 5], [2, 6], [3, 7], [4, 8], [9, 10], [11, 12], [13, 14], [15, 16], [9, 11], [10, 12], [13, 15], [14, 16], [9, 13], [10, 14], [11, 15], [12, 16]]
mx = Matrix(Lar.boundary_1(EV))


cop_EV = Lar.coboundary_0(EV::Lar.Cells)
cop_FE = Lar.coboundary_1(V, FV::Lar.Cells, EV::Lar.Cells)
W = convert(Lar.Points, V')
#TGW3D.spatial_arrangement(W, cop_EV, cop_FE, false)

fs_num = size(cop_FE, 1)

in_chan = Distributed.RemoteChannel(()->Channel{Int64}(fs_num*2))
out_chan = Distributed.RemoteChannel(()->Channel{Tuple}(10))

for sigma in 1:fs_num
    put!(in_chan, sigma)
end
for p in Distributed.workers()
    put!(in_chan, -1)
end


@testset "type checking inferred" begin
    err = nothing
    try
        @inferred TGW3D.frag_face(V, EV, FE, 
        [5,6,7,8], 2)
    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred TGW3D.frag_face_channel(in_chan, out_chan, 
            V, EV, FE, 2)
    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred TGW3D.merge_vertices(V, EV, FE, err=1e-4)
    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred [ChainOp] TGW3D.removeinnerloops(1, cop_FE)
    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred TGW3D.spatial_arrangement_1(
            V, copEV, copFE, multiproc=false)
    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred TGW3D.minimal_3cycles(V, EV, FE)

    catch err
    end
    @test isa(err, ErrorException) == false

    err = nothing
    try
        @inferred TGW3D.spatial_arrangement(
            V, copEV, copFE, false)
        @inferred TGW3D.spatial_arrangement(
            V, copEV, copFE, false)
    catch err
    end
    @test isa(err, ErrorException) == false

end


# questa funzione ci mostra come ogni colonna della matrice sparsa di EV contiene sempre un 1 e un -1
# infatti si nota come, utilizzando random, viene presa ogni volta una colonna a caso e il contatore 
# riporterà sempre il valore 2
function doubleOne()
  mx = Matrix(Lar.boundary_1(EV))
  count = 0
  j = rand(1:24)
  for i in 1:16
      if mx[i,j]==1 || mx[i,j]==-1
         count+=1
        end
    
    end
    return count
end

@testset "test matrice sparsa" begin
    @test doubleOne() == 2

end

# test per verificare le incidenze della matrice sparsa
@testset "test incidenze" begin
    @test mx[1,1]== -1
    @test mx[2,1]== 1
end

# test per verificare la consistenza dei risultati
@testset "test spatial_arrangement" begin
    rV, rcopEV, rcopFE = TGW3D.spatial_arrangement_1(W, cop_EV, cop_FE) 
    rV1, rcopEV1, rcopFE1 = Lar.Arrangement.spatial_arrangement_1(W, cop_EV, cop_FE)
    @test rV != rV1
    @test rcopEV != rcopEV1
    @test rcopFE != rcopFE1
    rV, rEV, rFE, rCF = TGW3D.spatial_arrangement(W, cop_EV, cop_FE)
    rV1, rEV1, rFE1, rCF1 = Lar.Arrangement.spatial_arrangement(W, cop_EV, cop_FE)
    @test rV == rV1
    @test rEV == rEV1
    @test rFE == rFE1
    @test rCF == rCF1
end



