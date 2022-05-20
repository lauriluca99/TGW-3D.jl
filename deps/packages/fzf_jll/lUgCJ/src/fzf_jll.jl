# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule fzf_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("fzf")
JLLWrappers.@generate_main_file("fzf", UUID("214eeab7-80f7-51ab-84ad-2988db7cef09"))
end  # module fzf_jll
