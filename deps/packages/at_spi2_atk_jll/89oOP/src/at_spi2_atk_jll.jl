# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule at_spi2_atk_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("at_spi2_atk")
JLLWrappers.@generate_main_file("at_spi2_atk", UUID("de012916-1e3f-58c2-8f29-df3ef51d412d"))
end  # module at_spi2_atk_jll
