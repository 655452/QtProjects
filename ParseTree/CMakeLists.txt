cmake_minimum_required(VERSION 3.16)

project(ParseTree VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Xml REQUIRED)

qt_add_executable(appParseTree
    main.cpp
)

qt_add_qml_module(appParseTree
    URI ParseTree
    VERSION 1.0
    QML_FILES main.qml
    SOURCES TreeNavigator.h TreeNavigator.cpp
    QML_FILES ActionMap.js
    SOURCES ActionEventManager.h ActionEventManager.cpp
    SOURCES ActionEventManager.h ActionEventManager.cpp
    SOURCES ActionEventManager.h ActionEventManager.cpp
    SOURCES ExposedObjectRegistry.h ExposedObjectRegistry.cpp
    RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appParseTree PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appParseTree
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appParseTree
    PRIVATE
    Qt6::Quick
    Qt6::Xml
)

include(GNUInstallDirs)
install(TARGETS appParseTree
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
