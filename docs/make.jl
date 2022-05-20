if Base.HOME_PROJECT[] !== nothing
    # JuliaLang/julia/pull/28625
    Base.HOME_PROJECT[] = abspath(Base.HOME_PROJECT[])
end
import Pkg
Pkg.add("Documenter")

using Documenter, using TGW3D

makedocs(
    format = Documenter.HTML(),
    modules = [TGW3D],
    sitename = "TGW3D",
    pages = [
        "README.md",
        "API Reference" => "index.md"
        ]
    )
deploydocs(
    repo   = "github.com/lauriluca99/TGW-3D.jl.git",
)