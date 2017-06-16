#-------------------------------------------------
#
# Project created by QtCreator 2017-04-12T16:28:15
#
#-------------------------------------------------

# Application Version
VERSION_MAJOR   =   1
VERSION_MINOR   =   0
VERSION_BUILD   =   1

VERSION =   $${VERSION_MAJOR}.$${VERSION_MINOR}.$${VERSION_BUILD}

DEFINES +=  "VERSION_MAJOR=$$VERSION_MAJOR" \
            "VERSION_MINOR=$$VERSION_MINOR" \
            "VERSION_BUILD=$$VERSION_BUILD"

DEFINES +=  "APP_VERSION=\\\"$$VERSION\\\""

QT      +=  core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET  =   mkmk
TEMPLATE=   app


SOURCES +=  main.cpp \
            mainwindow.cpp

HEADERS +=  mainwindow.h

FORMS   +=  mainwindow.ui
