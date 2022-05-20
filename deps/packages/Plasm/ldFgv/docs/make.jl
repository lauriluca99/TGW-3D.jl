push!(LOAD_PATH,"../src/")

using Documenter, Plasm

makedocs(
	format = :html,
	sitename = "Plasm.jl",
	pages = [
		"Home" => "index.md",
		"Visualization" => "plasm.md",
		"Numbering" => "numbering.md",
		"Glossary" => "glossary.md"
	]
)
