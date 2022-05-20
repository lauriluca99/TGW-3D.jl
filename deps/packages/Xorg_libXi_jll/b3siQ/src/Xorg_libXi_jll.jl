# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXi_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXi")
JLLWrappers.@generate_main_file("Xorg_libXi", UUID("a51aa0fd-4e3c-5386-b890-e753decda492"))
end  # module Xorg_libXi_jll
