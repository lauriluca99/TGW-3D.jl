# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule xkbcommon_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("xkbcommon")
JLLWrappers.@generate_main_file("xkbcommon", UUID("d8fb68d0-12a3-5cfd-a85a-d49703b185fd"))
end  # module xkbcommon_jll
