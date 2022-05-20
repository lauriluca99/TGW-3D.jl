# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule at_spi2_core_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("at_spi2_core")
JLLWrappers.@generate_main_file("at_spi2_core", UUID("0fc3237b-ac94-5853-b45c-d43d59a06200"))
end  # module at_spi2_core_jll
