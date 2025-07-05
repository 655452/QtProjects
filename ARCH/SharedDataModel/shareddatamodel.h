#ifndef SHAREDDATAMODEL_H
#define SHAREDDATAMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QDebug>
#include "isharedmodelinterface.h"
#include <QTimer>
#include <QDateTime>

class SharedDataModel : public QAbstractListModel, public ISharedModelInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID ISharedModelInterface_iid)
    Q_INTERFACES(ISharedModelInterface)

public:
    enum DataRoles {
        NameRole = Qt::UserRole + 1, // Custom roles start at Qt::UserRole + 1
        ValueRole
    };

    explicit SharedDataModel(QObject *parent = nullptr);

    // QAbstractListModel overrides
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // ISharedModelInterface implementation
    QAbstractItemModel* getSharedDataModel() override;

    // Custom methods to manage the data
    void addItem(const QString &name, const QString &value) override;
    void updateItem(int index, const QString &value);
    void removeItem(int index);

signals:
    void dataChangedExternally(const QString &newData);

private:
    struct DataItem {
        QString name;
        QString value;
    };

    QList<DataItem> m_items; // Internal storage for the data
};

#endif // SHAREDDATAMODEL_H
