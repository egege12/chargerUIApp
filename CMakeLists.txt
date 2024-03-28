cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(chargerUIApp LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON )
file(GLOB src "src/*.cpp")
file(GLOB header "src/*.h")
find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick Network)
#find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick Qt6Network QuickControls2)
#find_package(Qt6 REQUIRED COMPONENTS QuickControls2)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(chargerUIApp
   ${src}
   ${header}
   ButtonBar.qml
   MenuButton.qml
   PopupWindow.qml
    )

qt_add_resources(chargerUIApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(chargerUIApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Network
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS chargerUIApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")
set(INSTALL_DESTDIR "/home/charger/QtApp")

install(TARGETS chargerUIApp
    RUNTIME DESTINATION ${INSTALL_DESTDIR}
    BUNDLE DESTINATION ${INSTALL_DESTDIR}
    LIBRARY DESTINATION ${INSTALL_DESTDIR}
)
