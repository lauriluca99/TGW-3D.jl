using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using DataStructures
using PyCall
p = PyCall.pyimport("pyplasm")
import Base.view


"""
	cuboidGrid(shape::Array{Int64,1}[, full=false])::Union{LAR,LARmodel}

Compute a *cellular complex* (mesh) with *cuboidal cells* of either `LARmodel`
or `LAR` type, depending on optional `full` parameter.

The default is
for returning a `LAR` value, i.e. a pair `(Points, Cells)`.
The *dimension* of `Cells` is the one of the number `M` of rows of
cell `Points`. The dimensions of `Array{Cells,1}` in `LARmodel` run
from ``1`` to ``M``.

# Example
```
julia> V, CV = Plasm.cuboidGrid([2,2,1])
([0.0 0.0 … 2.0 2.0; 0.0 0.0 … 2.0 2.0; 0.0 1.0 … 0.0 1.0],
Array{Int64,1}[[1,2,3,4,7,8,9,10], [3,4,5,6,9,10,11,12], [7,8,9,10,13,14,15,16],
[9,10,11,12,15,16,17,18]])

julia> V, (VV,EV,FV,CV) = Plasm.cuboidGrid([2,2,1],true);

julia> V
3×18 Array{Float64,2}:
 0.0  0.0  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0  1.0  1.0  2.0  2.0  2.0  2.0  2.0  2.0
 0.0  0.0  1.0  1.0  2.0  2.0  0.0  0.0  1.0  1.0  2.0  2.0  0.0  0.0  1.0  1.0  2.0  2.0
 0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0

julia> VV
18-element Array{Array{Int64,1},1}:
[1],[2],[3],[4],...,[12],[13],[14],[15],[16],[17],[18]

julia> EV
33-element Array{Array{Int64,1},1}:
[1,2],[3,4],[5,6],[7,8],[9,10],[11,12],,[7,13],[8,14],[9,15],[10,16],[11,17],[12,18]

julia> FV
20-element Array{Array{Int64,1},1}:
[1,2,3,4],[3,4,5,6],[7,8,9,10],[9,10,11,12],[13,14,15,16],[15,16,17,18],[1,2,7,8],[3,4,9,10],⋮,[2,4,8,10],[3,5,9,11],[4,6,10,12],[7,9,13,15],[8,10,14,16],[9,11,15,17],[10,12,16,18]

julia> CV
4-element Array{Array{Int64,1},1}:
[1,2,3,4,7,8,9,10],[3,4,5,6,9,10,11,12],[7,8,9,10,13,14,15,16],[9,10,11,12,15,16,17,18]
```
"""
#cuboidGrid = Lar.larCuboids


"""
    centroid( V::Points )::Array{Float64,1}

*Geometric center* (or *barycenter*) of a `Points` 2-array of `size` ``(M,N)``.

Each of the
``M`` coordinates of *barycenter* of the dense array of ``N`` `points` is the *mean*
of the corresponding `Points` coordinates.
"""
function centroid( V::Points )::Array{Float64,2}
	return sum(V, dims=2)/size(V,2)
end


"""
  centroid(V::Array{Float64,2})::Array{Float64,1}

*Geometric center* of a `Points` 2-array of `size` ``(M,N)``. Each of the
``M`` coordinates of *barycenter* of the dense array of ``N`` `points` is the *mean*
of the corresponding `Array` coordinates.
"""
function centroid(V::Array{Float64,2})::Array{Float64,2}
	return sum(V,2)/size(V,2)
end


"""
	cells2py(cells::Lar.Cells)::PyObject

Return a `Cells` object in a *Python* source text format. The returned `PyObject` is
 a list of lists of integers.

# Example
``` julia
julia> FV = Lar.cuboid([1,1,1],true)[2][3]
6-element Array{Array{Int64,1},1}:
 [1, 2, 3, 4]
 [5, 6, 7, 8]
 [1, 2, 5, 6]
 [3, 4, 7, 8]
 [1, 3, 5, 7]
 [2, 4, 6, 8]

julia> Plasm.cells2py(FV)
PyObject [[1, 2, 3, 4], [5, 6, 7, 8], [1, 2, 5, 6], [3, 4, 7, 8],
[1, 3, 5, 7], [2, 4, 6, 8]]
```
"""
function cells2py(cells::Lar.Cells)::PyObject
	return PyObject([Any[cell[h] for h=1:length(cell)] for cell in cells])
