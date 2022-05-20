using Test

@testset "mini-FL Tests" begin
   @testset "comp" begin
		@test Plasm.comp([acos,atan,tan,sin])(pi/4) * 4 - pi < 0.1e-14
		@test Plasm.comp([acos,atan,tan,sin])(1)==(acos∘atan∘tan∘sin)(1)
		@test Plasm.comp([atan,tan])(pi/4)*4 > 3.14159265358979
   end
   
   @testset "cons Tests" begin
		@test ((Plasm.cons([acos,atan,tan,sin])(pi/4) .<= 
		[0.667458,0.665774,1.0,0.707107]))==[true,true,true,true]
		@test (Plasm.cons([sin,cos])(pi/2).>=[1.0,0.0])==[true,true]
		@test Plasm.cons([+,-])([2,3])==[[2,3],[-2,-3]]
		@test typeof(Plasm.cons([+,-])([2,3]))==Array{Array{Int64,1},1}
   end
   
   @testset "k Tests" begin
		@test Plasm.k(10)(100)==10
		@test Plasm.k(10)(sin)==10
		@test Plasm.k(sin)(cos)==sin
		@test Plasm.k(sin)(1000)==sin
		@test Plasm.k([1,2,3])(100)==[1,2,3]
		@test Plasm.k([1,2,3])(sin)==[1,2,3]
   end
   
   @testset "aa Tests" begin
		@test (Plasm.aa(sin)([0.,pi/2])==[0.0,1.0])
		@test typeof(Plasm.aa(sin)([0.,pi/6,pi/2]))==Array{Float64,1}
		@test Plasm.aa(sum)([[1,2],[3,4],[5,6],[7,8]])==[3,7,11,15]
   end
end
