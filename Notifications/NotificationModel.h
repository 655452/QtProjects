#ifndef NOTIFICATIONMODEL_H
#define NOTIFICATIONMODEL_H

#include <QAbstractListModel>

struct NotificationItem {
    QString title;
    QString time;
    QString type;
    bool seen;  // <-- new field

    NotificationItem(const QString &t, const QString &tm, const QString &ty, bool s = false)
        : title(t), time(tm), type(ty), seen(s) {}
};

class NotificationModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)

public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        TimeRole,
        TypeRole,
        SeenRole      // <-- new role
    };


    explicit NotificationModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void markAsSeen(int index);

    Q_INVOKABLE void addNotification(const QString &title, const QString &time);
    Q_INVOKABLE void removeNotification(int index);
    Q_INVOKABLE void updateNotification(int index, const QString &title, const QString &time);
    Q_INVOKABLE void clear();

    QString type() const;
    void setType(const QString &type);

signals:
    void typeChanged();
    void notificationChanged();

private:
    QString m_type;
    QList<NotificationItem> m_items;
};

#endif // NOTIFICATIONMODEL_H
