cmake_minimum_required(VERSION 3.16)

project(MuticastSenderStub VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Xml)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMuticastSenderStub
    main.cpp
)

qt_add_qml_module(appMuticastSenderStub
    URI MuticastSenderStub
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES MulticastSender.h MulticastSender.cpp
        RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMuticastSenderStub PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMuticastSenderStub
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMuticastSenderStub
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Xml
)

include(GNUInstallDirs)
install(TARGETS appMuticastSenderStub
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
