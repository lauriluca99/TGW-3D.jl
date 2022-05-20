# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Triangle_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Triangle")
JLLWrappers.@generate_main_file("Triangle", UUID("5639c1d2-226c-5e70-8d55-b3095415a16a"))
end  # module Triangle_jll
