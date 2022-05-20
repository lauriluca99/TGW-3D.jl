# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Xorg_libXfixes_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Xorg_libXfixes")
JLLWrappers.@generate_main_file("Xorg_libXfixes", UUID("d091e8ba-531a-589c-9de9-94069b037ed8"))
end  # module Xorg_libXfixes_jll
