# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_xkbcomp_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_xkbcomp")
JLLWrappers.@generate_main_file("Xorg_xkbcomp", UUID("35661453-b289-5fab-8a00-3d9160c6a3a4"))
end  # module Xorg_xkbcomp_jll
