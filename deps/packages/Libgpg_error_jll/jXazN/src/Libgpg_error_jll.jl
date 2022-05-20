# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Libgpg_error_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Libgpg_error")
JLLWrappers.@generate_main_file("Libgpg_error", UUID("7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"))
end  # module Libgpg_error_jll
