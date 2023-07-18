# 添加子目录
add_subdirectory(app)
add_subdirectory(qtgui)


# 引入全局变量的属性
# src的源文件
get_property(${PROJECT_NAME}_SOURCE GLOBAL PROPERTY QT_SRC_FILES)
get_property(${PROJECT_NAME}_HEAD_SOURCE GLOBAL PROPERTY QT_HEAD_FILES)
get_property(${PROJECT_NAME}_UI_SOURCE GLOBAL PROPERTY QT_UI_FILES)
# src的头文件
get_property(${PROJECT_NAME}_HEAD_PATH GLOBAL PROPERTY QT_HEAD_PATH)

# libs的源文件
get_property(${PROJECT_NAME}_THIRD_LIBS GLOBAL PROPERTY QT_THIRD_LIBS)
# libs的头文件
get_property(${PROJECT_NAME}_THIRD_HEAD_PATH GLOBAL PROPERTY QT_THIRD_HEAD_PATH)

# message(STATUS "${${PROJECT_NAME}_HEAD_PATH}")
# message(STATUS "${${PROJECT_NAME}_THIRD_HEAD_PATH}")
# get_property(O_HE_FF GLOBAL PROPERTY HE_FF)
# message(STATUS "${O_HE_FF}")

# get_property(HEAD_HE_FF GLOBAL PROPERTY QT_THIRD_HEAD_PATH)
# message(STATUS "${HEAD_HE_FF}")

# 添加app需要的所有的头文件
include_directories(
    "${CMAKE_CURRENT_LIST_DIR}"
    "${${PROJECT_NAME}_HEAD_PATH}"
)

# 添加app的源文件

#设置自动生成UI文件夹
QT5_WRAP_UI(UI_HEAD_FILES ${${PROJECT_NAME}_UI_SOURCE})
# source_group("Ui" FILES "${${PROJECT_NAME}_UI_SOURCE}" "${WRAP_FILES}")

# 添加app的资源目录
set(RESOURCES_DIR ${PROJECT_SOURCE_DIR}/resources)

# 生成资源文件
# 递归查找
# file(GLOB_RECURSE <variable> "${<dir>}/*.cpp" "${<dir>}/*.c" "${<dir>}/*.cxx")
# file(GLOB MY_HEAD_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
file(GLOB_RECURSE RESOURCES_LIST "${RESOURCES_DIR}/*.qrc")
qt5_add_resources(RESOURCES ${RESOURCES_LIST})
# message(STATUS ${RESOURCES_LIST})

# message(STATUS ${${PROJECT_NAME}_HEAD_SOURCE})
# 生成可执行目标文件
add_executable(${PROJECT_NAME}
               ${UI_HEAD_FILES}
               ${${PROJECT_NAME}_HEAD_SOURCE} 
               ${${PROJECT_NAME}_SOURCE}
               ${RESOURCES}
)

# 链接可执行文件的头文件
# target_link_directories(Tutorial PRIVATE "${opencv_dir}"/lib)
target_include_directories(${PROJECT_NAME} PRIVATE ${${PROJECT_NAME}_THIRD_HEAD_PATH})

# 链接可执行文件的头文件
# target_link_directories(Tutorial PRIVATE "${opencv_dir}"/lib)

# 链接可执行文件的QT库
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Widgets)

# 链接可执行文件的第三方库
# target_link_libraries(Tutorial PRIVATE OpenCV)
target_link_libraries(${PROJECT_NAME} PRIVATE ${${PROJECT_NAME}_THIRD_LIBS})

# 安装可执行文件和头文件
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_SOURCE_DIR}/install/bin)

install(FILES ${${PROJECT_NAME}_HEAD_SOURCE} DESTINATION ${CMAKE_SOURCE_DIR}/install/inc)

# 安装内置库文件和工具
set(INSTALL_TARGETS ${${PROJECT_NAME}_THIRD_LIBS} ${PROJECT_NAME})
install(TARGETS ${INSTALL_TARGETS}
    LIBRARY DESTINATION ${CMAKE_SOURCE_DIR}/install/sys/lib # .so/.dylib file
    ARCHIVE DESTINATION ${CMAKE_SOURCE_DIR}/install/sys/lib # .lib file
    RUNTIME DESTINATION ${CMAKE_SOURCE_DIR}/install/sys/bin              # .dll file
)