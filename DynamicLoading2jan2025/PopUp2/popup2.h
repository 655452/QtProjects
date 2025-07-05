#ifndef POPUP2_H
#define POPUP2_H

#include "PopUp2_global.h"

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>

#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"
class  PopUp2: public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)
public:
    explicit PopUp2(QObject *parent = nullptr);
    ~PopUp2() override;
    QQuickItem* createComponent(QQmlEngine* engine) override;
};

#endif // POPUP2_H
