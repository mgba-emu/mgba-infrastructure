if(_INCLUDED_TOOLCHAIN_FILE)
  return()
endif()

set(cross_prefix /usr/local/bin/x86_64-linux-gnu-)
set(root /opt/roots/ubuntu64-wily)

set(CMAKE_SYSTEM_NAME Linux CACHE INTERNAL "system name")
set(CMAKE_LIBRARY_ARCHITECTURE x86_64-linux-gnu CACHE INTERNAL "system triplet")
set(CMAKE_AR ${cross_prefix}ar CACHE FILEPATH "archiver")
set(CMAKE_C_COMPILER ${cross_prefix}gcc)
set(CMAKE_CXX_COMPILER ${cross_prefix}g++)
set(CMAKE_ASM_COMPILER ${cross_prefix}gcc)
set(CMAKE_LINKER ${cross_prefix}ld)

set(toolchain_dir ${root}/usr)
set(toolchain_bin_dir ${toolchain_dir}/bin)
set(toolchain_inc_dir ${toolchain_dir}/include)
set(toolchain_lib_dir ${toolchain_dir}/lib/${CMAKE_LIBRARY_ARCHITECTURE})
set(toolchain_inc2_dir ${toolchain_dir}/include/${CMAKE_LIBRARY_ARCHITECTURE})
set(common_flags "--sysroot=${root} -I${toolchain_inc2_dir} -Wl,-rpath-link,${root}/lib/${CMAKE_LIBRARY_ARCHITECTURE}:${toolchain_lib_dir}")
set(ENV{PKG_CONFIG_PATH} ${toolchain_lib_dir}/pkgconfig:${toolchain_dir}/lib/pkgconfig:${toolchain_dir}/share/pkgconfig)
set(ENV{PKG_CONFIG_LIBDIR} ${toolchain_dir}/usr/pkgconfig)
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${root})
set(CMAKE_SYSTEM_PROGRAM_PATH /usr/local/bin)
set(CMAKE_PREFIX_PATH ${toolchain_lib_dir};${toolchain_dir})
set(CMAKE_MODULE_PATH ${toolchain_lib_dir}/cmake)
set(PKG_CONFIG_EXECUTABLE /usr/local/bin/pkg-config CACHE INTERNAL "" FORCE)

set(CMAKE_C_FLAGS "${common_flags}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS "${common_flags}" CACHE INTERNAL "")

set(CMAKE_EXE_LINKER_FLAGS ${common_flags} CACHE INTERNAL "exe link flags")
set(CMAKE_MODULE_LINKER_FLAGS ${common_flags} CACHE INTERNAL "module link flags")
set(CMAKE_SHARED_LINKER_FLAGS ${common_flags} CACHE INTERNAL "shared link flags")
set(CMAKE_FIND_ROOT_PATH "${toolchain_lib_dir};${toolchain_dir};${root}" CACHE INTERNAL "cross root directory")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY CACHE INTERNAL "")

set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE amd64)

set(CROSS_ROOT ${root} CACHE INTERNAL "cross compile root")

add_executable(Qt5::moc IMPORTED)
set_target_properties(Qt5::moc PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/moc)
get_target_property(QT_MOC_EXECUTABLE Qt5::moc LOCATION)

add_executable(Qt5::rcc IMPORTED)
set_target_properties(Qt5::rcc PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/rcc)

add_executable(Qt5::uic IMPORTED)
set_target_properties(Qt5::uic PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/uic)
