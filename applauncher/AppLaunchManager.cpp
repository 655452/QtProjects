#include "AppLaunchManager.h"
#include "QDomDocument"
#include <QDebug>
#include <QFile>
#include <QVariant>
#include <QProcess>

AppLaunchManager::AppLaunchManager(QObject *parent)
    : QObject{parent}
{}

QStringList AppLaunchManager::extractSystemNames()
{
    // QString filePath = "/home/asit/WORKSPACE/SystemArbitrator/SystemArbitratorApp/Settings/ApplicationConfig.xml";
    QString filePath="/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SystemSelectionComponent/ApplicationConfig.xml";
    QFile file(filePath);

    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Cannot open file for reading:" << filePath;
        return systemMap;
    }

    QDomDocument document;
    if (!document.setContent(&file)) {
        qWarning() << "Failed to parse XML content.";
        file.close();
        return systemMap;
    }

    file.close();

    QDomElement root = document.documentElement();
    QDomNodeList systemNodes = root.elementsByTagName("System");
    for (int i = 0; i < systemNodes.size(); ++i) {
        QDomElement systemElement = systemNodes.at(i).toElement();

        System system;
        system.name = systemElement.attribute("Name");

        QDomNodeList appNodes = systemElement.elementsByTagName("Application");
        for (int j = 0; j < appNodes.size(); ++j) {
            QDomElement appElement = appNodes.at(j).toElement();
            Application app;
            app.applicationId = appElement.firstChildElement("ApplicationId").text();
            app.applicationName = appElement.firstChildElement("ApplicationName").text();
            app.applicationParameters = appElement.firstChildElement("ApplicationParameters").text();
            app.executablePath = appElement.firstChildElement("ExecutablePath").text();
            app.faultTolerance = appElement.firstChildElement("FaultTolerance").text();
            app.maxInstance = appElement.firstChildElement("MaxInstance").text();
            app.minInstance = appElement.firstChildElement("MinInstance").text();
            app.screen = appElement.firstChildElement("Screen").text();


            system.applications.append(app);
        }

        system.systeminstance.insert(system.name,0);

        systems.append(system);
        systemMap.append(system.name);
    }
    return systemMap;
}



void AppLaunchManager::launchApp(const QString &appName)
{
    if (!systemMap.contains(appName)) {
        qWarning() << "Application not found:" << appName;
        return;
    }

    int count=0;
    for(auto i : systems){
        qDebug()<<i.name;
        if(i.name==appName && i.systeminstance[appName]<=0){

            qDebug()<<" appName found "<<appName<<"   "<<i.name;
            for(auto j:i.applications){

                QProcess *process = new QProcess(this);
                process->processId();
                process->start(j.executablePath);

                if (!process->waitForStarted()) {
                    qWarning() << "Failed to start application:" << j.executablePath;
                }
            }
            systems[count].systeminstance[appName]=1;
            i.systeminstance[appName]=1;
        }
        else{
               qWarning() << "Failed to start application:" ;
        }
        count++;
    }

    // QString appPath = systemMap[appName];


}
