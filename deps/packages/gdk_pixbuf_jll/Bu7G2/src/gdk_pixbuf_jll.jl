# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule gdk_pixbuf_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("gdk_pixbuf")
JLLWrappers.@generate_main_file("gdk_pixbuf", UUID("da03df04-f53b-5353-a52f-6a8b0620ced0"))
end  # module gdk_pixbuf_jll