end



"""
	points2py(V::Points)::PyObject

Return a `Points` object in a *Python* source text format. The returned `PyObject` is
 a `list of lists of float`.

# Example
``` julia
julia> V = Lar.cuboid([1,1,1])[1]
3×8 Array{Float64,2}:
 0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
 0.0  0.0  1.0  1.0  0.0  0.0  1.0  1.0
 0.0  1.0  0.0  1.0  0.0  1.0  0.0  1.0

julia> Plasm.points2py(V)
PyObject [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 1.0, 0.0], [0.0, 1.0, 1.0],
[1.0, 0.0, 0.0], [1.0, 0.0, 1.0], [1.0, 1.0, 0.0], [1.0, 1.0, 1.0]]
```
"""
function points2py(V::Points)::PyObject
	return PyObject([Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)])
end



"""
	mkpol(verts::Points, cells::Cells)::Hpc

Return an `Hpc` object starting from a `Points` and a `Cells` object. *HPC =
Hierarchical Polyhedral Complex* is the geometric data structure
used by `PLaSM` (Programming LAnguage for Solid Modeling). See the Wiley's book
[*Geometric Programming for Computer-Aided Design*]
(https://onlinelibrary.wiley.com/doi/book/10.1002/0470013885) and its
current `Python` library [*https://github.com/plasm-language/pyplasm*]
(https://github.com/plasm-language/pyplasm).

```julia
julia> V,(VV,EV,FV,CV) = Lar.cuboid([1,1,1],true);

julia> hpc = Plasm.mkpol(V,EV)
PyObject <pyplasm.xgepy.Hpc; proxy of <Swig Object of type
'std::shared_ptr< Hpc > *' at 0x12cf45d50> >
	```
"""
function mkpol( verts::Plasm.Points, cells::Plasm.Cells )::Plasm.Hpc
	p = PyCall.pyimport("pyplasm")
	Verts = Plasm.points2py(verts)
	Cells = Plasm.cells2py(cells)
	hpc = p["MKPOL"]([Verts,Cells,PyObject(true)])
	return hpc
end
function mkpol( hpcs::Array{Plasm.Hpc,1} )::Plasm.Hpc
	p = PyCall.pyimport("pyplasm")
	return p["MKPOL"](PyCall.PyVector(hpcs))
end




"""
	view(hpc::PyCall.PyObject)

Base.view extension.
Display a *Python*  `HPC` (Hierarchical Polyhedral Complex) `object` using
the *`PyPlasm` viewer*, written in C++ with `OpenGL` and acceleration algorithms
for *big geometric data* structures.

# Example
``` julia
julia> m = Lar.cuboidGrid([2,2],true)
([0.0 0.0 … 2.0 2.0; 0.0 1.0 … 1.0 2.0], Array{Array{Int64,1},1}[Array{Int64,1}[[1],
[2], [3], [4], [5], [6], [7], [8], [9]], Array{Int64,1}[[1, 2], [2, 3], [4, 5], [5,
6], [7, 8], [8, 9], [1, 4], [2, 5], [3, 6], [4, 7], [5, 8], [6, 9]],
Array{Int64,1}[[1, 2, 4, 5], [2, 3, 5, 6], [4, 5, 7, 8], [5, 6, 8, 9]]])

julia> hpc = Plasm.mkpol(m[1],m[2][2])
PyObject <pyplasm.xgepy.Hpc; proxy of <Swig Object of type 'std::shared_ptr< Hpc > *'
at 0x140d6c780> >

julia> Plasm.view(hpc)
```
"""
function view(hpc)
	p = PyCall.pyimport("pyplasm")
	p["VIEW"](hpc)
end



