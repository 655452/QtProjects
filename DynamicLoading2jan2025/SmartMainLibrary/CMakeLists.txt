cmake_minimum_required(VERSION 3.16)

project(SmartMainLibrary LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS  Core Qml Quick Xml)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS  Core Qml Quick Xml)

add_library(SmartMainLibrary SHARED
  SmartMainLibrary_global.h
  smartmainlibrary.cpp
  smartmainlibrary.h
  res.qrc
  ismartmainlibraryinterface.h
  ComponentConfig.xml


)

target_link_libraries(SmartMainLibrary PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Xml
)

target_compile_definitions(SmartMainLibrary PRIVATE SMARTMAINLIBRARY_LIBRARY)
