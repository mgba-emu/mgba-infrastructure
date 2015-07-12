set(toolchain_dir /opt/roots/win32-static)
set(toolchain_bin_dir ${toolchain_dir}/bin)
set(toolchain_inc_dir ${toolchain_dir}/include)
set(toolchain_lib_dir ${toolchain_dir}/lib)
set(cross_prefix /usr/local/bin/i686-w64-mingw32-)
set(ENV{PKG_CONFIG_LIBDIR} ${toolchain_dir}/lib/pkgconfig)
set(ENV{PKG_CONFIG_PATH} ${toolchain_lib_dir}/pkgconfig:${toolchain_dir}/share/pkgconfig)
set(CMAKE_PREFIX_PATH ${toolchain_dir})

set(inc_flags "-I/usr/local/i686-w64-mingw32/include -B/usr/local/lib/gcc/i686-w64-mingw32/4.9.1 -I${toolchain_dir}/usr/include")
set(link_flags "-static-libgcc -static-libstdc++ -Bstatic -L${toolchain_dir}/plugins/platforms -L${toolchain_dir}/plugins/audio")

set(CMAKE_SYSTEM_NAME Windows CACHE INTERNAL "system name")
set(CMAKE_AR ${cross_prefix}ar CACHE FILEPATH "archiver")
set(CMAKE_C_COMPILER ${cross_prefix}gcc)
set(CMAKE_CXX_COMPILER ${cross_prefix}g++)
set(CMAKE_ASM_COMPILER ${cross_prefix}gcc)
set(CMAKE_RC_COMPILER ${cross_prefix}windres)
set(CMAKE_LINKER ${cross_prefix}ld)

set(CMAKE_EXE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "exe link flags")
set(CMAKE_MODULE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "module link flags")
set(CMAKE_SHARED_LINKER_FLAGS "${link_flags} -Wl,--export-all-symbols" CACHE INTERNAL "shared link flags")
set(CMAKE_FIND_ROOT_PATH "${toolchain_dir}" CACHE INTERNAL "cross root directory")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY CACHE INTERNAL "")

set(WINHID_ROOT_DIR /usr/local/i686-w64-mingw32/)

set(CROSS_ROOT ${root} CACHE INTERNAL "cross compile root")
