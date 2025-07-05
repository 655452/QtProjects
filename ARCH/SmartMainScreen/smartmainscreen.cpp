#include "smartmainscreen.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>
#include "/home/asit/Documents/AsitEmpire/ARCH/SharedDataModel/isharedmodelinterface.h"
#include "/home/asit/Documents/AsitEmpire/ARCH/MulticastSender/imulticastsender.h"
#include "/home/asit/Documents/AsitEmpire/ARCH/MulticastReceiver/iMulticastReceiver.h"

SmartMainScreen::SmartMainScreen(QObject *parent) : QObject(parent) {}

SmartMainScreen::~SmartMainScreen() {}

QQuickItem* SmartMainScreen::createComponent(QQmlEngine* engine)
{

    QString MulticastReceiverlibPath = "/home/asit/Documents/AsitEmpire/ARCH/MulticastReceiver/build/Desktop_Qt_6_8_1-Release/libMulticastReceiver.so";
    QPluginLoader MulticastReceiverPluginLoader(MulticastReceiverlibPath);
    QObject *MulticastReceiverPlugin = MulticastReceiverPluginLoader.instance();

    if (!MulticastReceiverPlugin) {
        qDebug() << "Failed to load the MulticastReceiverPlugin:" << MulticastReceiverPluginLoader.errorString();
        return nullptr;
    }
    IMulticastReceiver *multicastReceiver = qobject_cast<IMulticastReceiver*>(MulticastReceiverPlugin);
    if (!multicastReceiver) {
        qDebug() << "The plugin does not implement the expected interface.";
        return nullptr;
    }

    engine->rootContext()->setContextProperty("multicastReceiver", multicastReceiver);

    // --------------------------------------------------------------------
    QString MulticastSenderlibPath = "/home/asit/Documents/AsitEmpire/ARCH/MulticastSender/build/Desktop_Qt_6_8_1-Release/libMulticastSender.so";
    QPluginLoader MulticastSenderPluginLoader(MulticastSenderlibPath);
    QObject *MulticastSenderPlugin = MulticastSenderPluginLoader.instance();

    if (!MulticastSenderPlugin) {
        qDebug() << "Failed to load the MulticastSenderPlugin:" << MulticastSenderPluginLoader.errorString();
        return nullptr;
    }
    IMulticastSender *multicastSender = qobject_cast<IMulticastSender *>(MulticastSenderPlugin);
    if (!multicastSender) {
        qDebug() << "The plugin does not implement the expected interface.";
        return nullptr;
    }
    multicastSender->startBroadcasting();
    // engine->rootContext()->setContextProperty("multicastSender", multicastSender);

    // ------------------------------------------------------------------
        // accessing shared data model object
    QString SharedDataLibraryPath = "/home/asit/Documents/AsitEmpire/ARCH/SharedDataModel/lib/libSharedDataModel.so";
    QPluginLoader sharedDataModelLoader(SharedDataLibraryPath);
    QObject* sharedDataModelPlugin = sharedDataModelLoader.instance();

    ISharedModelInterface* sharedModelInterface = qobject_cast<ISharedModelInterface*>(sharedDataModelPlugin);
    if (!sharedModelInterface) {
        qDebug() << "The plugin does not implement ISharedModelInterface.";
        return nullptr;
    }
    // creating the object and then connecting to the data changed
    sharedModelInterface->addItem("item added in the main screen","in mainScreen");
    QObject* sharedDataModel2 = sharedModelInterface->getSharedDataModel();
    connectSharedDataModel(sharedDataModel2);

    engine->rootContext()->setContextProperty("sharedDataModel2",sharedDataModel2);

    // Load the QML file for the MainScreen
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/MainScreenWindow.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for MainScreen:" << component.errorString();
        return nullptr;
    }

    QQuickItem* mainScreenItem = qobject_cast<QQuickItem*>(component.create());

    return mainScreenItem;
}

void SmartMainScreen::connectSharedDataModel(QObject *sharedDataModel)
{
    // Connect the signal from SharedDataModel to a slot in MainScreen
    connect(sharedDataModel, SIGNAL(dataChangedExternally(QString)),
            this, SLOT(handleDataChanged(QString)));
}

void SmartMainScreen::handleDataChanged(const QString &newData)
{
    // qDebug() << "MainScreen received updated data from SharedDataModel:" << newData;
}
