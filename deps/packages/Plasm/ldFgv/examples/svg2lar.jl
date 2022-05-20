using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
#using Plasm
using ViewerGL
GL = ViewerGL
import Base.show

function show(filename)
	V, EV = Plasm.svg2lar(filename)
	#Plasm.view(V,EV)
	GL.VIEW([ GL.GLGrid(V,EV, GL.COLORS[1],1), GL.GLFrame2 ]);

	#Plasm.view(V,EV)
	return V, EV
end


function show(filename)
	V, EV = Lar.svg2lar(filename)
	GL.VIEW([ GL.GLLines(V,EV) ])
	return V, EV
end

#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/new.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/curved.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/twopaths.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/paths.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/boundarytest2.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/tile.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/interior.svg")
#show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/holes.svg")

V,EV = show("/Users/paoluzzi/Documents/dev/Plasm.jl/test/svg/Lar.svg")
