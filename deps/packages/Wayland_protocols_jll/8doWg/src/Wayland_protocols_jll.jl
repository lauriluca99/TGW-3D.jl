# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Wayland_protocols_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Wayland_protocols")
JLLWrappers.@generate_main_file("Wayland_protocols", UUID("2381bf8a-dfd0-557d-9999-79630e7b1b91"))
end  # module Wayland_protocols_jll
