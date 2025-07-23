#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "formdatahandler.h"
#include "formdataprovider.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Forms/main.qml"));
    FormDataProvider formDataProvider;
    engine.rootContext()->setContextProperty("formDataProvider", &formDataProvider);

    qmlRegisterType<FormDataHandler>("App.Models", 1, 0, "FormDataHandler");
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
