#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <iostream>
#include <QMessageBox>
#include <QSettings>

#include <iostream>
#include <fstream>

#include <sys/stat.h>
#include <unistd.h>
#include <string>
#include <ctime>
#include <iomanip>


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

    settings.beginGroup("Version");
    version = settings.value("version", "1.0.0").toString();
    settings.endGroup();

    settings.beginGroup("MainWindow");
    resize(settings.value("size", QSize (500, 500)).toSize());
    move  (settings.value("pos" , QPoint(200, 200)).toPoint());
    settings.endGroup();

    settings.beginGroup("Languages");
    ui->rB_CPP  ->setChecked(settings.value( "C++"  , false).toBool());
    ui->rB_C    ->setChecked(settings.value( "C"    , false).toBool());
    ui->rB_65x02->setChecked(settings.value( "65x02", false).toBool());
    settings.endGroup();

    settings.beginGroup("Binary");
    ui->rB_Executable->setChecked(settings.value( "Executable", false).toBool());
    ui->rB_Library   ->setChecked(settings.value( "Library"   , false).toBool());
    settings.endGroup();

    settings.beginGroup("Folders");
    ui->lE_BASEDIR->setText(settings.value("BASEDIR", "./" ).toString());
    ui-> lE_SRCDIR->setText(settings.value( "SRCDIR", "src").toString());
    ui-> lE_OBJDIR->setText(settings.value( "OBJDIR", "obj").toString());
    ui-> lE_DEPDIR->setText(settings.value( "DEPDIR", "obj").toString());
    ui-> lE_BINDIR->setText(settings.value( "BINDIR", "bin").toString());
    settings.endGroup();

    settings.beginGroup("CompilerFlags");
    ui->lE_DBG->setText(settings.value( "DBG", "-g3 -DDEBUG_ALL").toString());
    ui->lE_REL->setText(settings.value( "REL", "-O2"            ).toString());
    ui->lE_PRD->setText(settings.value( "PRD", "-O3"            ).toString());
    settings.endGroup();

    //
    // Trace
    //
    /*
    std::cout << "Language" << std::endl;
    std::cout << "[R] version = " << version.toStdString() << std::endl;
    std::cout << std::endl;

    std::cout << "Language" << std::endl;
    std::cout << "[R] C++   = " << ui->rB_CPP  ->isChecked() << std::endl;
    std::cout << "[R] C     = " << ui->rB_C    ->isChecked() << std::endl;
    std::cout << "[R] 65x02 = " << ui->rB_65x02->isChecked() << std::endl;
    std::cout << std::endl;

    std::cout << "Binary" << std::endl;
    std::cout << "[R] Executable = " << ui->rB_Executable->isChecked() << std::endl;
    std::cout << "[R] Library    = " << ui->rB_Library   ->isChecked() << std::endl;
    std::cout << std::endl;

    std::cout << "Folders" << std::endl;
    std::cout << "[R] BASEDIR = " << ui->lE_BASEDIR->text().toStdString() << std::endl;
    std::cout << "[R]  SRCDIR = " << ui-> lE_SRCDIR->text().toStdString() << std::endl;
    std::cout << "[R]  OBJDIR = " << ui-> lE_OBJDIR->text().toStdString() << std::endl;
    std::cout << "[R]  DEPDIR = " << ui-> lE_DEPDIR->text().toStdString() << std::endl;
    std::cout << "[R]  BINDIR = " << ui-> lE_BINDIR->text().toStdString() << std::endl;
    std::cout << std::endl;

    std::cout << "Compiler Flags" << std::endl;
    std::cout << "[R] Debug      Flags = " << ui->lE_DBG->text().toStdString() << std::endl;
    std::cout << "[R] Release    Flags = " << ui->lE_REL->text().toStdString() << std::endl;
    std::cout << "[R] Production Flags = " << ui->lE_PRD->text().toStdString() << std::endl;
    std::cout << std::endl;
    */
}

