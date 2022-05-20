# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXcursor_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXcursor")
JLLWrappers.@generate_main_file("Xorg_libXcursor", UUID("935fb764-8cf2-53bf-bb30-45bb1f8bf724"))
end  # module Xorg_libXcursor_jll
