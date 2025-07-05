#include "popup3.h"

PopUp3::PopUp3(QObject *parent) : QObject(parent)
{}

PopUp3::~PopUp3()
{

}

QQuickItem *PopUp3::createComponent(QQmlEngine *engine)
{
    // Load the QML file for the header
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/PopUp3.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for header:" << component.errorString();
        return nullptr;
    }
    QQuickItem* PopUpItem = qobject_cast<QQuickItem*>(component.create());

    return PopUpItem;
}

