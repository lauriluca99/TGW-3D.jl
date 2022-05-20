# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule XSLT_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("XSLT")
JLLWrappers.@generate_main_file("XSLT", UUID("aed1982a-8fda-507f-9586-7b0439959a61"))
end  # module XSLT_jll
