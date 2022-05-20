# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXtst_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXtst")
JLLWrappers.@generate_main_file("Xorg_libXtst", UUID("b6f176f1-7aea-5357-ad67-1d3e565ea1c6"))
end  # module Xorg_libXtst_jll
