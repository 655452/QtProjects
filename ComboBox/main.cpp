#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "treemodel.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/ComboBox/main.qml"));

    TreeModel treeModel;
    // engine.rootContext()->setContextProperty("TreeModel", &treeModel);

    // ✅ Register TreeModel as a QML type
    qmlRegisterType<TreeModel>("MyApp.Models", 1, 0, "TreeModel");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
