#include "popupclass.h"
#include <QQmlComponent>
#include <QQmlContext>
#include <QDebug>

PopUpClass::PopUpClass(QObject *parent) : QObject(parent)
{}
PopUpClass::~PopUpClass(){}


QQuickItem* PopUpClass::createComponent(QQmlEngine* engine)
{

    // Load the QML file for the header
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/PopUp.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for header:" << component.errorString();
        return nullptr;
    }
    QQuickItem* PopUpItem = qobject_cast<QQuickItem*>(component.create());

    return PopUpItem;
}
