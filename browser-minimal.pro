TARGET = browser-minimal.app
QT += quick webengine
CONFIG += c++11 qtquickcompiler

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    browserdata.h \
    device_info_provider.h \
    pbtranslator.h \
    resource_image_provider.h

SOURCES += \
        browserdata.cpp \
        device_info_provider.cpp \
        main.cpp \
        pbtranslator.cpp \
        resource_image_provider.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

contains (PLATFORM, arm) {
    SYSROOT=$$(PB_SYSROOT)
    INCLUDEPATH += $$SYSROOT/usr/include $$SYSROOT/usr/local/include $$SYSROOT/usr/include/freetype2
    message("$$TARGET Build for ARM")
    message("$$TARGET SYSROOT dir is $$SYSROOT")
} else {
    CONFIG += link_pkgconfig
    PKGCONFIG += freetype2
    DEFINES += "PB_LOG_LEVEL=1"
    DEFINES += "EMULATOR=1"
    DEFINES += "EMULATOR_SDK_PATH=\\\"$$(PB_SDK_DIR)/usr/local\\\""
    LIBS += -L$$(PB_SDK_DIR)/usr/lib -L$$(PB_SDK_DIR)/usr/local/lib
    INCLUDEPATH += $$(PB_SDK_DIR)/usr/local/include $$(PB_SDK_DIR)/usr/include $$PWD
    QMAKE_RPATHDIR += /$$(PB_SDK_DIR)/usr/local/lib
    message("$$TARGET Build for EMULATOR")
    message("$$TARGET PB_SDK_DIR=$$(PB_SDK_DIR)")
}

LIBS += -ldl -lz -lhwconfig -linkview -lcommon_utilities

message("$$TARGET DEFINES = $$DEFINES")
message("$$TARGET INCLUDEPATH = $$INCLUDEPATH")
message("$$TARGET LIBS = $$LIBS")
