#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <iostream>
#include <QMessageBox>
#include <QSettings>

#include <iostream>
#include <fstream>

#include <sys/stat.h>

#ifdef  Q_OS_LINUX
#include <unistd.h>
#endif//Q_OS_LINUX

#ifdef  Q_OS_WIN
#include <io.h>
#endif//Q_OS_WIN

#include <string>
#include <ctime>
#include <iomanip>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    settings("./.mkmk.ini", QSettings::IniFormat)
{
    ui->setupUi(this);

    // Update Gui from latest saved settings
    readSettings();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::readSettings()
{
    //QSettings settings("./.mkmk/mkmk.ini", QSettings::IniFormat);
    //QSettings settings(QSettings::IniFormat, QSettings::UserScope, "Mkmk", "mkmk");

    settings.beginGroup("Version");                                                 qDebug() << QString("version");
    version = settings.value("version", "1.0.0").toString();                        qDebug() << QString(" [R] version = ") + QString(version);
    settings.endGroup();

    settings.beginGroup("MainWindow");
    resize(settings.value("size", QSize (500, 500)).toSize());
    move  (settings.value("pos" , QPoint(200, 200)).toPoint());
    settings.endGroup();

    settings.beginGroup("Languages");                                               qDebug() << QString("Language");
    ui->rB_CPP    ->setChecked(settings.value( "C++"    , false).toBool());         qDebug() << QString(" [R] C++     = ") << ui->rB_CPP    ->isChecked();
    ui->rB_C      ->setChecked(settings.value( "C"      , false).toBool());         qDebug() << QString(" [R] C       = ") << ui->rB_C      ->isChecked();
    ui->rB_Go     ->setChecked(settings.value( "Go"     , false).toBool());         qDebug() << QString(" [R] Go      = ") << ui->rB_Go     ->isChecked();
    ui->rB_65x02  ->setChecked(settings.value( "65x02"  , false).toBool());         qDebug() << QString(" [R] 65x02   = ") << ui->rB_65x02  ->isChecked();
    ui->rB_Folders->setChecked(settings.value( "Folders", false).toBool());         qDebug() << QString(" [R] Folders = ") << ui->rB_Folders->isChecked();
    settings.endGroup();

    settings.beginGroup("Binary");                                                  qDebug() << QString("Binary");
    ui->rB_Executable->setChecked(settings.value( "Executable", false).toBool());   qDebug() << QString(" [R] Executable = ") << ui->rB_Executable->isChecked();
    ui->rB_Library   ->setChecked(settings.value( "Library"   , false).toBool());   qDebug() << QString(" [R] Library    = ") << ui->rB_Library   ->isChecked();
    settings.endGroup();

    settings.beginGroup("Folders");                                                 qDebug() << QString("Folders");
    ui->lE_BASEDIR->setText(settings.value("BASEDIR", "./" ).toString());           qDebug() << QString(" [R] BASEDIR = ") + QString( ui->lE_BASEDIR->text() );
    ui-> lE_SRCDIR->setText(settings.value( "SRCDIR", "src").toString());           qDebug() << QString(" [R]  SRCDIR = ") + QString( ui-> lE_SRCDIR->text() );
    ui-> lE_OBJDIR->setText(settings.value( "OBJDIR", "obj").toString());           qDebug() << QString(" [R]  OBJDIR = ") + QString( ui-> lE_OBJDIR->text() );
    ui-> lE_DEPDIR->setText(settings.value( "DEPDIR", "obj").toString());           qDebug() << QString(" [R]  DEPDIR = ") + QString( ui-> lE_DEPDIR->text() );
    ui-> lE_BINDIR->setText(settings.value( "BINDIR", "bin").toString());           qDebug() << QString(" [R]  BINDIR = ") + QString( ui-> lE_BINDIR->text() );
    settings.endGroup();

    settings.beginGroup("CompilerFlags");                                           qDebug() << QString("CompilerFlags");
    ui->lE_DBG->setText(settings.value( "DBG", "-g3 -DDEBUG_ALL").toString());      qDebug() << QString(" [R] Debug      Flags = ") + QString( ui->lE_DBG->text() );
    ui->lE_REL->setText(settings.value( "REL", "-O2"            ).toString());      qDebug() << QString(" [R] Release    Flags = ") + QString( ui->lE_REL->text() );
    ui->lE_PRD->setText(settings.value( "PRD", "-O3"            ).toString());      qDebug() << QString(" [R] Production Flags = ") + QString( ui->lE_PRD->text() );
    settings.endGroup();

    settings.beginGroup("WarningFlags");                                            qDebug() << QString("WarningFlags");
    ui->lE_WRN->setText(settings.value( "WRN", "-Wall -Wextra -Werror").toString());qDebug() << QString(" [R] WRN  = ") + QString( ui->lE_WRN->text() );
    settings.endGroup();

    settings.beginGroup("ExtraFlags");                                              qDebug() << QString("ExtraFlags");
    ui->lE_XTRA->setText(settings.value( "XTRA", "").toString());                   qDebug() << QString(" [R] XTRA = ") + QString( ui->lE_XTRA->text() );
    settings.endGroup();

    settings.beginGroup("SDL2-Libraries");                                          qDebug() << QString("SDL2-Libraries");
    ui->cB_SDL2      ->setChecked(settings.value( "SDL2"      , false).toBool());   qDebug() << QString(" [R] SDL2       = ") << ui->cB_SDL2      ->isChecked();
    ui->cB_SDL2_image->setChecked(settings.value( "SDL2_image", false).toBool());   qDebug() << QString(" [R] SDL2_image = ") << ui->cB_SDL2_image->isChecked();
    ui->cB_SDL2_mixer->setChecked(settings.value( "SDL2_mixer", false).toBool());   qDebug() << QString(" [R] SDL2_mixer = ") << ui->cB_SDL2_mixer->isChecked();
    ui->cB_SDL2_net  ->setChecked(settings.value( "SDL2_net"  , false).toBool());   qDebug() << QString(" [R] SDL2_net   = ") << ui->cB_SDL2_net  ->isChecked();
    ui->cB_SDL2_ttf  ->setChecked(settings.value( "SDL2_ttf"  , false).toBool());   qDebug() << QString(" [R] SDL2_ttf   = ") << ui->cB_SDL2_ttf  ->isChecked();
    settings.endGroup();
}

void MainWindow::writeSettings()
{
    //QSettings settings("./.mkmk/mkmk.ini", QSettings::IniFormat);
    //QSettings settings(QSettings::IniFormat, QSettings::UserScope, "Mkmk", "mkmk");

    settings.beginGroup("Version");                                                 qDebug() << QString("version");
    settings.setValue("version", APP_VERSION);                                      qDebug() << QString(" [W] version = ") + QString(version);
    settings.endGroup();

    settings.beginGroup("MainWindow");                                              qDebug() << QString("MainWindow");
    settings.setValue("size", size());                                              qDebug() << QString(" [W] size = ") << size();
    settings.setValue("pos" , pos() );                                              qDebug() << QString(" [W] pos  = ") << pos();
    settings.endGroup();

    settings.beginGroup("Languages");                                               qDebug() << QString("Languages");
    settings.setValue("C++"    , ui->rB_CPP    ->isChecked());                      qDebug() << QString(" [W] C++     = ") << ui->rB_CPP    ->isChecked();
    settings.setValue("C"      , ui->rB_C      ->isChecked());                      qDebug() << QString(" [W] C       = ") << ui->rB_C      ->isChecked();
    settings.setValue("Go"     , ui->rB_Go     ->isChecked());                      qDebug() << QString(" [W] Go      = ") << ui->rB_Go     ->isChecked();
    settings.setValue("65x02"  , ui->rB_65x02  ->isChecked());                      qDebug() << QString(" [W] 65x02   = ") << ui->rB_65x02  ->isChecked();
    settings.setValue("Folders", ui->rB_Folders->isChecked());                      qDebug() << QString(" [W] Folders = ") << ui->rB_Folders->isChecked();
    settings.endGroup();

    settings.beginGroup("Binary");                                                  qDebug() << QString("Binary");
    settings.setValue("Executable", ui->rB_Executable->isChecked());                qDebug() << QString(" [W] Executable = ") << ui->rB_Executable->isChecked();
    settings.setValue("Library"   , ui->rB_Library   ->isChecked());                qDebug() << QString(" [W] Library    = ") << ui->rB_Library   ->isChecked();
    settings.endGroup();

    settings.beginGroup("Folders");                                                 qDebug() << QString("Folders");
    settings.setValue("BASEDIR", ui->lE_BASEDIR->text());                           qDebug() << QString(" [W] BASEDIR = ") << ui->lE_BASEDIR->text();
    settings.setValue( "SRCDIR", ui-> lE_SRCDIR->text());                           qDebug() << QString(" [W]  SRCDIR = ") << ui->lE_SRCDIR ->text();
    settings.setValue( "OBJDIR", ui-> lE_OBJDIR->text());                           qDebug() << QString(" [W]  OBJDIR = ") << ui->lE_OBJDIR ->text();
    settings.setValue( "DEPDIR", ui-> lE_DEPDIR->text());                           qDebug() << QString(" [W]  DEPDIR = ") << ui->lE_DEPDIR ->text();
    settings.setValue( "BINDIR", ui-> lE_BINDIR->text());                           qDebug() << QString(" [W]  BINDIR = ") << ui->lE_BINDIR ->text();
    settings.endGroup();

    settings.beginGroup("CompilerFlags");                                           qDebug() << QString("CompilerFlags");
    settings.setValue("DBG", ui->lE_DBG->text());                                   qDebug() << QString(" [W] DBG = ") << ui->lE_DBG->text();
    settings.setValue("REL", ui->lE_REL->text());                                   qDebug() << QString(" [W] REL = ") << ui->lE_REL->text();
    settings.setValue("PRD", ui->lE_PRD->text());                                   qDebug() << QString(" [W] PRD = ") << ui->lE_PRD->text();
    settings.endGroup();

    settings.beginGroup("WarningFlags");                                            qDebug() << QString("WarningFlags");
    settings.setValue("WRN", ui->lE_WRN->text());                                   qDebug() << QString(" [W] WRN  = ") << ui->lE_WRN->text();
    settings.endGroup();

    settings.beginGroup("ExtraFlags");                                              qDebug() << QString("ExtraFlags");
    settings.setValue("XTRA", ui->lE_XTRA->text());                                 qDebug() << QString(" [W] XTRA = ") << ui->lE_XTRA->text();
    settings.endGroup();

    settings.beginGroup("SDL2-Libraries");                                          qDebug() << QString("SDL2-Libraries");
    settings.setValue("SDL2"      , ui->cB_SDL2      ->isChecked());                qDebug() << QString(" [W] SDL2       = ") << ui->cB_SDL2      ->isChecked();
    settings.setValue("SDL2_image", ui->cB_SDL2_image->isChecked());                qDebug() << QString(" [W] SDL2_image = ") << ui->cB_SDL2_image->isChecked();
    settings.setValue("SDL2_mixer", ui->cB_SDL2_mixer->isChecked());                qDebug() << QString(" [W] SDL2_mixer = ") << ui->cB_SDL2_mixer->isChecked();
    settings.setValue("SDL2_net"  , ui->cB_SDL2_net  ->isChecked());                qDebug() << QString(" [W] SDL2_net   = ") << ui->cB_SDL2_net  ->isChecked();
    settings.setValue("SDL2_ttf"  , ui->cB_SDL2_ttf  ->isChecked());                qDebug() << QString(" [W] SDL2_ttf   = ") << ui->cB_SDL2_ttf  ->isChecked();
    settings.endGroup();
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    if (askUser("Do you really want to quit?")) {
        writeSettings();
        event->accept();
    } else {
        event->ignore();
    }
}

bool MainWindow::askUser( const QString & message_popup )
{
    QMessageBox messageBox;

    messageBox.setWindowTitle( QString(APP_NAME) );
    messageBox.setText(message_popup);
    messageBox.setStandardButtons(QMessageBox::Yes | QMessageBox::No);
    messageBox.setDefaultButton  (QMessageBox::No);

    QSize mSize = messageBox.sizeHint();
    QRect screenRect = this->window()->rect();

    int x1, y1, x2, y2;
    QApplication::activeWindow()->geometry().getCoords(&x1, &y1, &x2, &y2);
    //std::cout << "x1 = " << x1 << ", y1 = " << y1 << ", x2 = " << x2 << ", y2 = " << y2 << std::endl;

    messageBox.move( QPoint( screenRect.width ()/2 - mSize.width ()/2 + x1 ,
                             screenRect.height()/2 - mSize.height()/2 + y1 ) );

    return (messageBox.exec() == QMessageBox::Yes);
}

void MainWindow::on_pB_Create_clicked()
{
    //std::cout << "Create button clicked!" << std::endl;

    if (fexists("Makefile")) {
        std::cout << "File Makefile already exists!" << std::endl;
        if (!askUser("Makefile already exist, do you want to continue?"))
            return;
    }

    // Compute current time
    time_t currentTime;
    struct tm * localTime;

    time( &currentTime );                   // Get the current time
    localTime = localtime( &currentTime );  // Convert the current time to the local time

    int Day    = localTime->tm_mday;
    int Month  = localTime->tm_mon + 1;
    int Year   = localTime->tm_year + 1900;
    int Hour   = localTime->tm_hour;
    int Min    = localTime->tm_min;
    int Sec    = localTime->tm_sec;

    // Generate Makefile
    std::ofstream outfile ("Makefile");

    outfile << "#\n";
    outfile << "# Makefile generated by MakeMaker v" << APP_VERSION << '\n';
    outfile << "# ";
    outfile.fill('0');
    outfile << std::setw(2) << Day  << '/' << std::setw(2) << Month << '/' << std::setw(4) << Year << ' '
            << std::setw(2) << Hour << 'h' << std::setw(2) << Min   << 'm' << std::setw(2) << Sec  << 's'
            << '\n';
    outfile << "#\n";

    outfile.close();
}

inline bool MainWindow::fexists (const std::string& name) {
  struct stat buffer;
  return (stat (name.c_str(), &buffer) == 0);
}

void MainWindow::on_actionQuit_triggered()
{
    writeSettings();

    QApplication::exit(EXIT_SUCCESS);
}

void MainWindow::on_actionAbout_triggered()
{
    // Popup window
    QMessageBox aboutBox;
    int x1, y1, x2, y2;
    QApplication::activeWindow()->geometry().getCoords(&x1, &y1, &x2, &y2);

    aboutBox.setWindowTitle( "About " + QString(APP_NAME) );
    aboutBox.setText( QString(APP_NAME) + " " + QString(APP_VERSION) );

    QSize mSize = aboutBox.sizeHint();
    QRect screenRect = this->window()->rect();

    aboutBox.move( QPoint( screenRect.width ()/2 - mSize.width ()/2 + x1,
                           screenRect.height()/2 - mSize.height()/2 + y1) );

    aboutBox.exec();
}

void MainWindow::on_rB_CPP_clicked()
{
    // Reactivate bin & env
    ui->gB_Binary     ->setDisabled(false);
    ui->gB_Environment->setDisabled(false);

    // (re)Activate SDL2 extra libs
    ui->gB_SDL2_Librairies->setDisabled(false);
}

void MainWindow::on_rB_C_clicked()
{
    // Reactivate bin & env
    ui->gB_Binary     ->setDisabled(false);
    ui->gB_Environment->setDisabled(false);

    // (re)Activate SDL2 extra libs
    ui->gB_SDL2_Librairies->setDisabled(false);
}

void MainWindow::on_rB_Go_clicked()
{
    // Disable the secondary settings for languages
    ui->gB_Binary     ->setDisabled(true);
    ui->gB_Environment->setDisabled(true);

    // (Deactivate SDL2 extra libs
    ui->gB_SDL2_Librairies->setDisabled(true);
}

void MainWindow::on_rB_65x02_clicked()
{
    // Reactivate bin & env
    ui->gB_Binary     ->setDisabled(true);
    ui->gB_Environment->setDisabled(true);

    // (Deactivate SDL2 extra libs
    ui->gB_SDL2_Librairies->setDisabled(true);
}

void MainWindow::on_rB_Folders_clicked()
{
    // Disable the secondary settings for languages
    ui->gB_Binary     ->setDisabled(true);
    ui->gB_Environment->setDisabled(true);

    // (Deactivate SDL2 extra libs
    ui->gB_SDL2_Librairies->setDisabled(true);
}
