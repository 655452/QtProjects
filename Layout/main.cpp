#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ZoneLoader.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<ZoneLoader>("MyApp", 1, 0, "ZoneLoader");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Layout", "Main");

    return app.exec();
}
