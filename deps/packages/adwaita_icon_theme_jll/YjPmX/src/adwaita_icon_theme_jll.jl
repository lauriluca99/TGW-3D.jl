# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule adwaita_icon_theme_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("adwaita_icon_theme")
JLLWrappers.@generate_main_file("adwaita_icon_theme", UUID("b437f822-2cd6-5e08-a15c-8bac984d38ee"))
end  # module adwaita_icon_theme_jll
