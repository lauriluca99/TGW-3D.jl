Lar = LinearAlgebraicRepresentation


@testset "View p_STRUCT" begin
	geom_0 = hcat([[x] for x=0.:1.]...);
	topol_0 = [[i,i+1] for i=1:1];
	geom_1 = hcat([[x] for x=0.:.5:1.]...);
	topol_1 = [[i,i+1] for i=1:2];
	model_0 = (geom_0,topol_0);
	model_1 = (geom_1,topol_1);
	model_2 = Lar.larModelProduct(model_0,model_1);
	model_3 = Lar.larModelProduct(model_2,model_0);
	V,CV = model_3;
	
	@test typeof(V) == Array{Float64,2}
	@test typeof(CV) == Array{Array{Int64,1},1}
	@test size(V) == (3,12)
	@test length(CV) == 2
	
	V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...);
	W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)];
	
	@test typeof(PyObject([W,CV,[]])) == PyCall.PyObject
	@test repr(W) == "Array{Any,1}[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.5, 0.0], [0.0, 0.5, 1.0], [0.0, 1.0, 0.0], [0.0, 1.0, 1.0], [1.0, 0.0, 0.0], [1.0, 0.0, 1.0], [1.0, 0.5, 0.0], [1.0, 0.5, 1.0], [1.0, 1.0, 0.0], [1.0, 1.0, 1.0]]"
	@test repr(CV) == "Array{Int64,1}[[1, 2, 3, 4, 7, 8, 9, 10], [3, 4, 5, 6, 9, 10, 11, 12]]"
end

