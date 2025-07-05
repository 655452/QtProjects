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
#include "ismartmainlibraryinterface.h"

class SmartMainLibrary : public QObject, public ISmartMainLibraryInterface
{
        Q_OBJECT
        Q_PLUGIN_METADATA(IID ISmartMainLibraryInterface_iid)
    Q_INTERFACES(ISmartMainLibraryInterface)

public:
        explicit SmartMainLibrary(QObject *parent = nullptr);
        ~SmartMainLibrary() override;

        QQuickItem* createMainLibrary(QQmlEngine* engine, QQuickItem* parent) override;

        bool loadConfig(const QString &configPath, QStringList &componentPaths);
        QStringList components ;

private:
        QList<QPair<QString, QString>> componentList;  // List of component name and path pairs

signals:
    void sharedDataChanged(const QString &newData);
};

#endif // SMARTMAINLIBRARY_H

