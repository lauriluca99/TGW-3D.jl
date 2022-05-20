# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_xkeyboard_config_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_xkeyboard_config")
JLLWrappers.@generate_main_file("Xorg_xkeyboard_config", UUID("33bec58e-1273-512f-9401-5d533626f822"))
end  # module Xorg_xkeyboard_config_jll
