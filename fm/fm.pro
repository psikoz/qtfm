QT+= core gui dbus
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
include(../qtfm.pri)

CONFIG(basic) {
    CONFIG += no_udisks no_tray no_appdock no_dbus
}

TARGET = $${QTFM_TARGET}
TARGET_NAME = $${QTFM_TARGET_NAME}
VERSION = $${QTFM_MAJOR}.$${QTFM_MINOR}.$${QTFM_PATCH}
TEMPLATE = app

DEPENDPATH += . src
INCLUDEPATH += . src ../libfm
LIBS += -L../libfm -lQtFM

HEADERS += src/mainwindow.h \
    src/mymodel.h \
    src/bookmarkmodel.h \
    src/icondlg.h \
    src/propertiesdlg.h \
    src/tabbar.h \
    src/mymodelitem.h \
    src/settingsdialog.h \
    src/customactionsmanager.h \
    src/processdialog.h \
    src/applicationdialog.h
!CONFIG(no_appdock): HEADERS += applicationdock.h
SOURCES += src/main.cpp \
    src/mainwindow.cpp \
    src/mymodel.cpp \
    src/bookmarks.cpp \
    src/icondlg.cpp \
    src/propertiesdlg.cpp \
    src/tabbar.cpp \
    src/mymodelitem.cpp \
    src/settingsdialog.cpp \
    src/customactionsmanager.cpp \
    src/processdialog.cpp \
    src/applicationdialog.cpp \
    src/actiondefs.cpp \
    src/actiontriggers.cpp
!CONFIG(no_appdock): SOURCES += applicationdock.cpp

OTHER_FILES += $${TARGET}.desktop
RESOURCES += $${TARGET}.qrc

DEFINES += APP=\"\\\"$${TARGET}\\\"\"
DEFINES += APP_NAME=\"\\\"$${TARGET_NAME}\\\"\"
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

isEmpty(PREFIX) {
    PREFIX = /usr/local
}
isEmpty(DOCDIR) {
    DOCDIR = $$PREFIX/share/doc
}

target.path = $${PREFIX}/bin
desktop.files += $${TARGET}.desktop
desktop.path += $${PREFIX}/share/applications
docs.path += $${DOCDIR}/$${TARGET}-$${VERSION}
docs.files += ../LICENSE ../README.md ../AUTHORS
man.files += qtfm.8
man.path += $${MANDIR}/man8
INSTALLS += target desktop docs man

!CONFIG(no_udisks) {
    exists(../libdisks/libdisks.pro) {
        INCLUDEPATH += ../libdisks
        LIBS += -L../libdisks -lDisks
    } else {
        CONFIG += link_pkgconfig
        PKGCONFIG += Disks
    }
}
CONFIG(no_udisks): DEFINES += NO_UDISKS
CONFIG(no_appdock): DEFINES += NO_APPDOCK
CONFIG(no_dbus) {
    DEFINES += NO_DBUS
    QT -= dbus
}

lessThan(QT_MAJOR_VERSION, 5): LIBS += -lmagic
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT
