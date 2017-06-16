#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QCloseEvent>
#include <QString>
#include <QMap>
#include <QSettings>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    void readSettings();
    void writeSettings();
    void closeEvent(QCloseEvent *event);
    bool userReallyWantsToQuit();

private slots:
    void on_pB_Create_clicked();

    void on_actionQuit_triggered();

    void on_actionAbout_triggered();

private:
    Ui::MainWindow *ui;

    QSettings   settings;
    QString     version;

};

#endif // MAINWINDOW_H
