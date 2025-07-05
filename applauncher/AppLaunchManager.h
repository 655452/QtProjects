#ifndef APPLAUNCHMANAGER_H
#define APPLAUNCHMANAGER_H

#include <QObject>
#include <QMap>
#include <QHash>

struct Application {
    QString applicationId;
    QString applicationName;
    QString applicationParameters;
    QString executablePath;
    QString faultTolerance;
    QString maxInstance;
    QString minInstance;
    QString screen;
};

struct System {
    QString name;
    QList<Application> applications;
    QHash<QString,int> systeminstance;
};

class AppLaunchManager : public QObject
{
    Q_OBJECT
public:
    explicit AppLaunchManager(QObject *parent = nullptr);
    Q_INVOKABLE void launchApp(const QString &appName);
    Q_INVOKABLE QStringList extractSystemNames();

private:
    QList<QString> systemMap; // Map of appName -> appPath
    QList<System> systems;



};

#endif // APPLAUNCHMANAGER_H
