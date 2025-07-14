#ifndef NOTIFICATIONMANGER_H
#define NOTIFICATIONMANGER_H

#pragma once
#include <QObject>
#include "NotificationModel.h"
#include "UnseenNotificationModel.h"

class NotificationManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(NotificationModel* notice READ notice CONSTANT)

    Q_PROPERTY(UnseenNotificationModel* unseenNotice READ unseenNotice() CONSTANT)

    Q_PROPERTY(NotificationModel* warning READ warning CONSTANT)
    Q_PROPERTY(NotificationModel* alert READ alert CONSTANT)

public:
    explicit NotificationManager(QObject *parent = nullptr);

    NotificationModel* notice() const { return m_notice; }
    NotificationModel* warning() const { return m_warning; }
    NotificationModel* alert() const { return m_alert; }

    UnseenNotificationModel* unseenNotice() const { return m_unseenNotice; }
private:
    NotificationModel* m_notice;
    UnseenNotificationModel* m_unseenNotice;
    NotificationModel* m_warning;
    NotificationModel* m_alert;
};

#endif // NOTIFICATIONMANGER_H
