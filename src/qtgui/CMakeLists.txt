# 包含头文件
add_file(QT_HEAD_PATH "${CMAKE_CURRENT_LIST_DIR}/include")

# 递归查找
# file(GLOB_RECURSE <variable> "${<dir>}/*.cpp" "${<dir>}/*.c" "${<dir>}/*.cxx")
file(GLOB HEAD_FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")
file(GLOB SRC_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")
file(GLOB UI_FILES "${CMAKE_CURRENT_SOURCE_DIR}/ui/*.ui")

add_file(QT_SRC_FILES ${SRC_FILES})
add_file(QT_HEAD_FILES ${HEAD_FILES})
add_file(QT_UI_FILES ${UI_FILES})