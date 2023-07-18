cmake_minimum_required(VERSION 3.10)

project(qt_cmake LANGUAGES CXX)

# 定义CMAKE_BUILD_TYPE变量
set(CMAKE_BUILD_TYPE Debug)

# 设置版本号
set(${PROJECT_NAME}_MAJOR "1")
set(${PROJECT_NAME}_MINOR "0")
set(${PROJECT_NAME}_PATCH "0")

# 设置是否编译动态库
option(BUILD_SHARED_LIBS "Build the project shared library" OFF)

# 设置CMAKE_MODULE位置
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

# 设置编译的参数版本
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# .a .lib静态库位置
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/install")
# .dll exe 可执行文件位置
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/install")
# .so 库位置
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/install")

# 设置CMake QT环境
# 设置工程包含当前目录
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# 设置自动生成moc文件,AUTOMOC打开可以省去QT5_WRAP_CPP命令
# 自动生成的路径存在无法匹配问题
# set(CMAKE_AUTOUIC ON)
# 设置自动生成moc文件,AUTOMOC打开可以省去QT5_WRAP_CPP命令
set(CMAKE_AUTOMOC ON)
# 设置自动处理.qrc文件
set(CMAKE_AUTORCC ON)

# 收集子目录中对应的类型文件到某个全局属性中
function(add_file list)
    # 如果定义了不重新定义
    get_property(is_defined GLOBAL PROPERTY ${list} DEFINED)
    if(NOT is_defined)
        define_property(GLOBAL PROPERTY ${list}
                BRIEF_DOCS "List of source files"
                FULL_DOCS "List of source files to be compiled in one library")
    endif()
    set(SRCS)
    foreach(S IN LISTS ARGN)
        # message(STATUS "${S}")
        list(APPEND SRCS "${S}")
    endforeach()
    # 添加到全局列表
    # message(${SRCS})
    set_property(GLOBAL APPEND PROPERTY ${list} "${SRCS}")
    # message(STATUS "${list}")
endfunction()

# 设置不同平台的编译参数

# 设置所需资源库路径
# set(OpenCV_DIR "E:/Program Files/opencv/build")
# set(Qt5_DIR "D:/Qt/5.15.2/msvc2019_64/lib/cmake/Qt5")

# 通过find_package查找需要依赖的包
# 指定Qt依赖项
find_package(Qt5 COMPONENTS Widgets Core Gui REQUIRED)
# 和Modules中名字对应
# find_package(Libxxx)
# 指定OpenCV依赖项
# find_package(OpenCV REQUIRED)

# 添加库头文件目录
# include_directories()

# 添加库文件目录
# link_directories()

# 链接库文件
# link_libraries()

# 需要用到库的共享变量需要先cmake第三方库
# 添加本地第三方库
add_subdirectory(libs)

# 添加子目录
add_subdirectory(src)

# Doxygen 生成文档
include(BuildDoxygen)

# uninstall target 卸载命令
# https://cmake.org/Wiki/CMake_FAQ#Can_I_do_.22make_uninstall.22_with_CMake.3F
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)
add_custom_target(uninstall
    ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
)

# 打包成二进制文件
include(InstallRequiredSystemLibraries)
# set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)



