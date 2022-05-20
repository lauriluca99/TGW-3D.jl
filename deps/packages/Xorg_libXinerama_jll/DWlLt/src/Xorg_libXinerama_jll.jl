# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXinerama_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXinerama")
JLLWrappers.@generate_main_file("Xorg_libXinerama", UUID("d1454406-59df-5ea1-beac-c340f2130bc3"))
end  # module Xorg_libXinerama_jll
