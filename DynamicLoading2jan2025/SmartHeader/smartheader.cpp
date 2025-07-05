#include "smartheader.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>

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

    return headerItem;
}
