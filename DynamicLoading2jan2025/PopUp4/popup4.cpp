#include "popup4.h"

PopUp4::PopUp4(QObject *parent) : QObject(parent)
{}

PopUp4::~PopUp4()
{

}

QQuickItem *PopUp4::createComponent(QQmlEngine *engine)
{
    // Load the QML file for the header
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/PopUp4.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for header:" << component.errorString();
        return nullptr;
    }
    QQuickItem* PopUpItem = qobject_cast<QQuickItem*>(component.create());

    return PopUpItem;
}