"""
	view(hpcs::Array{PyCall.PyObject})

Base.view extension.
Display a *Python*  `HPC` (Hierarchical Polyhedral Complex) `object`, starting from
a *Julia* array of `PyCall.PyObject`s.

# Example

```
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation

EV = [[1,2],[2,3],[3,4],[4,5],[5,6],[1,6],
[6,7],[4,7],[2,7],[5,8],[1,8],[3,8]]
V = hcat([[2.,1],[2,2],[1,2],[0,3],[0,0],[3,0],[3,3],[1,1]]...)

spanningtree, fronds = Lar.depth_first_search(EV)

hpc1 = Plasm.numbering(1.25)((V,[[[k] for k=1:size(V,2)], spanningtree]))
hpc2 = Plasm.numbering(1.25)((V,[[[k] for k=1:size(V,2)], fronds]))
Plasm.view([ Plasm.color("cyan")(hpc1) , Plasm.color("magenta")(hpc2) ])
```
"""
function view(hpcs::Array{PyCall.PyObject})
	p = PyCall.pyimport("pyplasm")
	hpc = p["STRUCT"](hpcs)
	p["VIEW"](hpc)
end





"""
	view(V::Points, CV::Cells)

Base.view extension.
Display a *Python*  `HPC` (Hierarchica Polyhedral Complex) `object` using
the *`PyPlasm` viewer*, written in C++ with `OpenGL` and acceleration algorithms
for *big geometric data* structures. Input parameters are of `Points` and `Cells`
type.

# Example

```julia
julia> V,(VV,EV,FV,CV) = Lar.cuboid([1,1,1],true);

julia> Plasm.mkpol(V,CV)
PyObject <pyplasm.xgepy.Hpc; proxy of <Swig Object of type
'std::shared_ptr< Hpc > *' at 0x12cf45d50> >

julia>
Plasm.view(Plasm.mkpol(V,CV))
```
"""
function view(V::Points, CV::Cells)
	p = PyCall.pyimport("pyplasm")
	hpc = lar2hpc(V::Points, CV::Cells)
	p["VIEW"](hpc)
end


"""
  build_K(FV::Lar.Cells)::ChainOp

The *characteristic matrix* of type `ChainOp` from 1-cells (edges) to 0-cells (vertices)
"""
function build_K(FV::Lar.Cells)
	   I = Int64[]; J = Int64[]; V = Int64[]
	   for (i,face) in enumerate(FV)
			   for v in face
					   push!(I,i)
					   push!(J,v)
					   push!(V,1)
			   end
	   end
	   kEV = SparseArrays.sparse(I,J,V)
end


"""
	view(V::Lar.Points, CV::Lar.ChainOp)

# Example

```julia
julia> V, (VV,EV,FV,CV) = Plasm.cuboidGrid([10,10,1],true);

julia> copCV = convert(Plasm.ChainOp,Plasm.build_K(FV));

julia> view(V,copCV)

```
"""
function view(V::Points, copCV::ChainOp)
	CV = [findnz(copCV[k,:])[1] for k=1:size(copCV,1)]
	view(V,CV)
end



"""
	view(model::LARmodel)

Base.view extension.
Display a *Python*  `HPC` (Hierarchica Polyhedral Complex) `object` using
the *`PyPlasm` viewer*, written in C++ with `OpenGL` and acceleration algorithms
for *big geometric data* structures. The input is a `LARmodel` object.

# Example

```julia
julia> typeof( Lar.cuboid([1,1,1], true) )
Tuple{Array{Float64,2},Array{Array{Int64,1},1}}

julia> V,(VV,EV,FV,CV) = Lar.cuboid([.5,.5,.5], true);

julia> Plasm.view( (V,[VV,EV,FV,CV]) )
```
"""
function view(model::LARmodel)
	p = PyCall.pyimport("pyplasm")
	hpc = hpc_exploded(model::LARmodel)(1.2,1.2,1.2)
	p["VIEW"](hpc)
end



"""
	view(pair::Tuple{Points,Cells})

Base.view extension.
Display a *Python*  `HPC` (Hierarchica Polyhedral Complex) `object` using
the *`PyPlasm` viewer*, written in C++ with `OpenGL` and acceleration algorithms
for *big geometric data* structures. The input is a `pair` of type
`Tuple{Points,Cells}`.

# Example
```julia
julia> typeof(Lar.cuboid([1,1,1])::LAR)
Tuple{Array{Float64,2},Array{Array{Int64,1},1}}

julia> V,(VV,EV,FV,CV) = Lar.cuboid([1,1,1], true);

julia> Plasm.view( (V,FV) );
```
"""
function view(pair::Tuple{Points,Cells})
	V,CV = pair
	p = PyCall.pyimport("pyplasm")
	hpc = lar2hpc(V::Points, CV::Cells)
	p["VIEW"](hpc)
