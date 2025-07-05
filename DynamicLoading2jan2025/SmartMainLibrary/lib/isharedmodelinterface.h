#ifndef ISHAREDMODELINTERFACE_H
#define ISHAREDMODELINTERFACE_H

#include <QObject>
#include <QAbstractItemModel>

class ISharedModelInterface
{
public:
    virtual ~ISharedModelInterface() = default;
    // Method to create and return the shared data model
    virtual QAbstractItemModel* getSharedDataModel() = 0;
    virtual void addItem(const QString &name, const QString &value)=0;
};

#define ISharedModelInterface_iid "com.example.ISharedModelInterface"
Q_DECLARE_INTERFACE(ISharedModelInterface, ISharedModelInterface_iid)

#endif // ISHAREDMODELINTERFACE_H
