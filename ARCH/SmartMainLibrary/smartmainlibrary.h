/* #ifndef SMARTMAINLIBRARY_H
#define SMARTMAINLIBRARY_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>
#include <QQmlContext>
#include "ismartmainlibraryinterface.h"

class SmartMainLibrary : public QObject, public ISmartMainLibraryInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID ISmartMainLibraryInterface_iid)
    Q_INTERFACES(ISmartMainLibraryInterface)

public:
    explicit SmartMainLibrary(QObject *parent = nullptr);
    ~SmartMainLibrary() override;
    // Implement the interface method
    QQuickItem* createMainLibrary(QQmlEngine* engine, QQuickItem* parent) override;

    bool loadConfig(const QString &configPath, QStringList &componentPaths);

signals:
    void sharedDataChanged(const QString &newData);

};

#endif // SMARTMAINLIBRARY_H */

#ifndef SMARTMAINLIBRARY_H
#define SMARTMAINLIBRARY_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QPluginLoader>
#include <QQmlContext>
#include <QFile>
#include <QDomDocument>
#include "componentmanager.h"
 #include <QKeySequence>
 #include <QXmlStreamReader>
#include "ismartmainlibraryinterface.h"
#include "KeyManager.h"

class SmartMainLibrary : public QObject, public ISmartMainLibraryInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID ISmartMainLibraryInterface_iid)
    Q_INTERFACES(ISmartMainLibraryInterface)

public:
    explicit SmartMainLibrary(QObject *parent = nullptr);
    ~SmartMainLibrary() override;

    QQuickItem* createMainLibrary(QQmlEngine* engine, QQuickItem* parent) override;

    // Expose this method to QML
    Q_INVOKABLE bool loadComponentInZone( QQmlEngine* engine,const QString &componentPath, const QString &componentName, const QString &zoneName);
    Q_INVOKABLE bool unloadComponentFromZone(QQmlEngine* engine,const QString &componentName, const QString &zoneName);

   Q_INVOKABLE void loadFunctionKeyMapping(const QString &filePath);
    void loadPopLibPath();
   Q_INVOKABLE QString getPopupForKey(const QString &component, int keyCode);
   Q_INVOKABLE QString getPopupLibPath(const QString &component);

    QQuickItem *parentRectangle = nullptr;

private:
    QList<QPair<QString, QString>> componentList;  // List of component name and path pairs
     QHash<QString, QPluginLoader*> loadedPlugins;
    QHash<QString, QQuickItem*> loadedComponentItems;  // Tracks loaded components
    ComponentManager* componentManager;

    QHash<QString, QHash<int, QString>> functionKeyMapping;
    QHash<QString,QString> popupLibPathMaping;

};

#endif // SMARTMAINLIBRARY_H

