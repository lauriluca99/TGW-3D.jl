using Plasm
using PyCall
p = PyCall.pyimport("pyplasm")

function array2list(cells) 
	return PyObject([Any[cell[h] for h=1:length(cell)] for cell in cells])
end

function doublefirst(cells)
	return p["AL"]([cells[1],cells])
end
