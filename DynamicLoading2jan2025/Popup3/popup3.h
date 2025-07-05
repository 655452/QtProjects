#ifndef POPUP3_H
#define POPUP3_H

#include "Popup3_global.h"


#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>

#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"

class  PopUp3: public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)
public:
    explicit PopUp3(QObject *parent = nullptr);
    ~PopUp3() override;
    QQuickItem* createComponent(QQmlEngine* engine) override;
};

#endif // POPUP3_H
