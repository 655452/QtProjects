#ifndef ISMARTMAINLIBRARYINTERFACE_H
#define ISMARTMAINLIBRARYINTERFACE_H

#include <QObject>
#include <QQuickItem>
#include <QQmlEngine>

class ISmartMainLibraryInterface
{
public:
    virtual ~ISmartMainLibraryInterface() = default;
    // Method to create and return the main library item
    virtual QQuickItem* createMainLibrary(QQmlEngine* engine, QQuickItem* parent) = 0;
};

#define ISmartMainLibraryInterface_iid "com.example.ISmartMainLibraryInterface"
Q_DECLARE_INTERFACE(ISmartMainLibraryInterface, ISmartMainLibraryInterface_iid)

#endif // ISMARTMAINLIBRARYINTERFACE_H
