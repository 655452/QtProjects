#include "smartheader.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>
#include "DataManager.h"
SmartHeader::SmartHeader(QObject *parent) : QObject(parent) {}

SmartHeader::~SmartHeader() {}

QQuickItem* SmartHeader::createComponent(QQmlEngine* engine)
{
    // Set the data model as a context property
    // engine->rootContext()->setContextProperty("sharedDataModel", dataModel);

    // Load the QML file for the header
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/HeaderWindow.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for header:" << component.errorString();
        return nullptr;
    }

    QQuickItem* headerItem = qobject_cast<QQuickItem*>(component.create());

    // Set data in DataManager when a button is clicked in QML
    QObject::connect(headerItem, SIGNAL(updateValue(QString)), this, SLOT(updateSharedValue(QString)));

    return headerItem;
}

void SmartHeader::updateSharedValue(QString value) {
    qDebug() << "Header: Setting shared value to" << value;
    DataManager::instance()->setSharedValue(value);  // Update DataManager
}
