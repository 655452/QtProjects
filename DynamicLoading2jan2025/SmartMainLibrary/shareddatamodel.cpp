#include "shareddatamodel.h"

SharedDataModel::SharedDataModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Add initial data to the model
    addItem("Initial Item 1", "Value 1");
    addItem("Initial Item 2", "Value 2");

    // Simulate continuous data updates (optional)
    QTimer *dataUpdateTimer = new QTimer(this);
    connect(dataUpdateTimer, &QTimer::timeout, this, [this]() {
        if (!m_items.isEmpty()) {
            updateItem(0, QString("Updated Value: %1").arg(QDateTime::currentDateTime().toString()));
        }
    });
    dataUpdateTimer->start(2000); // Update every 2 seconds
}

int SharedDataModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }
    return m_items.size();
}

QVariant SharedDataModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size()) {
        return QVariant();
    }

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
    return {
        { NameRole, "name" },
        { ValueRole, "value" }
    };
}

void SharedDataModel::addItem(const QString &name, const QString &value)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({ name, value });
    endInsertRows();

    // Notify about external data change
    emit dataChangedExternally(QString("Added: %1 = %2").arg(name, value));
}

void SharedDataModel::updateItem(int index, const QString &value)
{
    if (index < 0 || index >= m_items.size()) {
        return;
    }

    m_items[index].value = value;
    emit dataChanged(createIndex(index, 0), createIndex(index, 0), { ValueRole });
    emit dataChangedExternally(QString("Updated: %1 to %2").arg(m_items[index].name, value));
}

void SharedDataModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size()) {
        return;
    }

    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();

    emit dataChangedExternally("Item removed.");
}

void SharedDataModel::printData() const
{
    qDebug() << "Current data in SharedDataModel:";
    for (const auto &item : m_items) {
        qDebug() << "Name:" << item.name << ", Value:" << item.value;
    }
}
