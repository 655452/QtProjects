#include "ZoneLoader.h"

#include "ZoneLoader.h"
#include <QFile>
#include <QXmlStreamReader>
#include <QDebug>

ZoneLoader::ZoneLoader(QObject *parent) : QObject(parent) {}

QList<QVariantMap> ZoneLoader::zones() const {
    return m_zones;
}

void ZoneLoader::loadZonesFromXml(const QString &filePath) {
    m_zones.clear();
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file:" << filePath;
        return;
    }

    QXmlStreamReader xml(&file);
    while (!xml.atEnd()) {
        xml.readNext();
        if (xml.isStartElement() && xml.name() == "Zone") {
            QVariantMap zone;
            foreach (const QXmlStreamAttribute &attr, xml.attributes()) {
                zone[attr.name().toString()] = attr.value().toString();
            }
            m_zones.append(zone);
        }
    }

    if (xml.hasError()) {
        qWarning() << "XML parse error:" << xml.errorString();
    }

    file.close();
    emit zonesChanged();
}
