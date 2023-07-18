# 添加一个名为MathFunctions的库,其源代码为MathFunctions.cxx
# add_library命令
# 编译成静态文件

# 包含头文件路径
add_file(QT_THIRD_HEAD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/include")

# 递归查找
# file(GLOB_RECURSE <variable> "${<dir>}/*.cpp" "${<dir>}/*.c" "${<dir>}/*.cxx")
file(GLOB THIRD_HEAD_FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")
file(GLOB THIRD_SRC_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# add_file(QT_THIRD_HEAD_FILES ${THIRD_SRC_FILES})
# add_file(QT_THIRD_SRC_FILES ${THIRD_HEAD_FILES})
# add_file(QT_UI_FILES ${MY_UI_FILES})

# 库的名字和.cmake的配置要匹配
add_library(MathFunc
    ${THIRD_HEAD_FILES}
    ${THIRD_SRC_FILES}
)

# 包含指定exe或library目标的头文件位置
# CMAKE_CURRENT_SOURCE_DIR当前的CMakeLists的位置
# INTERFACE 本目标不需要用,依赖这个目标的其他目标也需要用
# PUBLIC    本目标需要用,依赖这个目标的其他目标也需要用
# PRIVATE   本目标需要用,依赖这个目标的其他目标不需要用
# 不需要findpackage时
# target_include_directories(MathFunc PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
# 需要find_package时,区别自己使用和别人使用的路径
target_include_directories(MathFunc PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
# 之间通过参数设置C++11标准
set_property(TARGET MathFunc PROPERTY CXX_STANDARD 11)
set_property(TARGET MathFunc PROPERTY CXX_STANDARD_REQUIRED ON)

# 通过虚拟库设置C++标准
# target_link_libraries(MathFunc PUBLIC cxx_flags)
# message(STATUS ${CMAKE_INSTALL_PREFIX})

# message(STATUS ${CMAKE_SOURCE_DIR})
# message(STATUS ${CMAKE_CURRENT_BINARY_DIR})
# message(STATUS ${CMAKE_CURRENT_LIST_DIR})
# message(STATUS ${CMAKE_CURRENT_SOURCE_DIR})
# message(STATUS ${CMAKE_CURRENT_BINARY_DIR})
# 每个cmake build都有自己的文件夹

# 安装库的静态库或者动态库到某个位置
set(math_libs MathFunc)
# 提供lib.cmake配置文件使用find_package
install(TARGETS ${math_libs}
    EXPORT MathFunc
    DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
)

# 复制cmake文件到lib中
install(EXPORT MathFunc
    FILE MathFunc.cmake
    DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
)

#安装库的头文件到某个位置
set(inc_files
    ${THIRD_HEAD_FILES}
)

install(FILES ${inc_files} DESTINATION ${CMAKE_SOURCE_DIR}/install/inc)

include(CMakePackageConfigHelpers)
# 通过模板文件生成配置文件
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/MathFuncConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

# 生成版本
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/MathFuncVersion.cmake"
    VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
    COMPATIBILITY AnyNewerVersion
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/MathFuncConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/MathFuncVersion.cmake
    DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
)

# 给库构建一个.cmake配置文件,给别人用find_package进行使用
# target_include_directories时区别构建还是find_package
# install(TARGETS)时使用EXPORT导出为xxx.cmake
# install(EXPORT)时把xxx.cmake复制过去
# 在库下的CMakeLists.txt建立一个config.cmake.in文件
