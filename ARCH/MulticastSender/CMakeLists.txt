cmake_minimum_required(VERSION 3.16)

project(MulticastSender LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Network  Qml Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Network  Qml Quick)

add_library(MulticastSender SHARED
  MulticastSender_global.h
  multicastsender.cpp
  multicastsender.h
  imulticastsender.h
  res.qrc
)

target_link_libraries(MulticastSender PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    PRIVATE Qt${QT_VERSION_MAJOR}::Qml
    PRIVATE Qt${QT_VERSION_MAJOR}::Quick
)

target_compile_definitions(MulticastSender PRIVATE MULTICASTSENDER_LIBRARY)
