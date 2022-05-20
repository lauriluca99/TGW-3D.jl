# Autogenerated wrapper script for Pango_jll for i686-w64-mingw32
export libpango, libpangocairo, libpangoft

using Cairo_jll
using Fontconfig_jll
using FreeType2_jll
using FriBidi_jll
using Glib_jll
using HarfBuzz_jll
JLLWrappers.@generate_wrapper_header("Pango")
JLLWrappers.@declare_library_product(libpango, "libpango-1.0-0.dll")
JLLWrappers.@declare_library_product(libpangocairo, "libpangocairo-1.0-0.dll")
JLLWrappers.@declare_library_product(libpangoft, "libpangoft2-1.0-0.dll")
function __init__()
    JLLWrappers.@generate_init_header(Cairo_jll, Fontconfig_jll, FreeType2_jll, FriBidi_jll, Glib_jll, HarfBuzz_jll)
    JLLWrappers.@init_library_product(
        libpango,
        "bin\\libpango-1.0-0.dll",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@init_library_product(
        libpangocairo,
        "bin\\libpangocairo-1.0-0.dll",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@init_library_product(
        libpangoft,
        "bin\\libpangoft2-1.0-0.dll",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()