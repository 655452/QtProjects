#include "multicastreceiver.h"

MulticastReceiver::MulticastReceiver(QObject *parent)
    : groupAddress("239.255.255.250"), m_part1Data(QList<int>(9, 0)), m_part2Data(QList<int>(9, 0))
{
    udpSocket.bind(QHostAddress::AnyIPv4, 45454, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    udpSocket.joinMulticastGroup(QHostAddress(groupAddress));
    udpSocket.setSocketOption(QAbstractSocket::MulticastTtlOption, QVariant(5));

    connect(&udpSocket, &QUdpSocket::readyRead, this, &MulticastReceiver::readPendingDatagrams);

    initializeTimers();
}

MulticastReceiver::~MulticastReceiver()
{
    qDeleteAll(nodeTimers);
}

void MulticastReceiver::initializeTimers()
{
    for (int i = 0; i < 9; ++i) {
        QTimer *timer = new QTimer(this);
        timer->setInterval(4000);  // 4-second timeout for each node
        connect(timer, &QTimer::timeout, this, [this, i]() {
            handleNodeTimeout(i);
        });
        nodeTimers[i] = timer;
    }
}

void MulticastReceiver::readPendingDatagrams()
{
    while (udpSocket.hasPendingDatagrams()) {
        QNetworkDatagram datagram = udpSocket.receiveDatagram();
        QByteArray data = datagram.data();
        QDataStream in(&data, QIODevice::ReadOnly);

        int nodeId;
        QList<int> receivedStatusArray;

        in >> nodeId >> receivedStatusArray;

        QHostAddress senderAddress = datagram.senderAddress();
        int receivedTTL = datagram.hopLimit();  // Get the remaining TTL

        qDebug() << "Received from:" << senderAddress.toString();
        qDebug() << "Remaining TTL:" << receivedTTL; // This shows how many hops are left
        qDebug() << "Received Node ID:" << nodeId;


        emit part1DataReceived(m_part1Data);
        emit part2DataReceived(m_part2Data);
        if (nodeId >= 1 && nodeId <= 9) {
            int index = nodeId - 1;
            m_part1Data[index] = 1;
            m_part2Data = receivedStatusArray;

            // Reset the timer for the corresponding node
            nodeTimers[index]->start();

            // Emit updated arrays
            emit part1DataReceived(m_part1Data);
            emit part2DataReceived(m_part2Data);

            qDebug() << "Received Node ID:" << nodeId;
            qDebug() << "Updated Node Status Array:" << m_part2Data;
        }
    }
}

void MulticastReceiver::handleNodeTimeout(int nodeId)
{
    if (nodeId >= 0 && nodeId < 9) {
        m_part1Data[nodeId] = 0;

        emit part1DataReceived(m_part1Data);

        qDebug() << "Timeout reached for Node ID:" << nodeId + 1 << "! Setting index to 0.";
    }
}
