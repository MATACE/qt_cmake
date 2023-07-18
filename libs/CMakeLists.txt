option(USE_LIB_MATHFUNCTIONS "checkout " ON)

if(USE_LIB_MATHFUNCTIONS)
    add_subdirectory(MathFunctions)
    add_file(QT_THIRD_LIBS MathFunc)
endif()

# 注意变量间的调用顺序
# cmake:在各级子项目(目录)之间共享变量

# set
# set(ICD_LIBRARY "${PROJECT_BINARY_DIR}/lib" CACHE INTERNAL "Share Val")
# "Share Val" 对变量的描述说明,不能省略
# 其他地方使用MESSAGE(STATUS "ICD_LIBRARY :${ICD_LIBRARY}")

# set_property/get_property
# set_property(GLOBAL PROPERTY INCLUDE "${CMAKE_CURRENT_LIST_DIR}/include")
# 先调用get_property将这个property读取到一个变量中(variable)INCLUDE
# get_property(MINCLUDE GLOBAL PROPERTY INCLUDE ) 
# 显示MINCLUDE
# MESSAGE(STATUS "${MINCLUDE}")
