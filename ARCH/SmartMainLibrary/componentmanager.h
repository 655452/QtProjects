#ifndef COMPONENTMANAGER_H
#define COMPONENTMANAGER_H
#include <QObject>
#include <QHash>
#include <QString>
#include <QPluginLoader>
#include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"

class ComponentManager: public QObject {
  Q_OBJECT
public:
    explicit ComponentManager(QObject *parent = nullptr);
    // Methods to load configurations
    bool loadComponentConfig(const QString &configPath);
    bool loadLayoutConfig(const QString &layoutPath);

    // Accessors to retrieve component and layout data
    QHash<QString, QString> getComponentMap() const;
    QHash<QString, QString> getLayoutMap() const;
    QHash<QString, QQuickItem*> createComponentMap(QQmlEngine* engine);


private:
    QHash<QString, QString> componentMap;  // Stores component name and path
    QHash<QString, QString> layoutMap;
};

#endif // COMPONENTMANAGER_H
