# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule ATK_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("ATK")
JLLWrappers.@generate_main_file("ATK", UUID("7b86fcea-f67b-53e1-809c-8f1719c154e8"))
end  # module ATK_jll