end


"""
	view(obj::Lar.Struct)

Display a geometric value of `Struct` type, via conversion to `LAR`
and then to `Hpc` values.

# Example
```julia
cube = Lar.apply( Lar.t(-.5,-.5,0), Lar.cuboid([1,1,1]));
tableTop = Lar.Struct([ Lar.t(0,0,.85), Lar.s(1,1,.05), cube ]);
tableLeg = Lar.Struct([ Lar.t(-.475,-.475,0), Lar.s(.1,.1,.89), cube ]);
tablelegs = Lar.Struct( repeat([ tableLeg, Lar.r(0,0,pi/2) ],outer=4) );
table = Lar.Struct([ tableTop, tablelegs ]);

Plasm.view(table)
```
"""
function view(obj::Lar.Struct)
	lar = Lar.struct2lar(obj)
	view(lar)
end



"""
	view(scene::Array{Any,1})

Display a geometric `scene`, defined as `Array{Any,1}` of geometric objects
defined in the *same* coordinate system, i.e. in *World Coordinates*.

# Example

A hierarchical `scene` defined in *Local Coordinates* as value of `Struct` type,
must be converted to `Array{Any,1}` by the expression

	`evalStruct(scene::Struct)::Array{Any,1}`

```julia
cube = Lar.apply( Lar.t(-.5,-.5,0), Lar.cuboid([1,1,1]));
tableTop = Lar.Struct([ Lar.t(0,0,.85), Lar.s(1,1,.05), cube ]);
tableLeg = Lar.Struct([ Lar.t(-.475,-.475,0), Lar.s(.1,.1,.89), cube ]);
tablelegs = Lar.Struct( repeat([ tableLeg, Lar.r(0,0,pi/2) ],outer=4) );
table = Lar.Struct([ tableTop, tablelegs ]);

scene = Lar.evalStruct(table);
# output
# 5-element Array{Any,1}

Plasm.view(scene)
```
"""
function view(scene::Array{Any,1})
	if prod([isa(item[1:2],Lar.LAR) for item in scene])
		p = PyCall.pyimport("pyplasm")
		p["VIEW"](p["STRUCT"]([Plasm.lar2hpc(item[1],item[2]) for item in scene]))
	end
end


"""
	hpc_exploded( model::LARmodel )( sx=1.2, sy=1.2, sz=1.2 )::Hpc

Convert a `LARmodel` into a `Hpc` object, after exploding all-dimensional cells with
scale `sx,sy,sz` parameters. Every cell is *translated* by the vector difference
between its *scaled centroid* and its *centroid*. Every cell is transformed in a
single `LAR` object before explosion.

# Example
```julia
julia> hpc = Plasm.hpc_exploded(
	Lar.cuboidGrid([3,2,1], true))(1.5,1.5,1.5)

julia> view(hpc)
```
"""
function hpc_exploded( model )
		function hpc_exploded0( sx=1.2, sy=1.2, sz=1.2 )
		p = PyCall.pyimport("pyplasm")
		verts,cells = model
		out = []
		for skeleton in cells
			for cell in skeleton
				vcell = hcat([[verts[h,k] for h=1:size(verts,1)] for k in cell]...)

				center = sum([verts[:,v] for v in cell])/length(cell)
				scaled_center = length(center)==2 ? center.*[sx,sy] :
													center.*[sx,sy,sz]
				translation_vector = scaled_center-center
				vcell = vcell .+ translation_vector

				py_verts = Plasm.points2py(vcell)
				py_cells = Plasm.cells2py( [collect(1:size(vcell,2))] )

				hpc = p["MKPOL"]([ py_verts, py_cells, [] ])
				push!(out, hpc)
			end
		end
		hpc = p["STRUCT"](out)
		return hpc
	end
	return hpc_exploded0
end


