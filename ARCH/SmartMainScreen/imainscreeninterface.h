#ifndef IMAINSCREENINTERFACE_H
#define IMAINSCREENINTERFACE_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QAbstractItemModel>

class IMainScreenInterface
{
public:
    virtual ~IMainScreenInterface() = default;

    // Method to create the MainScreen component
    virtual QQuickItem* createMainScreen(QQmlEngine* engine) = 0;

    // New method to connect signals from the shared data model
    virtual void connectSharedDataModel(QObject *sharedDataModel) = 0;
};

#define IMainScreenInterface_iid "com.example.IMainScreenInterface"
Q_DECLARE_INTERFACE(IMainScreenInterface, IMainScreenInterface_iid)
#endif // IMAINSCREENINTERFACE_H
