# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule PCRE_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("PCRE")
JLLWrappers.@generate_main_file("PCRE", UUID("2f80f16e-611a-54ab-bc61-aa92de5b98fc"))
end  # module PCRE_jll
