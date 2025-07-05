#ifndef SMARTFOOTER_H
#define SMARTFOOTER_H

#include<QObject>
#include<QQmlEngine>
#include<QQmlComponent>
#include<QQuickItem>
#include<QQuickView>
#include<QtQuick>
#include<QDebug>
#include "SmartFooter_global.h"

#include "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartMainLibrary/lib/globalinterface.h"
class SMARTFOOTER_EXPORT SmartFooter:public QObject,public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)

public:
    explicit SmartFooter(QObject *parent = nullptr);
    ~SmartFooter() override;
    virtual QQuickItem* createComponent(QQmlEngine* engine) override;
};

#endif // SMARTFOOTER_H
