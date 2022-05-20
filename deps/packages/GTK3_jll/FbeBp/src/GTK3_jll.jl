# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule GTK3_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("GTK3")
JLLWrappers.@generate_main_file("GTK3", UUID("77ec8976-b24b-556a-a1bf-49a033a670a6"))
end  # module GTK3_jll
