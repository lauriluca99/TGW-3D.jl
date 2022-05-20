if Base.HOME_PROJECT[] !== nothing
# JuliaLang/julia/pull/28625
Base.HOME_PROJECT[] = abspath(Base.HOME_PROJECT[])
end
using Documenter, TGW-3D
makedocs(
format = Documenter.HTML(),
modules = [TGW-3D],
sitename = "TGW-3D",
pages = [
"README.md",
"API Reference" => "index.md"
]
)
deploydocs( repo   = "github.com/lauriluca99/TGW-3D.jl.git", )