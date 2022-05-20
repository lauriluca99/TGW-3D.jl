# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Dbus_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Dbus")
JLLWrappers.@generate_main_file("Dbus", UUID("ee1fde0b-3d02-5ea6-8484-8dfef6360eab"))
end  # module Dbus_jll
