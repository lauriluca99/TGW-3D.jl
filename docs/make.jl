if Base.HOME_PROJECT[] !== nothing
    # JuliaLang/julia/pull/28625
    Base.HOME_PROJECT[] = abspath(Base.HOME_PROJECT[])
end

using Documenter, TGW3D

makedocs(
    format = Documenter.HTML(
	 prettyurls = get(ENV, "CI", nothing) == "true"
	),
    modules = [TGW3D],
    sitename = "TGW3D.jl",
    pages = [
        "README.md",
		"Introduzione a LAR" => "intro.md",
        "Riferimenti API" => "index.md",
		"Relazioni" => [
            "Studio Preliminare" => "studioPreliminare.md",
			"Studio Esecutivo" => "studioEsecutivo.md"
			]
        ]
    )

deploydocs(
    repo   = "github.com/lauriluca99/TGW-3D.jl.git",
	versions = nothing
)