cmake_minimum_required(VERSION 3.16)

project(SmartFooter LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Qml Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Qml Quick)

add_library(SmartFooter SHARED
  SmartFooter_global.h
  smartfooter.cpp
  smartfooter.h
  res.qrc
  ifooterinterface.h
)

target_link_libraries(SmartFooter PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Quick
)

target_compile_definitions(SmartFooter PRIVATE SMARTFOOTER_LIBRARY)
