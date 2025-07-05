#include "componentmanager.h"
#include <QFile>
#include <QDomDocument>
#include <QDebug>

ComponentManager::ComponentManager(QObject *parent)
    : QObject(parent) {
}

bool ComponentManager::loadComponentConfig(const QString &configPath) {
    QFile file(configPath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open component config file:" << configPath;
        return false;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qDebug() << "Failed to parse component config file:" << configPath;
        return false;
    }

    QDomElement root = doc.documentElement();
    QDomNodeList componentNodes = root.elementsByTagName("Component");

    for (int i = 0; i < componentNodes.count(); ++i) {
        QDomNode node = componentNodes.item(i);
        QDomElement element = node.toElement();
        if (!element.isNull()) {
            QString name = element.attribute("Name");
            QString path = element.attribute("Path");
            componentMap.insert(name, path);
        }
    }

    qDebug() << "Component configuration loaded successfully.";
    return true;
}

bool ComponentManager::loadLayoutConfig(const QString &layoutPath) {
    QFile file(layoutPath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open layout config file:" << layoutPath;
        return false;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qDebug() << "Failed to parse layout config file:" << layoutPath;
        return false;
    }

    QDomElement root = doc.documentElement();
    QDomNodeList zoneNodes = root.elementsByTagName("Zone");

    for (int i = 0; i < zoneNodes.count(); ++i) {
        QDomNode node = zoneNodes.item(i);
        QDomElement element = node.toElement();
        if (!element.isNull()) {
            QString zone = element.attribute("Name");
            QString component = element.attribute("Component");
            layoutMap.insert(zone, component);
        }
    }

    qDebug() << "Layout configuration loaded successfully.";
    return true;
}

QHash<QString, QString> ComponentManager::getComponentMap() const {
    return componentMap;
}

QHash<QString, QString> ComponentManager::getLayoutMap() const {
    return layoutMap;
}

QHash<QString, QQuickItem*> ComponentManager::createComponentMap(QQmlEngine* engine) {
    QHash<QString, QQuickItem*> componentItems;

    for (auto it = componentMap.begin(); it != componentMap.end(); ++it) {
        QString name = it.key();
        QString path = it.value();

        QPluginLoader loader(path);
        QObject* plugin = loader.instance();
        if (!plugin) {
            qDebug() << "Failed to load plugin for component" << name << ":" << loader.errorString();
            continue;
        }

        globalinterface* pluginInterface = qobject_cast<globalinterface*>(plugin);
        if (pluginInterface) {
            QQuickItem* item = pluginInterface->createComponent(engine);
            if (item) {
                componentItems.insert(name, item);
                qDebug() << "Successfully created QQuickItem for component:" << name;
            } else {
                qDebug() << "Failed to create QQuickItem for component:" << name;
            }
        } else {
            qDebug() << "Invalid plugin interface for component:" << name;
        }
    }

    return componentItems;
}
