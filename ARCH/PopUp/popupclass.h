#ifndef POPUPCLASS_H
#define POPUPCLASS_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>

#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"
class PopUpClass: public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)
public:
   explicit PopUpClass(QObject *parent = nullptr);
   ~PopUpClass() override;
    // Implement the interface method
    QQuickItem* createComponent(QQmlEngine* engine) override;
};

#endif // POPUPCLASS_H
