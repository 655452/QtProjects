/*
 #include "multicastsender.h"
#include <QVariant>

MulticastSender::MulticastSender(QObject *parent)
    : IMulticastSender(parent), groupAddress("239.255.255.250"){
    // udpSocket.bind(QHostAddress(QHostAddress::AnyIPv4), 0);
    udpSocket.bind(QHostAddress(QHostAddress::AnyIPv4), 45454, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    // Join the multicast group
    udpSocket.joinMulticastGroup(QHostAddress(groupAddress));

    udpSocket.setSocketOption(QAbstractSocket::MulticastTtlOption, QVariant(25));
    connect(&broadcastTimer, &QTimer::timeout, this, &MulticastSender::sendMulticastMessage);
    loadConfig();
}

MulticastSender::~MulticastSender() {
    stopBroadcasting();
}

void MulticastSender::startBroadcasting() {
    if (!broadcastTimer.isActive()) {
        broadcastTimer.start(2000);
        qDebug() << "Started broadcasting messages.";
    }
}

void MulticastSender::stopBroadcasting() {
    if (broadcastTimer.isActive()) {
        broadcastTimer.stop();
        qDebug() << "Stopped broadcasting messages.";
    }
}


void MulticastSender::loadConfig()
{
    QFile file("/home/asit/Documents/AsitEmpire/ARCH/MulticastSender/node_config.xml");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open configuration file.";
        return;
    }

    QXmlStreamReader xml(&file);

    while (!xml.atEnd() && !xml.hasError()) {
        xml.readNext();

        if (xml.isStartElement()) {
            if (xml.name() == "id") {
                nodeId = xml.readElementText().toInt();
                qDebug() << "Loaded node ID:" << nodeId;
            } else if (xml.name() == "status") {
                QStringList statusList = xml.readElementText().split(",");
                nodeStatus.clear();
                for (const QString &status : statusList) {
                    nodeStatus.append(status.toInt());
                }
            }
        }
    }

    file.close();

    if (nodeId == -1 || nodeStatus.size() != 9) {
        qWarning() << "Invalid configuration.";
    }

    qDebug() << "Final Loaded Node ID:" << nodeId;
    qDebug() << "Final Loaded Node Status:" << nodeStatus;
}


void MulticastSender::sendMulticastMessage() {

    QByteArray datagram;
    QDataStream out(&datagram, QIODevice::WriteOnly);

    // Send Part 1: Node ID
    out << static_cast<qint32>(nodeId);

    // Send Part 2: Node Status Array
    out << nodeStatus;

    udpSocket.writeDatagram(datagram, QHostAddress(groupAddress), 45454);

    qDebug() << "Sent Node ID:" << nodeId;
    qDebug() << "Sent Node Status Array:" << nodeStatus;
}
*/


#include "multicastsender.h"
#include <QVariant>

// ---------------------- Worker Class ----------------------
MulticastSenderWorker::MulticastSenderWorker(QObject *parent)
    : QObject(parent) {

    udpSocket.bind(QHostAddress(QHostAddress::AnyIPv4), 45454, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    udpSocket.joinMulticastGroup(QHostAddress(groupAddress));
    udpSocket.setSocketOption(QAbstractSocket::MulticastTtlOption, QVariant(25));

    broadcastTimer = new QTimer(this);  // Allocate timer in constructor
    connect(broadcastTimer, &QTimer::timeout, this, &MulticastSenderWorker::sendMulticastMessage);

    loadConfig();
}

MulticastSenderWorker::~MulticastSenderWorker() {
    stopBroadcasting();
}

void MulticastSenderWorker::startBroadcasting() {
    if (!broadcastTimer->isActive()) {
        broadcastTimer->start(2000);
        qDebug() << "Started broadcasting messages in thread:" << QThread::currentThread();
    }
}

void MulticastSenderWorker::stopBroadcasting() {
    if (broadcastTimer->isActive()) {
        broadcastTimer->stop();
        qDebug() << "Stopped broadcasting messages.";
    }
}

void MulticastSenderWorker::loadConfig() {
    QFile file("/home/asit/Documents/AsitEmpire/ARCH/MulticastSender/node_config.xml");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open configuration file.";
        return;
    }

    QXmlStreamReader xml(&file);
    while (!xml.atEnd() && !xml.hasError()) {
        xml.readNext();
        if (xml.isStartElement()) {
            if (xml.name() == "id") {
                nodeId = xml.readElementText().toInt();
                qDebug() << "Loaded node ID:" << nodeId;
            } else if (xml.name() == "status") {
                QStringList statusList = xml.readElementText().split(",");
                nodeStatus.clear();
                for (const QString &status : statusList) {
                    nodeStatus.append(status.toInt());
                }
            }
        }
    }
    file.close();
    qDebug() << "Final Loaded Node ID:" << nodeId;
    qDebug() << "Final Loaded Node Status:" << nodeStatus;
}

void MulticastSenderWorker::sendMulticastMessage() {
    QByteArray datagram;
    QDataStream out(&datagram, QIODevice::WriteOnly);
    out << static_cast<qint32>(nodeId);
    out << nodeStatus;
    udpSocket.writeDatagram(datagram, QHostAddress(groupAddress), 45454);
    qDebug() << "Sent Node ID:" << nodeId;
    qDebug() << "Sent Node Status Array:" << nodeStatus;
}

// ---------------------- Main Plugin Class ----------------------
MulticastSender::MulticastSender(QObject *parent) : IMulticastSender(parent), worker(nullptr) {
    workerThread.setObjectName("MulticastSenderThread");

    connect(&workerThread, &QThread::started, this, [this]() {
        worker = new MulticastSenderWorker();  // Create worker inside thread
        worker->moveToThread(&workerThread);

        // Move QTimer event loop to worker thread
        // QMetaObject::invokeMethod(worker, "startBroadcasting", Qt::QueuedConnection);
    });

    connect(&workerThread, &QThread::finished, this, [this]() {
        worker->deleteLater();
        worker = nullptr;
    });

    workerThread.start();  // Start the thread
}

MulticastSender::~MulticastSender() {
    workerThread.quit();
    workerThread.wait();
}

void MulticastSender::startBroadcasting() {
    QMetaObject::invokeMethod(worker, "startBroadcasting", Qt::QueuedConnection);
}

void MulticastSender::stopBroadcasting() {
    QMetaObject::invokeMethod(worker, "stopBroadcasting", Qt::QueuedConnection);
}

