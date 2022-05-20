# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Libepoxy_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Libepoxy")
JLLWrappers.@generate_main_file("Libepoxy", UUID("42c93a91-0102-5b3f-8f9d-e41de60ac950"))
end  # module Libepoxy_jll
