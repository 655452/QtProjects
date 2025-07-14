#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "NotificationModel.h"
#include <QQmlContext>
#include "NotificationManger.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // Create three models
    // auto noticeModel = new NotificationModel();
    // auto warningModel = new NotificationModel();
    // auto alertModel = new NotificationModel();

    // noticeModel->setType("notice");
    // warningModel->setType("warning");
    // alertModel->setType("alert");

    // // Initialize dummy data
    // noticeModel->addNotification("System notice", "10:00 AM");
    // noticeModel->addNotification("New notice", "10:05 AM");

    // warningModel->addNotification("Battery warning", "10:15 AM");
    // warningModel->addNotification("Download warning", "10:20 AM");

    // alertModel->addNotification("Weather Alert", "10:35 AM");
    // alertModel->addNotification("Missed Call", "11:10 AM");

    // // Expose to QML
    // engine.rootContext()->setContextProperty("noticeModel", noticeModel);
    // engine.rootContext()->setContextProperty("warningModel", warningModel);
    // engine.rootContext()->setContextProperty("alertModel", alertModel);


    NotificationManager manager;
    engine.rootContext()->setContextProperty("notificationMod", &manager);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("untitled", "Main");

    return app.exec();
}
