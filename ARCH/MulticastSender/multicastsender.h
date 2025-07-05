/*
 * #ifndef MULTICASTSENDER_H
#define MULTICASTSENDER_H

#include "imulticastsender.h"
#include <QObject>
#include <QUdpSocket>
#include <QTimer>
#include <QThread>
#include <QDebug>
#include <QFile>
#include <QXmlStreamReader>

class MulticastSenderWorker : public QObject {
    Q_OBJECT
public:
    explicit MulticastSenderWorker(QObject *parent = nullptr);
    ~MulticastSenderWorker();

public slots:
    void startBroadcasting();
    void stopBroadcasting();
    void sendMulticastMessage();

private:
    void loadConfig();
    QUdpSocket udpSocket;
    QTimer broadcastTimer;
    QString groupAddress;
    int nodeId;
    QList<int> nodeStatus;
};

class MulticastSender : public IMulticastSender {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID IMulticastSender_iid)
    Q_INTERFACES(IMulticastSender)

public:
    explicit MulticastSender(QObject *parent = nullptr);
    ~MulticastSender();

    void startBroadcasting() override;
    void stopBroadcasting() override;

private:
    QThread workerThread;
    MulticastSenderWorker *worker;
};

#endif // MULTICASTSENDER_H
*/


#ifndef MULTICASTSENDER_H
#define MULTICASTSENDER_H

#include "imulticastsender.h"
#include <QObject>
#include <QUdpSocket>
#include <QTimer>
#include <QThread>
#include <QDebug>
#include <QFile>
#include <QXmlStreamReader>

class MulticastSenderWorker : public QObject {
    Q_OBJECT
public:
    explicit MulticastSenderWorker(QObject *parent = nullptr);
    ~MulticastSenderWorker();

public slots:
    void startBroadcasting();
    void stopBroadcasting();
    void sendMulticastMessage();

private:
    void loadConfig();
    QUdpSocket udpSocket;
    QTimer *broadcastTimer;  // Use pointer
    QString groupAddress;
    int nodeId;
    QList<int> nodeStatus;
};

class MulticastSender : public IMulticastSender {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID IMulticastSender_iid)
    Q_INTERFACES(IMulticastSender)

public:
    explicit MulticastSender(QObject *parent = nullptr);
    ~MulticastSender();

    void startBroadcasting() override;
    void stopBroadcasting() override;

private:
    QThread workerThread;
    MulticastSenderWorker *worker;
};

#endif // MULTICASTSENDER_H
