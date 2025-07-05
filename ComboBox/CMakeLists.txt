cmake_minimum_required(VERSION 3.16)

project(ComboBox VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Xml REQUIRED)

qt_add_executable(appComboBox
    main.cpp
)

qt_add_qml_module(appComboBox
    URI ComboBox
    VERSION 1.0
    QML_FILES main.qml
    QML_FILES TreeItem.qml
    SOURCES treeitem.h treeitem.cpp
    SOURCES treemodel.h treemodel.cpp
    QML_FILES ExpandableSection.qml
    QML_FILES PieMenu.qml
    RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appComboBox PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appComboBox
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appComboBox
    PRIVATE Qt6::Quick
        Qt6::Xml
)

include(GNUInstallDirs)
install(TARGETS appComboBox
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
