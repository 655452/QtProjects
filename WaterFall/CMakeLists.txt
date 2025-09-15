cmake_minimum_required(VERSION 3.16)

project(WaterFall VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Charts Core Gui Qml)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appWaterFall
    main.cpp
)

qt_add_qml_module(appWaterFall
    URI WaterFall
    VERSION 1.0
    QML_FILES qml/Main.qml
        qml/WaterFallDisplay.qml
        qml/MouseTrackerTooltip.qml
        qml/TrackLabel.qml
        qml/RangeSliderWaterFall.qml
    RESOURCES res.qrc
    SOURCES
        WaterFallDataModel.h WaterFallDataModel.cpp
        WaterFallConstants.h WaterFallConstants.cpp
        ChartManager.h ChartManager.cpp
)
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWaterFall PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWaterFall
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWaterFall
    PUBLIC
        Qt::Charts
        Qt::Core
        Qt::Gui
        Qt::Qml
        Qt::Quick
)

set(resources_resource_files
       "qml/Main.qml"
)

qt6_add_resources(appWaterFall "WaterFall"
    PREFIX
        ""
    FILES
        ${resources_resource_files}
)

include(GNUInstallDirs)
install(TARGETS appWaterFall
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
