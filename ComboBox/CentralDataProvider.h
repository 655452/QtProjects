// centraldataprovider.h
#ifndef CENTRALDATAPROVIDER_H
#define CENTRALDATAPROVIDER_H

#include <QObject>
#include <QVariantMap>
#include <QVariantList>

class CentralDataProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap centralData READ centralData NOTIFY centralDataChanged)

public:
    explicit CentralDataProvider(QObject *parent = nullptr);

    QVariantMap centralData() const;

signals:
    void centralDataChanged();

private:
    QVariantMap m_centralData;
    void buildCentralData();  // initializes the structure
};

#endif // CENTRALDATAPROVIDER_H
