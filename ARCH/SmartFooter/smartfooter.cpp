#include "smartfooter.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>

SmartFooter::SmartFooter(QObject *parent):QObject(parent) {}

SmartFooter::~SmartFooter()
{}

QQuickItem* SmartFooter::createComponent(QQmlEngine* engine) {
    QQmlComponent component(engine,QUrl(QStringLiteral("qrc:/FooterWindow.qml"))); // Use the engine provided as an argument
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error creating QML Component:  Smart Footer" << component.errorString();
        return nullptr;
    }
    QQuickItem* item = qobject_cast<QQuickItem*>(component.create());


    // Listen for changes from DataManager
    // QObject::connect(DataManager::instance(), &DataManager::valueChanged,
    //                  this, &SmartFooter::onValueChanged);
    return item;
}

// void SmartFooter::onValueChanged(QString newValue) {
//     qDebug() << "Footer: Received updated value" << newValue;
// }



