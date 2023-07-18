if(NOT LIBXXX_FOUND)
    # 去默认路径下找叫做xxx模块的库
    # 生成一个可以导入的目标
    # pkg_check_modules(SDL2 IMPORTED_TARGET sdl2)
    # if (SDL2_FOUND)
        # include_directories(${SDL2_INCLUDE_DIRS})
        # link_directories(${SDL2_LIBRARY_DIRS})
        # list(APPEND LINK_LIB_LIST ${SDL2_LIBRARIES})
        # target_link_libraries(${PROJECT_NAME}  PkgConfig::SDL2)
        # message(STATUS "found library:${SDL2_LIBRARIES}")
    # endif ()
    # 不生成一个可以导入的目标
    pkg_check_modules (LIBXXX_PKG libxxx)
    # 生成LIBXXX_INCLUDE_DIRS LIBXXX_LIBRARY_DIRS 等变量
  find_path(LIBXXX_INCLUDE_DIRS NAMES xxx.h
    PATHS
    ${LIBXXX_PKG_INCLUDE_DIRS}
    /usr/include
    /usr/local/include
  )

  find_library(LIBXXX_LIBRARIES NAMES xxx
    PATHS
    ${LIBXXX_PKG_LIBRARY_DIRS}
    /usr/lib
    /usr/local/lib
  )

if(LIBXXX_INCLUDE_DIRS AND LIBXXX_LIBRARIES)
  set(LIBXXX_FOUND TRUE CACHE INTERNAL "libxxx found")
  message(STATUS "Found libxxx: ${LIBXXX_INCLUDE_DIRS}, ${LIBXXX_LIBRARIES}")
else(LIBXXX_INCLUDE_DIRS AND LIBXXX_LIBRARIES)
  set(LIBXXX_FOUND FALSE CACHE INTERNAL "libxxx found")
  message(STATUS "libxxx not found.")
endif(LIBXXX_INCLUDE_DIRS AND LIBXXX_LIBRARIES)

mark_as_advanced(LIBXXX_INCLUDE_DIRS LIBXXX_LIBRARIES)

endif(NOT LIBXXX_FOUND)
