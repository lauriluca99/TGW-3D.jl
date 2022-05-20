# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Libgcrypt_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Libgcrypt")
JLLWrappers.@generate_main_file("Libgcrypt", UUID("d4300ac3-e22c-5743-9152-c294e39db1e4"))
end  # module Libgcrypt_jll
