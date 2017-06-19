#-------------------------------------------------
#
# Project created by QtCreator 2017-04-12T16:28:15
#
#-------------------------------------------------

CONFIG(release, debug|release) {
    #This is a release build
    DEFINES += QT_NO_DEBUG_OUTPUT
}


#
# Application Version
#
VERSION_MAJOR   =   0
# 0 - The application is not yet functionnal

VERSION_MINOR   =   1
# 0 - Raw mockup
# 1 - options groups
# 2 - settings saved

# VERSION_BUILD
# dynamically computed
contains(QMAKE_HOST.os,Windows) {
VERSION_BUILD = $$system(.\autoincrementbuild.bat)
TIME_BUILD    = $$system(echo %DATE%) $$system(echo %TIME%)
}

contains(QMAKE_HOST.os,Linux) {
VERSION_BUILD = $$system(./autoincrementbuild.sh)
TIME_BUILD    = $$system(date +%Y-%m-%d_%Hh:%Mm:%Ss_%Z:%:z)
}

VERSION =   $${VERSION_MAJOR}.$${VERSION_MINOR}.$${VERSION_BUILD}

DEFINES +=  "VERSION_MAJOR=$$VERSION_MAJOR" \
            "VERSION_MINOR=$$VERSION_MINOR" \
            "VERSION_BUILD=$$VERSION_BUILD"

DEFINES +=  "TIME_BUILD=\\\"$${TIME_BUILD}\\\""

DEFINES +=  "APP_VERSION=\\\"$${VERSION}\\\""
DEFINES +=  "APP_NAME=\\\"mkmk\\\""

message($$DEFINES)

QT      +=  core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

#CONFIG  +=  static

TARGET  =   mkmk
TEMPLATE=   app


SOURCES +=  main.cpp \
            mainwindow.cpp

HEADERS +=  mainwindow.h

FORMS   +=  mainwindow.ui
