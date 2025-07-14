
#ifndef UNSEENNOTIFICATIONMODEL_H
#define UNSEENNOTIFICATIONMODEL_H

#include <QSortFilterProxyModel>
// #include "NotificationManger.h"
#include "NotificationModel.h"

class UnseenNotificationModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(NotificationModel* sourceModel READ sourceModel WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(int unseenCount READ unseenCount NOTIFY unseenCountChanged)


public:
    explicit UnseenNotificationModel(QObject *parent = nullptr);

    Q_INVOKABLE NotificationModel* sourceModel()const;
    Q_INVOKABLE void setSource(NotificationModel *sourceModel);
    Q_INVOKABLE int unseenCount() const;
    // Q_INVOKABLE void  markSourceAsSeen(int proxyIndex) const;
    Q_INVOKABLE void markSourceAsSeen(int proxyIndex);


signals:
    void sourceChanged();
    void unseenCountChanged();
protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;
};

#endif // UNSEENNOTIFICATIONMODEL_H

