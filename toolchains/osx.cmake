if(_INCLUDED_TOOLCHAIN_FILE)
  return()
endif()

set(root /opt/roots/osx-self)
set(rootold /opt/roots/osx)
set(toolchain_dir ${root})
set(toolchain_bin_dir ${toolchain_dir}/bin)
set(toolchain_inc_dir ${toolchain_dir}/include)
set(toolchain_lib_dir ${toolchain_dir}/lib)
set(cross_prefix /opt/osxcross/target/bin/x86_64-apple-darwin13-)
set(ENV{PKG_CONFIG_LIBDIR} ${toolchain_dir}/lib/pkgconfig)
set(ENV{PKG_CONFIG_PATH} ${toolchain_lib_dir}/pkgconfig:${toolchain_dir}/share/pkgconfig:${root}/usr/lib/pkgconfig)
set(CMAKE_SYSTEM_PROGRAM_PATH /usr/local/bin)
set(CMAKE_PREFIX_PATH ${toolchain_dir};${root}/usr/local/opt/qt5)
set(CMAKE_SYSTEM_FRAMEWORK_PATH "${rootold}/System/Library/Frameworks" "${rootold}/Library/Frameworks")

set(CMAKE_SYSTEM_NAME Darwin CACHE INTERNAL "system name")
set(CMAKE_AR ${cross_prefix}ar CACHE FILEPATH "archiver")
set(CMAKE_C_COMPILER ${cross_prefix}clang)
set(CMAKE_CXX_COMPILER ${cross_prefix}clang++)
set(CMAKE_ASM_COMPILER ${cross_prefix}clang)
set(CMAKE_LINKER ${cross_prefix}ld)
set(CMAKE_OTOOL ${cross_prefix}otool)
set(CMAKE_INSTALL_NAME_TOOL ${cross_prefix}install_name_tool)

set(link_flags "-framework CoreFoundation")

set(CMAKE_EXE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "exe link flags")
set(CMAKE_MODULE_LINKER_FLAGS ${link_flags} CACHE INTERNAL "module link flags")
set(CMAKE_SHARED_LINKER_FLAGS ${link_flags} CACHE INTERNAL "shared link flags")
set(CMAKE_FIND_ROOT_PATH "${toolchain_lib_dir};${root};${rootold}" CACHE INTERNAL "cross root directory")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY CACHE INTERNAL "")
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY CACHE INTERNAL "")

set(CROSS_ROOT ${root} CACHE INTERNAL "cross compile root")

add_executable(Qt5::moc IMPORTED)
set_target_properties(Qt5::moc PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/moc)
get_target_property(QT_MOC_EXECUTABLE Qt5::moc LOCATION)

add_executable(Qt5::rcc IMPORTED)
set_target_properties(Qt5::rcc PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/rcc)

add_executable(Qt5::uic IMPORTED)
set_target_properties(Qt5::uic PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/uic)

add_executable(Qt5::lupdate IMPORTED)
set_target_properties(Qt5::lupdate PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/lupdate)

add_executable(Qt5::lrelease IMPORTED)
set_target_properties(Qt5::lrelease PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/lrelease)

add_executable(Qt5::lconvert IMPORTED)
set_target_properties(Qt5::lconvert PROPERTIES IMPORTED_LOCATION /usr/local/lib/qt5/bin/lconvert)
