#ifndef SHAREDDATAMODEL_H
#define SHAREDDATAMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QList>
#include <QDebug>
#include <QDateTime>
#include<QTimer>

#include "SmartMainLibrary_global.h"

class SMARTMAINLIBRARY_EXPORT SharedDataModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum DataRoles {
        NameRole = Qt::UserRole + 1,
        ValueRole
    };

    explicit SharedDataModel(QObject *parent = nullptr);

    // Required overrides for QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Custom methods for managing data
    Q_INVOKABLE void addItem(const QString &name, const QString &value);
    Q_INVOKABLE void updateItem(int index, const QString &value);
    Q_INVOKABLE void removeItem(int index);
     void printData() const; // New method to log data

signals:
    void dataChangedExternally(const QString &newData); // Signal to notify external components about updates

private:
    struct DataItem {
        QString name;
        QString value;
    };

    QList<DataItem> m_items; // Internal data storage
};



#endif // SHAREDDATAMODEL_H
