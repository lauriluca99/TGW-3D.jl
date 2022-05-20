# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule hicolor_icon_theme_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("hicolor_icon_theme")
JLLWrappers.@generate_main_file("hicolor_icon_theme", UUID("059c91fe-1bad-52ad-bddd-f7b78713c282"))
end  # module hicolor_icon_theme_jll
