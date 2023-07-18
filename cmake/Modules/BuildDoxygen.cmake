# 设置版本号Doxygen
set(DOXYGEN_MAJOR ${${PROJECT_NAME}_MAJOR})
set(DOXYGEN_MINOR ${${PROJECT_NAME}_MINOR})
set(DOXYGEN_PATCH ${${PROJECT_NAME}_PATCH})

set(DOXY_MAIN_PAGE "${PROJECT_SOURCE_DIR}/README.md")
# add a target to generate API documentation with Doxygen
find_package(Doxygen)
option(BUILD_DOCUMENTATION "Create and install the HTML based API documentation (requires Doxygen)" ${DOXYGEN_FOUND})

if(BUILD_DOCUMENTATION)
    if(NOT DOXYGEN_FOUND)
        message(FATAL_ERROR "Doxygen is needed to build the documentation")
    endif()

    set(doxyfile_in ${PROJECT_SOURCE_DIR}/docs/Doxyfile.in)
    set(doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

    configure_file(${doxyfile_in} ${doxyfile} @ONLY)

    add_custom_target(docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM)

    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html DESTINATION ${PROJECT_SOURCE_DIR}/docs/html)
endif()