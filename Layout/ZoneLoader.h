#ifndef ZONELOADER_H
#define ZONELOADER_H

// ZoneLoader.h

#include <QObject>
#include <QVariantMap>
#include <QList>

class ZoneLoader : public QObject {
    Q_OBJECT
    Q_PROPERTY(QList<QVariantMap> zones READ zones NOTIFY zonesChanged)

public:
    explicit ZoneLoader(QObject *parent = nullptr);

    QList<QVariantMap> zones() const;

    Q_INVOKABLE void loadZonesFromXml(const QString &filePath);

signals:
    void zonesChanged();

private:
    QList<QVariantMap> m_zones;
};

#endif // ZONELOADER_H

