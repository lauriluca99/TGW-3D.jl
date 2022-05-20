# LinearAlgebraicRepresentation.jl

## Dependencies

`Plasm.jl` has one Julia dependency and one Python dependency:

- [LinearAlgebraicRepresentation](https://github.com/cvdlab/LinearAlgebraicRepresentation.jl)
- [Pyplasm](https://github.com/plasm-language/pyplasm)


## Docstrings conventions

**Bold** is used to point out theory concepts. For example, look at the 
"**2-skeletons**" word in the docstring of `LinearAlgebraicRepresentation.skel_merge`:
```@docs
cuboidGrid(shape::Array{Int64,1}[, full=false])::Union{LAR,LAR_Model}
```
`Monospace` is used for everything code related. Look e.g. at "`Points`", 
"`Cells`" and "`Hpc`" in the definition docstring of `mkpol`:
```@docs
mkpol(verts::Points, cells::Cells)::Hpc
```
!!! note
    In Julia REPL the `monospace` text is the one colored differently. In a terminal you will see something like:  
    ![Julia REPL monospace exaple](./images/monospace_juliarepl.png)