"""
	lar_exploded(model)

Generate an exploded `Hpc` value starting from a `LARmodel` instance.
Useful to show the explosion of a 2-complex made by possibly non-convex polygons.

# Example

```
V, copEV, copFE = Lar.planar_arrangement(W::Lar.Points, cop_EW::Lar.ChainOp)
EVs = FV2EVs(copEV, copFE) # polygonal face fragments

Plasm.viewcolor(V::Lar.Points, EVs::Array{Lar.Cells})
model = V,EVs
Plasm.view(lar_exploded(model)(1.2,1.2,1.2))
```
"""
function lar_exploded(model)
	function lar_exploded0( sx=1.2, sy=1.2, sz=1.2 )
		p = PyCall.pyimport("pyplasm")
		verts,arrayofcells = model
		out = []
		for cell in arrayofcells
			vcell = convert(Lar.Cells,[collect(Set(cat(cell)))])

			center = sum([verts[:,v] for v in vcell[1]])/length(vcell[1])
			scaled_center = size(center,1)==2 ? center .* [sx,sy] :
												center .* [sx,sy,sz]
			translation_vector = scaled_center - center
			vertcell = [verts[:,k]+translation_vector for k in vcell[1]]
			cellverts = hcat(vertcell...)

			py_verts = Plasm.points2py( cellverts )
			vdict = DataStructures.OrderedDict( zip( vcell[1],
						[k for k=1:length(vcell[1])] ))
			edges = [[vdict[e[1]], vdict[e[2]]] for e in cell]
			py_cells = Plasm.cells2py( edges )

			hpc = p["MKPOL"]([ py_verts, py_cells, [] ])
			push!(out, hpc)
		end
		hpc = p["STRUCT"](out)
		return hpc
	end
	return lar_exploded0
end




"""
	lar2hpc(V::Points, CV::Cells)::Hpc

Return an `Hpc` object starting from a `Points` and a `Cells` object. *HPC =
Hierarchical Polyhedral Complex* is the geometric data structure
used by `PLaSM` (Programming LAnguage for Solid Modeling). See the Wiley's book
[*Geometric Programming for Computer-Aided Design*]
(https://onlinelibrary.wiley.com/doi/book/10.1002/0470013885) and its
current `Python` library [*https://github.com/plasm-language/pyplasm*]
(https://github.com/plasm-language/pyplasm).
# Example

```julia
julia> V,(VV,EV,FV,CV) = Lar.cuboid([1,1,1],true);

julia> hpc = lar2hpc( (V, CV)::Plasm.LAR ... )::Hpc
PyObject <pyplasm.xgepy.Hpc; proxy of <Swig Object of type
'std::shared_ptr< Hpc > *' at 0x12cf45d50> >

julia> view(hpc)
```
"""
function lar2hpc(V::Points, CV::Cells)::Hpc
	hpc = Plasm.mkpol(V,CV)
	return hpc
end




"""
	lar2hpc(model::LARmodel)::Hpc

Return an `Hpc` object starting from a `LARmodel` object. *HPC =
Hierarchical Polyhedral Complex* is the geometric data structure
used by `PLaSM` (Programming LAnguage for Solid Modeling). See the Wiley's book
[*Geometric Programming for Computer-Aided Design*]
(https://onlinelibrary.wiley.com/doi/book/10.1002/0470013885) and its
current `Python` library [*https://github.com/plasm-language/pyplasm*]
(https://github.com/plasm-language/pyplasm).

# Example
```julia
julia> model = Lar.cuboid([1,1,1],true);

julia> view( Plasm.lar2hpc(model) )

julia> view( Plasm.hpc_exploded(model)(1.5,1.5,1.5) )
```
"""
function lar2hpc(model::LARmodel)::Hpc
	verts = model[1]
	cells = Array{Int,1}[]
	for item in model[2]
		append!(cells, item)
	end
	hpc = mkpol(verts,cells)
end



