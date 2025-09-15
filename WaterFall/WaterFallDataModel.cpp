#include "WaterFallDataModel.h"

SeriesData::SeriesData(const QString &type, const QString &size)
    : m_type(type), m_size(size)
{
}

QString SeriesData::type() const
{
    return m_type;
}

QString SeriesData::size() const
{
    return m_size;
}

WaterFallDataModel::WaterFallDataModel(QObject *parent)
    : QAbstractListModel(parent)
{}

void WaterFallDataModel::addAnimal(const SeriesData &seriesData)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_animals << seriesData;
    endInsertRows();
}

int WaterFallDataModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_animals.count();
}

QVariant WaterFallDataModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= m_animals.count())
        return QVariant();
    const SeriesData &seriesData = m_animals[index.row()];
    if(role == TypeRole)
        return seriesData.type();
    else if (role == SizeRole)
        return seriesData.size();
    return QVariant();
}

QHash<int, QByteArray> WaterFallDataModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    return roles;
}

