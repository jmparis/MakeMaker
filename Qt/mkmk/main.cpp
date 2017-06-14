#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a (argc, argv);

    QCoreApplication::setOrganizationName  ("mkmk"    );
    QCoreApplication::setOrganizationDomain("mkmk.com");
    QCoreApplication::setApplicationName   ("Mkmk"    );

    MainWindow w;
    w.show();

    return a.exec();
}
