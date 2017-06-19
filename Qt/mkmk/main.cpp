#include "mainwindow.h"
#include <QApplication>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication a (argc, argv);

    QCoreApplication::setOrganizationName  ("mkmk"    );
    QCoreApplication::setOrganizationDomain("mkmk.com");
    QCoreApplication::setApplicationName   ("Mkmk"    );

    qDebug() << QString("version = ") + QString(APP_VERSION);

    MainWindow w;
    w.show();

    return a.exec();
}
