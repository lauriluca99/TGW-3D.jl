# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libxkbfile_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libxkbfile")
JLLWrappers.@generate_main_file("Xorg_libxkbfile", UUID("cc61e674-0454-545c-8b26-ed2c68acab7a"))
end  # module Xorg_libxkbfile_jll
