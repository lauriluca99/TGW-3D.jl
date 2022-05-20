# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXdamage_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXdamage")
JLLWrappers.@generate_main_file("Xorg_libXdamage", UUID("0aeada51-83db-5f97-b67e-184615cfc6f6"))
end  # module Xorg_libXdamage_jll
