#ifndef IHEADERINTERFACE_H
#define IHEADERINTERFACE_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QAbstractItemModel>

// Interface definition
class IHeaderInterface
{
public:
    virtual ~IHeaderInterface() = default;

    // Method to create the header component
    virtual QQuickItem* createHeader(QQmlEngine* engine) = 0;
};

#define IHeaderInterface_iid "com.example.IHeaderInterface"
Q_DECLARE_INTERFACE(IHeaderInterface, IHeaderInterface_iid)

#endif // IHEADERINTERFACE_H
