cmake_minimum_required(VERSION 3.14)

project(SharedDataModel LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Qml Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Qml Quick Core)

add_library(SharedDataModel SHARED
    SharedDataModel_global.h
    shareddatamodel.cpp
    shareddatamodel.h
    isharedmodelinterface.h
)

target_link_libraries(SharedDataModel
    PRIVATE Qt${QT_VERSION_MAJOR}::Core
    PRIVATE Qt${QT_VERSION_MAJOR}::Qml
    PRIVATE Qt${QT_VERSION_MAJOR}::Quick
)

target_compile_definitions(SharedDataModel PRIVATE SHAREDDATAMODEL_LIBRARY)
