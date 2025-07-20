#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CentralDataProvider.h"
#include "treemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    CentralDataProvider centralProvider;
    TreeModel model;
    model.setAllItems(centralProvider.centralData().value("Items").toList());

    engine.rootContext()->setContextProperty("centralData", centralProvider.centralData());

    // ✅ Register TreeModel as a QML type
    qmlRegisterType<TreeModel>("MyApp.Models", 1, 0, "TreeModel");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TrackModel", "Main");

    return app.exec();
}