"""
	lar2hpc(scene::Array{Any,1})::Hpc

# Example
```julia
square = ([[0; 0] [0; 1] [1; 0] [1; 1]], [[1, 2, 3, 4]],
[[1,2], [1,3], [2,4], [3,4]])
V,FV,EV  =  square
model  =  V,([[1],[2],[3],[4]],EV,FV)
table = Lar.apply(Lar.t(-0.5,-0.5), square)
chair = Lar.Struct([Lar.t(0.75,0),Lar.s(0.35,0.35),table])
structo = Lar.Struct([Lar.t(2,1),table,repeat([Lar.r(pi/2),chair],
		outer = 4)...])
structo1 = Lar.Struct(repeat([structo,Lar.t(0,2.5)],outer = 10));
structo2 = Lar.Struct(repeat([structo1,Lar.t(3,0)],outer = 10));
scene = Lar.evalStruct(structo2);

Plasm.view(Plasm.lar2hpc(scene))
```

"""
function lar2hpc(scene::Array{Any,1})::Hpc
	p = PyCall.pyimport("pyplasm")
	hpc = p["STRUCT"]([ mkpol(item[1],item[2]) for item in scene ])
end



"""
	lar2exploded_hpc(V::Lar.Points,CV::Lar.Cells)::Hpc

Input `V::Points` and `CV::Cells`. Output an *exploded* `Hpc`
object,  exploding cells in `CV` with scale `sx,sy,sz` parameters.

Every cell is *translated* by the vector difference
between its *scaled centroid* and its *centroid*.

*HPC = Hierarchical Polyhedral Complex* is the geometric data structure
used by `PLaSM` (Programming LAnguage for Solid Modeling).

#	Example

```
julia> V,cells = Lar.cuboidGrid([3,3,1], true)

julia> hpc = Plasm.lar2exploded_hpc(V::Lar.Points, cells[4]::Lar.Cells)()

julia> Plasm.view(hpc)
```
"""
function lar2exploded_hpc(V::Lar.Points, cells::Lar.Cells)
	function lar2exploded_hpc0(sx=1.2, sy=1.2, sz=1.2)
		hpc = Plasm.hpc_exploded( (V,[cells]) )(sx,sy,sz)
	end
	return lar2exploded_hpc0
end

function viewexploded(V::Lar.Points, cells::Lar.Cells)
	function lar2exploded_hpc0(sx=1.2, sy=1.2, sz=1.2)
		hpc = Plasm.hpc_exploded( (V,[cells]) )(sx,sy,sz)
		Plasm.view(hpc)
	end
	return lar2exploded_hpc0
end

function viewexploded(W::Lar.Points, cells::Lar.ChainOp) # W by rows ...
	V = convert(Lar.Points, transpose(W))
	EV = [findnz(cells[k,:])[1] for k=1:size(cells,1)]
	function lar2exploded_hpc0(sx=1.2, sy=1.2, sz=1.2)
		Plasm.viewexploded(V::Lar.Points, EV::Lar.Cells)(sx,sy,sz)
	end
	return lar2exploded_hpc0
end


"""
	viewcolor(V::Lar.Points, CVs::Array{Lar.Cells})

Display a colored view of the function parameters, drawing each `Cells` array in function parameters with a random color.

# Example

```

```
"""
function viewcolor(V::Lar.Points, CVs::Array{Lar.Cells})
	hpcs = [ Plasm.lar2hpc(V,CVs[i]) for i=1:length(CVs) ]
	Plasm.view([ Plasm.color(Plasm.colorkey[(k%12)==0 ? 12 : k%12])(hpcs[k])
		for k=1:(length(hpcs)) ])
end

function viewcolorexploded(V::Lar.Points, CVs::Array{Lar.Cells})
	n = length(CVs)
	Vs = Array{Array{Float64,2},1}(undef, n)

	for (k,CV) in enumerate(CVs)
		vs = sort(collect(Set(cat(CV))))
		vdict = OrderedDict(zip(vs,1:length(vs)))
		CV = [[vdict[h] for h in cell] for cell in CV]
		Vs[k] = hcat([V[:,i] for i in vs]...)
	end

	hpcs = [ Plasm.lar2hpc(Vs[i],CVs[i]) for i=1:n ]
	Plasm.view([ Plasm.color(Plasm.colorkey[(k%12)==0 ? 12 : k%12])(hpcs[k])
		for k=1:(length(hpcs)) ])
end





