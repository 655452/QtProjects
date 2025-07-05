#ifndef POPUP4_H
#define POPUP4_H

#include "PopUp4_global.h"


#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>

#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"
class  PopUp4: public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)
public:
    explicit PopUp4(QObject *parent = nullptr);
    ~PopUp4() override;
    QQuickItem* createComponent(QQmlEngine* engine) override;
};

#endif // POPUP4_H
