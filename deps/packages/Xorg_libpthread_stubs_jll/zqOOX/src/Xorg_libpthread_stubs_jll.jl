# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libpthread_stubs_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libpthread_stubs")
JLLWrappers.@generate_main_file("Xorg_libpthread_stubs", UUID("14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"))
end  # module Xorg_libpthread_stubs_jll