void MainWindow::writeSettings()
{
    //QSettings settings("./.mkmk/mkmk.ini", QSettings::IniFormat);
    //QSettings settings(QSettings::IniFormat, QSettings::UserScope, "Mkmk", "mkmk");

    settings.beginGroup("Version");
    settings.setValue("version", APP_VERSION);
    settings.endGroup();

    settings.beginGroup("MainWindow");
    settings.setValue("size", size());
    settings.setValue("pos" , pos() );
    settings.endGroup();

    settings.beginGroup("Languages");
    settings.setValue("C++"  , ui->rB_CPP  ->isChecked());
    settings.setValue("C"    , ui->rB_C    ->isChecked());
    settings.setValue("65x02", ui->rB_65x02->isChecked());
    settings.endGroup();

    settings.beginGroup("Binary");
    settings.setValue("Executable", ui->rB_Executable->isChecked());
    settings.setValue("Library"   , ui->rB_Library   ->isChecked());
    settings.endGroup();

    settings.beginGroup("Folders");
    settings.setValue("BASEDIR", ui->lE_BASEDIR->text());
    settings.setValue( "SRCDIR", ui-> lE_SRCDIR->text());
    settings.setValue( "OBJDIR", ui-> lE_OBJDIR->text());
    settings.setValue( "DEPDIR", ui-> lE_DEPDIR->text());
    settings.setValue( "BINDIR", ui-> lE_BINDIR->text());
    settings.endGroup();

    settings.beginGroup("CompilerFlags");
    settings.setValue("DBG", ui->lE_DBG->text());
    settings.setValue("REL", ui->lE_REL->text());
    settings.setValue("PRD", ui->lE_PRD->text());
    settings.endGroup();

    //
    //  Trace
    //
    /*
    std::cout << "Language" << std::endl;
    std::cout << "[W] version  = " << version.toStdString() << std::endl;
    std::cout << std::endl;

    std::cout << "Language" << std::endl;
    std::cout << "[W] C++   = " << ui->rB_CPP  ->isChecked() << std::endl;
    std::cout << "[W] C     = " << ui->rB_C    ->isChecked() << std::endl;
    std::cout << "[W] 65x02 = " << ui->rB_65x02->isChecked() << std::endl;
    std::cout << std::endl;

    std::cout << "Binary" << std::endl;
    std::cout << "[W] Executable = " << ui->rB_Executable->isChecked() << std::endl;
    std::cout << "[W] Library    = " << ui->rB_Library   ->isChecked() << std::endl;
    std::cout << std::endl;

    std::cout << "Folders" << std::endl;
    std::cout << "[W] BASEDIR = " << ui->lE_BASEDIR->text().toStdString() << std::endl;
    std::cout << "[W]  SRCDIR = " << ui-> lE_SRCDIR->text().toStdString() << std::endl;
    std::cout << "[W]  OBJDIR = " << ui-> lE_OBJDIR->text().toStdString() << std::endl;
    std::cout << "[W]  DEPDIR = " << ui-> lE_DEPDIR->text().toStdString() << std::endl;
    std::cout << "[W]  BINDIR = " << ui-> lE_BINDIR->text().toStdString() << std::endl;
    std::cout << std::endl;

    std::cout << "Compiler Flags" << std::endl;
    std::cout << "[W]  Debug      Flags = " << ui-> lE_DBG->text().toStdString() << std::endl;
    std::cout << "[W]  Release    Flags = " << ui-> lE_REL->text().toStdString() << std::endl;
    std::cout << "[W]  Production Flags = " << ui-> lE_PRD->text().toStdString() << std::endl;
    std::cout << std::endl;
    */
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
    ui->gB_SDL2_Librairies->setDisabled(false);
}

void MainWindow::on_rB_C_clicked()
{
    ui->gB_SDL2_Librairies->setDisabled(false);
}

void MainWindow::on_rB_65x02_clicked()
{
    ui->gB_SDL2_Librairies->setDisabled(true);
}
