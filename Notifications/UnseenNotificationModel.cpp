
#include "UnseenNotificationModel.h"
#include "NotificationModel.h"

UnseenNotificationModel::UnseenNotificationModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    setFilterRole(NotificationModel::SeenRole);
    setDynamicSortFilter(true);  // Auto-refresh on source model changes
}

// void UnseenNotificationModel::setSource(NotificationModel *sourceModel)
// {
//     setSourceModel(sourceModel);
//         emit sourceChanged();
//     connect(sourceModel, &NotificationModel::notificationChanged,this, &UnseenNotificationModel::invalidateFilter);
//         // Good for structure changes
//         connect(sourceModel, &NotificationModel::rowsInserted, this, &UnseenNotificationModel::invalidateFilter);
//         connect(sourceModel, &NotificationModel::rowsRemoved, this, &UnseenNotificationModel::invalidateFilter);
//         connect(sourceModel, &NotificationModel::modelReset, this, &UnseenNotificationModel::invalidateFilter);
//         connect(sourceModel, &NotificationModel::dataChanged, this, [this]() {
//             invalidateFilter();
//             emit unseenCountChanged();
//         });
//         connect(sourceModel, &NotificationModel::rowsInserted, this, [this]() {
//             invalidateFilter();
//             emit unseenCountChanged();
//         });

// }
void UnseenNotificationModel::setSource(NotificationModel *sourceModel)
{
    if (!sourceModel)
        return;

    setSourceModel(sourceModel);
    emit sourceChanged();

    auto update = [this]() {
        invalidateFilter();
        emit unseenCountChanged();
    };
        connect(sourceModel, &NotificationModel::notificationChanged,this, &UnseenNotificationModel::invalidateFilter);

    connect(sourceModel, &NotificationModel::dataChanged, this, update);
    connect(sourceModel, &NotificationModel::rowsInserted, this, update);
    connect(sourceModel, &NotificationModel::rowsRemoved, this, update);
    connect(sourceModel, &NotificationModel::modelReset,  this, update);
}


NotificationModel* UnseenNotificationModel::sourceModel() const {
    return qobject_cast<NotificationModel*>(QSortFilterProxyModel::sourceModel());
}

bool UnseenNotificationModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    return !index.data(NotificationModel::SeenRole).toBool(); // unseen only
}
int UnseenNotificationModel::unseenCount() const
{
    return rowCount(); // internally filtered count
}

void UnseenNotificationModel::markSourceAsSeen(int proxyIndex)
{

    QModelIndex proxyIdx = this->index(proxyIndex, 0);
    if (!proxyIdx.isValid())
        return;

    QModelIndex sourceIdx = this->mapToSource(proxyIdx);
    if (!sourceIdx.isValid())
        return;

    NotificationModel* src = qobject_cast<NotificationModel*>(sourceModel());
    if (src)
        src->markAsSeen(sourceIdx.row());
}