"""
	cubicbezier2D(curvePts::Array{Array{Float,1},1})

Produce the two ``coordinate functions`` for a ``cubic`` *Bézier curve* in ``2D``.
The input is the array `curvePts` of 4 control points with 2 coordinates.

# Example

```
julia> curvePts = [[1232.24, 1340.84],[1259.53, 1119.86],
	[1417.91, 1015.16],[1133.47, 1010.63]]

julia> bx,by = cubicbezier2D(curvePts);

julia> (bx(0), by(0))
(1232.24, 1340.84)

julia> (bx(1), by(1))
(1133.47, 1010.63)
```
"""
function cubicbezier2D( curvePts::Array{Array{Float64,1},1} )
	b1(u) = (1 - u)^3
	b2(u) = 3*u*(1 - u)^2
	b3(u) = 3*u^2*(1 - u)
	b4(u) = u^3
	cntrlverts = hcat(curvePts...)
	x = cntrlverts[1,:]
	y = cntrlverts[2,:]
	Bx = u -> x[1]*b1(u) + x[2]*b2(u) + x[3]*b3(u) + x[4]*b4(u)
	By = u -> y[1]*b1(u) + y[2]*b2(u) + y[3]*b3(u) + y[4]*b4(u)
	return Bx,By
end



"""
	const cmdsplit

Regex for splitting the `d` element of a `<path` element into
a sequence of graphics commnds.
"""
const cmdsplit = r"\s*([mMzZlLhHvVcCsSqQtTaA])\s*"


"""
	const digitRegEx

Regex for extracting numeric params from from a sequence of graphics
commnds of a `<path` element.
"""
const digitRegEx = r"\s*(-?[0-9]*\.?\d+)\s*"

"""
	pathparse(elements)

Parse graphics commands in SVG `<path` tagged element.

# Example

```julia

```
"""
function pathparse(data, cnrtlpolygon=false)
	tokens = split(data,'\"')
	pathstring = tokens[2]

	iterator = eachmatch(cmdsplit, pathstring)
	offsets = [m.offset for m in iterator]
	commands = [m.match for m in iterator]

	substrings = [pathstring[offsets[k]+1:offsets[k+1]-1]
		for k=1:length(offsets)-1]
	push!(substrings, pathstring[offsets[end]+1:end])

	params = Array{Float64,1}[]
	for substring in substrings
		numbers = []
		for match in eachmatch(digitRegEx, substring)
			push!(numbers,String(match.match))
		end
		numbers = map(x->parse(Float64,x),numbers)
		push!(params,numbers)
	end

	lines = Array{Float64,1}[]
	global startpoint, endpoint = 0.0, 0.0
	for (command, args) in zip(commands, params)
		if command == "M"
			global startpoint = args
		elseif command == "L"
			endpoint = args
			line = vcat([startpoint,endpoint]...)
			startpoint = endpoint
			push!(lines, line)
		elseif command == "C"
			contrlpt1 = args[1:2]
			contrlpt2 = args[3:4]
			endpoint = args[5:6]
			curvePts = [startpoint,contrlpt1,contrlpt2,endpoint]
			println(curvePts)

			Bx,By = cubicbezier2D(curvePts)
			pts = [[Bx(u),By(u)] for u=0:.1:1]
			curvelines = [ vcat([pts[k],pts[k+1]]...) for k=1:length(pts)-1 ]
			for line in curvelines
				push!(lines, line)
			end

 			if cnrtlpolygon
				push!(lines,vcat(curvePts[1:2]...),vcat(curvePts[2:3]...),
					vcat(curvePts[3:4]...))
			end
			startpoint = endpoint
		end

	end
	return lines
end



"""
	lines2lar(lines)

LAR model construction from array of float quadruples.
Each `line` in input array stands for `x1,y1,x2,y2`.
"""
function lines2lar(lines)
	vertdict = OrderedDict{Array{Float64,1}, Int64}()
	EV = Array{Int64,1}[]
	idx = 0
	for h=1:size(lines,2)
		x1,y1,x2,y2 = lines[:,h]

		if ! haskey(vertdict, [x1,y1])
			idx += 1
			vertdict[[x1,y1]] = idx
		end
		if ! haskey(vertdict, [x2,y2])
			idx += 1
			vertdict[[x2,y2]] = idx
		end
		v1,v2 = vertdict[[x1,y1]],vertdict[[x2,y2]]
		push!(EV, [v1,v2])
	end
	V = hcat(collect(keys(vertdict))...)
	return V,EV
