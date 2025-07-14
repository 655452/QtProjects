#include "NotificationModel.h"

NotificationModel::NotificationModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int NotificationModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_items.size();
}

QVariant NotificationModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const NotificationItem &item = m_items[index.row()];

    switch (role) {
    case TitleRole: return item.title;
    case TimeRole: return item.time;
    case TypeRole: return item.type;
    case SeenRole: return item.seen;  // <-- new
    }
    return QVariant();
}

QHash<int, QByteArray> NotificationModel::roleNames() const {
    return {
        { TitleRole, "title" },
        { TimeRole, "time" },
        { TypeRole, "type" },
        { SeenRole, "seen" }
    };
}

void NotificationModel::addNotification(const QString &title, const QString &time) {
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(NotificationItem(title, time, m_type));
    endInsertRows();
    emit notificationChanged();
}

void NotificationModel::removeNotification(int index) {
    if (index < 0 || index >= m_items.size())
        return;
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
        emit notificationChanged();
}

void NotificationModel::updateNotification(int index, const QString &title, const QString &time) {
    if (index < 0 || index >= m_items.size())
        return;

    m_items[index].title = title;
    m_items[index].time = time;

    QModelIndex modelIndex = createIndex(index, 0);
    emit dataChanged(modelIndex, modelIndex);
}

void NotificationModel::clear() {
    beginResetModel();
    m_items.clear();
    endResetModel();
        emit notificationChanged();
}
void NotificationModel::markAsSeen(int index) {
    if (index < 0 || index >= m_items.size())
        return;

    if (!m_items[index].seen) {
        m_items[index].seen = true;
        QModelIndex changedIdx = this->index(index);
        emit dataChanged(changedIdx, changedIdx, {SeenRole});
        emit notificationChanged();
    }
}

QString NotificationModel::type() const {
    return m_type;
}

void NotificationModel::setType(const QString &type) {
    if (m_type != type) {
        m_type = type;
        emit typeChanged();
    }
}
