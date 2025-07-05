#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "MulticastSender.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MulticastSender multicastSender;
    engine.rootContext()->setContextProperty("multicastSender", &multicastSender);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
    return app.exec();
}
