"""
L’algoritmo Topological Gift Wrapping calcola le
d-celle di una partizione di spazio generate da loro partendo da un
oggetto geometrico d-1 dimensionale.

TGW prende una matrice sparsa di dimensione d-1 in input e produce in
output la matrice sparsa di dimensione d sconosciuta aumentata dalle
celle esterne.
"""
module TGW3D

	using SparseArrays
	using LinearAlgebra
	using LinearAlgebraicRepresentation

"""
	Points = Array{Number,2}

Dichiarazione Alias di specifiche strutture dati di LAR.
`Array{Number,2,1}` ``M x N`` compatto per immagazzinare la posizione dei *vertici* (0-cells)
di un *complesso cellulare*. Il numero delle righe ``M`` è la dimensione 
dello spazio di inclusione. Il numero delle colonne ``N`` è il numero dei vertici.
"""
const Points = Matrix

"""
	ChainOp = SparseArrays.SparseMatrixCSC{Int8,Int}

Dichiarazione Alias di specifiche strutture dati di LAR.
`SparseMatrix` nel formato *Colonne sparse compresse*, contiene la rappresentazione
in coordinate di un operatore tra lo spazio lineare delle `P-chains`.
Operatori ``P-Boundary : P-Chain -> (P-1)-Chain``
e ``P-Coboundary : P-Chain -> (P+1)-Chain`` sono tipicamente immagazinati come
`ChainOp`con elementi in ``{-1,0,1}`` oppure in ``{0,1}``, per
operatori *assegnati* e *non-assegnati* rispettivamente.
"""
const ChainOp = SparseArrays.SparseMatrixCSC{Int8,Int}


	include("./spatial_arrangement.jl")
	
end #module
