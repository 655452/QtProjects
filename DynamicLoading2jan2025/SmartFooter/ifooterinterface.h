#ifndef IFOOTERINTERFACE_H
#define IFOOTERINTERFACE_H
#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QAbstractItemModel>

// Interface definition
class IFooterInterface
{
public:
    virtual ~IFooterInterface() = default;
    // Method to create the header component
    virtual QQuickItem* createFooter(QQmlEngine* engine) = 0;
};

#define IFooterInterface_iid "com.example.IFooterInterface"
Q_DECLARE_INTERFACE(IFooterInterface, IFooterInterface_iid)

#endif // IFOOTERINTERFACE_H
