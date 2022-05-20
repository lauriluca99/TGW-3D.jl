using Test
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using DataStructures

using PyCall
p = PyCall.pyimport("pyplasm")

using Plasm

include("./views.jl")
include("./graphic_text.jl")
