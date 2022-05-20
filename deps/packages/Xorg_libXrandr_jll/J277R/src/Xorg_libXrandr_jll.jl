# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXrandr_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXrandr")
JLLWrappers.@generate_main_file("Xorg_libXrandr", UUID("ec84b674-ba8e-5d96-8ba1-2a689ba10484"))
end  # module Xorg_libXrandr_jll
