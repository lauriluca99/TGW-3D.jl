# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule LLVMExtra_jll
using Base
using Base: UUID
using LazyArtifacts
Base.include(@__MODULE__, joinpath("..", ".pkg", "platform_augmentation.jl"))
import JLLWrappers

JLLWrappers.@generate_main_file_header("LLVMExtra")
JLLWrappers.@generate_main_file("LLVMExtra", UUID("dad2f222-ce93-54a1-a47d-0025e8a3acab"))
end  # module LLVMExtra_jll
