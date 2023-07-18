#include "qtcmakewindow.h"
#include "ui_qtcmakewindow.h"

QtCmakeWindow::QtCmakeWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::QtCmakeWindow)
{
    ui->setupUi(this);
}

QtCmakeWindow::~QtCmakeWindow()
{
    delete ui;
}

