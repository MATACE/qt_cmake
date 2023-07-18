#include "qtcmakewindow.h"

#include <QApplication>

#include <cmath>
#include <iostream>
#include <string>


#include "MathFunctions.h"
/**
 * @brief Main Fuction
*/

int main(int argc, char *argv[])
{
    double inputValue = std::stod("32");
    mathfunctions::sqrt(inputValue);

    QApplication a(argc, argv);
    QtCmakeWindow w;
    w.show();
    return a.exec();
}
