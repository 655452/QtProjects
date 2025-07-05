#include "shareddatamodel.h"

SharedDataModel::SharedDataModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Initialize with dummy data if the model is empty
    addItem("Initial Item", "Initial Value");
    addItem("InitialItem1", "Value1");
    addItem("InitialItem2", "Value2");

    // This is  for update only the first instance of the item
    // Simulate continuous data updates (dummy data)
    QTimer *dummyDataTimer = new QTimer(this);
    connect(dummyDataTimer, &QTimer::timeout, this, [this]() {
        if (!m_items.isEmpty()) {
            updateItem(0, QString("Updated Value: %1").arg(QDateTime::currentDateTime().toString()));
        }
    });
    dummyDataTimer->start(2000);
}

int SharedDataModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_items.count();
}

QVariant SharedDataModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();
    const DataItem &item = m_items.at(index.row());

    switch (role) {
    case NameRole:
        return item.name;
    case ValueRole:
        return item.value;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> SharedDataModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ValueRole] = "value";
    return roles;
}

void SharedDataModel::addItem(const QString &name, const QString &value)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({name, value});
    endInsertRows();
    emit dataChangedExternally(name + ": " + value);
}

void SharedDataModel::updateItem(int index, const QString &value)
{
    if (index < 0 || index >= m_items.size())
        return;

    m_items[index].value = value;
    emit dataChanged(this->index(index), this->index(index), {ValueRole});
    emit dataChangedExternally(m_items[index].name + ": " + value);
}

void SharedDataModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size())
        return;
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

QAbstractItemModel* SharedDataModel::getSharedDataModel()
{
    return this;
}
