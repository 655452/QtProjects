#ifndef SMARTMAINSCREEN_H
#define SMARTMAINSCREEN_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>

#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"
class SmartMainScreen : public QObject, public globalinterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID globalinterface_iid)
    Q_INTERFACES(globalinterface)

public:
    explicit SmartMainScreen(QObject *parent = nullptr);
    ~SmartMainScreen() override;

    // Implement the interface method
    QQuickItem* createComponent(QQmlEngine* engine) override;

    // Implement the data change handling
    void connectSharedDataModel(QObject *sharedDataModel) ;

private slots:
    void handleDataChanged(const QString &newData);
};

#endif // SMARTMAINSCREEN_H
