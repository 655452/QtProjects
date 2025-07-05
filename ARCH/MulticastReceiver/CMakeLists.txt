cmake_minimum_required(VERSION 3.16)

project(MulticastReceiver LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Network  Qml Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Network  Qml Quick)

add_library(MulticastReceiver SHARED
  MulticastReceiver_global.h
  multicastreceiver.cpp
  multicastreceiver.h
  iMulticastReceiver.h
)

target_link_libraries(MulticastReceiver
    PRIVATE Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Network
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Quick
)

target_compile_definitions(MulticastReceiver PRIVATE MULTICASTRECEIVER_LIBRARY)
