#ifndef QTCMAKEWINDOW_H
#define QTCMAKEWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class QtCmakeWindow; }
QT_END_NAMESPACE

class QtCmakeWindow : public QMainWindow
{
    Q_OBJECT

public:
    QtCmakeWindow(QWidget *parent = nullptr);
    ~QtCmakeWindow();

private:
    Ui::QtCmakeWindow *ui;
};
#endif // QTCMAKEWINDOW_H
