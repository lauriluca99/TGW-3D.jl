# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule iso_codes_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("iso_codes")
JLLWrappers.@generate_main_file("iso_codes", UUID("bf975903-5238-5d20-8243-bc370bc1e7e5"))
end  # module iso_codes_jll
