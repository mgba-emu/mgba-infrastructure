set(toolchain_dir /home/jeffrey/raspi/root)
set(toolchain_bin_dir ${toolchain_dir}/usr/bin)
set(toolchain_inc_dir ${toolchain_dir}/usr/include/arm-linux-gnueabihf)
set(toolchain_lib_dir ${toolchain_dir}/usr/lib/arm-linux-gnueabihf)
set(opt_dir ${toolchain_dir}/opt/vc)
set(opt_inc_dir ${opt_dir}/include)
set(opt_lib_dir ${opt_dir}/lib)
set(cross_prefix /usr/local/bin/arm-linux-gnueabihf-)
set(ENV{PKG_CONFIG_LIBDIR} ${toolchain_dir}/usr/lib/pkgconfig)
set(ENV{PKG_CONFIG_PATH} ${toolchain_dir}/usr/lib/local/pkgconfig:${toolchain_lib_dir}/pkgconfig)
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${toolchain_dir})
set(PKG_CONFIG_EXECUTABLE /usr/local/bin/pkg-config)

set(inc_flags "-I/usr/local/arm-linux-gnueabihf/include -I/usr/local/lib/gcc/arm-linux-gnueabihf/4.8.2/include -I/usr/local/lib/gcc/arm-linux-gnueabihf/4.8.2/include-fixed -I${opt_inc_dir} -I${opt_inc_dir}/interface/vcos/pthreads/ -I${opt_inc_dir}/interface/vmcs_host/ -I${opt_inc_dir}/interface/vmcs_host/linux/ -I${toolchain_dir}/usr/include -nostdinc")

set(CMAKE_SYSTEM_NAME Linux CACHE INTERNAL "system name")
set(CMAKE_SYSTEM_PROCESSOR arm CACHE INTERNAL "processor")
set(CMAKE_LIBRARY_ARCHITECTURE arm-linux-gnueabihf CACHE INTERNAL "abi")
set(CMAKE_AR ${cross_prefix}ar CACHE FILEPATH "archiver")
set(CMAKE_C_COMPILER ${cross_prefix}gcc)
#set(CMAKE_CXX_COMPILER ${cross_prefix}g++)
#set(CMAKE_ASM_COMPILER ${cross_prefix}gcc)
set(CMAKE_C_FLAGS "-mcpu=arm1176jzf-s -mfloat-abi=hard --sysroot=${toolchain_dir} ${inc_flags}" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS "-mcpu=arm1176jzf-s -mfloat-abi=hard --sysroot=${toolchain_dir} ${inc_flags}" CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS "-mcpu=arm1176jzf-s -mfloat-abi=hard --sysroot=${toolchain_dir} ${inc_flags}" CACHE INTERNAL "cxx compiler flags")
#set(ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER> <FLAGS> -o <OBJECT> -c <SOURCE>")

set(link_flags "-L${toolchain_lib_dir} -L${opt_lib_dir} -Wl,-rpath-link,${toolchain_lib_dir},-rpath-link,${opt_lib_dir},-rpath-link,${toolchain_dir}/lib/arm-linux-gnueabihf,-rpath-link,${toolchain_lib_dir}/pulseaudio -B${toolchain_lib_dir} -ldl -lc --sysroot=${toolchain_dir}")

set(CMAKE_EXE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "exe link flags")
set(CMAKE_MODULE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "module link flags")
set(CMAKE_SHARED_LINKER_FLAGS ${link_flags} CACHE INTERNAL "shared link flags")
#set(CMAKE_PREFIX_PATH "${toolchain_dir};${toolchain_dir}/usr")
set(CMAKE_FIND_ROOT_PATH "${toolchain_dir};${toolchain_dir}/usr;${toolchain_lib_dir}" CACHE INTERNAL "cross root directory")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH CACHE INTERNAL "")