end



"""
	normalize(V::Lar.Points; flag=true::Bool)::Lar.Points

2D normalization transformation (isomorphic by defaults) of model
vertices to normalized coordinates ``[0,1]^2``. Used with SVG importing.
"""
function normalize(V::Lar.Points; flag=true)
	m,n = size(V)
	if m > n # V by rows
		V = convert(Lar.Points, V')
	end

	xmin = minimum(V[1,:]); ymin = minimum(V[2,:]);
	xmax = maximum(V[1,:]); ymax = maximum(V[2,:]);
	box = [[xmin; ymin] [xmax; ymax]]	# containment box
	aspectratio = (xmax-xmin)/(ymax-ymin)
	if flag
		if aspectratio > 1
			umin = 0; umax = 1
			vmin = 0; vmax = 1/aspectratio; ty = vmax
		elseif aspectratio < 1
			umin = 0; umax = aspectratio
			vmin = 0; vmax = 1; ty = vmax
		end
		T = Lar.t(0,ty) * Lar.s(1,-1) * Lar.s((umax-umin), (vmax-vmin)) *
			Lar.s(1/(xmax-xmin),1/(ymax-ymin)) * Lar.t(-xmin,-ymin)
	else
		T = Lar.t(0, ymax-ymin) * Lar.s(1,-1)
	end
	dim = size(V,1)
	W = T[1:dim,:] * [V;ones(1,size(V,2))]
	#V = map( x->round(x,digits=8), W )
	V = map(Lar.approxVal(8), W)

	if m > n # V by rows
		V = convert(Lar.Points, V')
	end
	return V
end


function normalize3D(V::Lar.Points; flag=true)
	Vxy = Plasm.normalize(V[1:2,:], flag=flag)
	zmin = minimum(V[3,:]); zmax = maximum(V[3,:]);
	Vz = (V[3,:] .- zmin) / (zmax - zmin)
	return [Vxy; Vz']
end




"""
	svg2lar(filename::String; flag=true)::Lar.LAR

Parse a SVG file to a `LAR` model `(V,EV)`.
Only  `<line >` and `<rect >` and `<path >` SVG primitives are currently translated.
TODO:  interpretation of transformations.
"""
function svg2lar(filename::String; flag=true)::Lar.LAR
	outlines = Array{Float64,1}[]
	for line in eachline(filename)
		parts = split(line, ' ')
		elements = [part for part in parts if part≠""]
		tag = elements[1]

		# SVG <line > primitives
		if tag == "<line"
			regex = r"""(<line )(.+)(" x1=")(.+)(" y1=")(.+)(" x2=")(.+)(" y2=")(.+)("/>)"""
			coords = collect(match( regex , line)[k] for k in (4,6,8,10))
			outline = [ parse(Float64, string) for string in coords ]
			push!(outlines, outline)
		# SVG <rect > primitives
		elseif tag == "<rect"
			regex = r"""(<rect x=")(.+?)(" y=")(.+?)(" )(.*?)( width=")(.+?)(" height=")(.+?)("/>)"""
			coords = collect(match( regex , line)[k] for k in (2,4,8,10))
			x, y, width, height = [ parse(Float64, string) for string in coords ]
			line1 = [ x, y, x+width, y ]
			line2 = [ x, y, x, y+height ]
			line3 = [ x+width, y, x+width, y+height ]
			line4 = [ x, y+height, x+width, y+height ]
			push!(outlines, line1, line2, line3, line4)
		# SVG <path  > primitives
		# see https://github.com/chebfun/chebfun/issues/1617
		elseif tag == "<path"
			dataregex = r"""d=(".*?")(.*?)"""
			data = string(match( dataregex , line)[1])
			polyline = pathparse(data)
			append!(outlines, polyline)
		end
	end
	lines = hcat(outlines...)
	lines = map( x->round(x,sigdigits=8), lines )
	# LAR model construction
	V,EV = lines2lar(lines)
	# normalization
	V = normalize(V,flag=flag)
	return V,EV
end
