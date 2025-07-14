#include "NotificationManger.h"

NotificationManager::NotificationManager(QObject *parent)
    : QObject(parent)
{
    m_notice = new NotificationModel(this);
    m_warning = new NotificationModel(this);
    m_alert = new NotificationModel(this);

    // Add dummy data
    m_notice->addNotification("System notice", "10:00 AM");
    m_notice->addNotification("New notice", "10:05 AM");

    m_unseenNotice = new UnseenNotificationModel(this);
    m_unseenNotice->setSource(m_notice);

    m_warning->addNotification("Battery warning", "10:15 AM");
    m_warning->addNotification("Download warning", "10:20 AM");

    m_alert->addNotification("Weather Alert", "10:35 AM");
    m_alert->addNotification("Missed Call", "11:10 AM");
}
