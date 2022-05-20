# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Gettext_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Gettext")
JLLWrappers.@generate_main_file("Gettext", UUID("78b55507-aeef-58d4-861c-77aaff3498b1"))
end  # module Gettext_jll
