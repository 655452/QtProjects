cmake_minimum_required(VERSION 3.16)

project(SmartMainScreen LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Qml Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Qml Quick)

add_library(SmartMainScreen SHARED
  SmartMainScreen_global.h
  smartmainscreen.cpp
  smartmainscreen.h
  res.qrc
  imainscreeninterface.h
)

target_link_libraries(SmartMainScreen PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Quick
)

target_compile_definitions(SmartMainScreen PRIVATE SMARTMAINSCREEN_LIBRARY)
