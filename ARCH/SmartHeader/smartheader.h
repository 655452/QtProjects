#ifndef SMARTHEADER_H
#define SMARTHEADER_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include "SmartHeader_global.h"
// #include "iheaderinterface.h"
#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"

class SMARTHEADER_EXPORT SmartHeader : public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)

public:
    explicit SmartHeader(QObject *parent = nullptr);
    ~SmartHeader() override;

public slots:  // ✅ Ensure slots are declared here
    void updateSharedValue(QString value);


    // Implement the interface method
    virtual QQuickItem* createComponent(QQmlEngine* engine) override;

};

#endif // SMARTHEADER_H
