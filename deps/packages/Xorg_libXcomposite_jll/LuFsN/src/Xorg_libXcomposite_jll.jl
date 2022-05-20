# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXcomposite_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXcomposite")
JLLWrappers.@generate_main_file("Xorg_libXcomposite", UUID("3c9796d7-64a0-5134-86ad-79f8eb684845"))
end  # module Xorg_libXcomposite_jll
