# Autogenerated wrapper script for ATK_jll for i686-w64-mingw32
export libatk

using Glib_jll
JLLWrappers.@generate_wrapper_header("ATK")
JLLWrappers.@declare_library_product(libatk, "libatk-1.0-0.dll")
function __init__()
    JLLWrappers.@generate_init_header(Glib_jll)
    JLLWrappers.@init_library_product(
        libatk,
        "bin\\libatk-1.0-0.dll",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()