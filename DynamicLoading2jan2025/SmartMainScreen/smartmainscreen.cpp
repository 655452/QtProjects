#include "smartmainscreen.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>
#include "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SharedDataModel/isharedmodelinterface.h"

SmartMainScreen::SmartMainScreen(QObject *parent) : QObject(parent) {}

SmartMainScreen::~SmartMainScreen() {}

QQuickItem* SmartMainScreen::createComponent(QQmlEngine* engine)
{

        // accessing shared data model object
    QString SharedDataLibraryPath = "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SharedDataModel/lib/libSharedDataModel.so";
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
