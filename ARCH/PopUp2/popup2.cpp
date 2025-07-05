#include "popup2.h"

PopUp2::PopUp2(QObject *parent) : QObject(parent)
{}

PopUp2::~PopUp2()
{

}

QQuickItem *PopUp2::createComponent(QQmlEngine *engine)
{
    // Load the QML file for the header
    QQmlComponent component(engine, QUrl(QStringLiteral("qrc:/PopUp2.qml")));
    if (component.status() == QQmlComponent::Error) {
        qDebug() << "Error loading QML component for header:" << component.errorString();
        return nullptr;
    }
    QQuickItem* PopUpItem = qobject_cast<QQuickItem*>(component.create());

    return PopUpItem;
}
