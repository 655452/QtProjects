// #include "MulticastSender.h"

// MulticastSender::MulticastSender(QObject *parent)
//     : QObject(parent), externalGroupAddress("239.255.255.250"),
//     m_part1Status(QList<int>(9, 1)),  // Initialize Part 1 to all ON
//     m_part2Status(QList<int>(9, 1))   // Initialize Part 2 to all ON
// {
//     udpSocket.bind(QHostAddress::AnyIPv4, 45454, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
//     udpSocket.joinMulticastGroup(QHostAddress(externalGroupAddress));

//     connect(&broadcastTimer, &QTimer::timeout, this, &MulticastSender::sendMulticastMessage);
//     if (!broadcastTimer.isActive()) {
//         broadcastTimer.start(2000);
//         qDebug() << "Started broadcasting messages.";
//     }
// }

// MulticastSender::~MulticastSender() {}

// void MulticastSender::toggleNode(int part, int index)
// {
//     if (index < 0 || index >= 9) return;

//     if (part == 1) {
//         m_part1Status[index] = !m_part1Status[index];
//         emit part1StatusChanged();
//     } else if (part == 2) {
//         m_part2Status[index] = !m_part2Status[index];
//         emit part2StatusChanged();
//     }

//     // Send updated status over multicast
//     sendMulticastMessage();
// }

// QList<int> MulticastSender::part1Status() const
// {
//     return m_part1Status;
// }

// QList<int> MulticastSender::part2Status() const
// {
//     return m_part2Status;
// }

// void MulticastSender::sendMulticastMessage()
// {
//     QByteArray datagram;
//     QDataStream out(&datagram, QIODevice::WriteOnly);
//     out << m_part1Status << m_part2Status;
//     qDebug() << "Sent Part 1:" << m_part1Status;
//     qDebug() << "Sent Part 2:" << m_part2Status;
//     udpSocket.writeDatagram(datagram, QHostAddress(externalGroupAddress), 45454);
// }


#include "MulticastSender.h"

MulticastSender::MulticastSender(QObject *parent)
    : QObject(parent)
{
    readXmlConfig();
    udpSocket.bind(QHostAddress::AnyIPv4, 45454, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    udpSocket.joinMulticastGroup(QHostAddress(externalGroupAddress));
    udpSocket.setSocketOption(QAbstractSocket::MulticastTtlOption, QVariant(5));

    // Initialize with unique string IDs
    for (int i = 1; i <= 9; ++i) {
        QString nodeId = QString("Node%1").arg(i);
        m_part1Status.insert(nodeId, true);
        m_part2Status.insert(nodeId, true);
    }

    connect(&broadcastTimer, &QTimer::timeout, this, &MulticastSender::sendMulticastMessage);
    if (!broadcastTimer.isActive()) {
        broadcastTimer.start(2000);
        qDebug() << "Started broadcasting messages.";
    }
}

MulticastSender::~MulticastSender() {}

void MulticastSender::readXmlConfig()
{
    QFile file("/home/asit/Documents/AsitEmpire/ARCH/MuticastSenderStub/node_config.xml");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << " Cannot open XML configuration file.";
        return;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qWarning() << " Failed to parse XML.";
        file.close();
        return;
    }
    file.close();

    // ✅ Read the root <Node> element (only one specific node)
    QDomElement nodeElement = doc.documentElement();

    if (nodeElement.tagName() != "Node") {
        qWarning() << "Invalid XML format! Expected <Node> as root.";
        return;
    }

    // ✅ Extract values
    QString nodeId = nodeElement.attribute("Id");
    QString internalAddress = nodeElement.firstChildElement("internalGroupAddress").text();
    QString externalAddress = nodeElement.firstChildElement("externalGroupAddress").text();


    // ✅ Store in class variables
       nodeData.nodeId=nodeId;
    // this->nodeId = nodeId;
    this->internalGroupAddress = internalAddress;
    this->externalGroupAddress = externalAddress;

    qDebug() << "✅ Loaded Node Configuration:";
    qDebug() << "Node ID:" << nodeId;
    qDebug() << "Internal Group Address:" << internalAddress;
    qDebug() << "External Group Address:" << externalAddress;
}

void MulticastSender::toggleNode(int part, QString nodeId,QString app1,QString app2)
{
    if (nodeId.isEmpty()) return;

    if (part == 1) {
        m_part1Data=generateNodeKey(nodeId,app1,app2);
        if (m_part1Status.contains(nodeId)) {
            m_part1Status[nodeId] = !m_part1Status[nodeId].toBool(); // ✅ Toggle directly
        } else {
            m_part1Status.insert(nodeId, true);
        }
        qDebug()<<"mpart1Data status ------------------"<<m_part1Data;
        emit part1StatusChanged();
    }
    else if (part == 2) {
        if (m_part2Status.contains(nodeId)) {
            m_part2Status[nodeId] = !m_part2Status[nodeId].toBool();  // ✅ Toggle directly
        } else {
            m_part2Status.insert(nodeId, true);
        }
        emit part2StatusChanged();
    }

    sendMulticastMessage();
}

QString MulticastSender::generateNodeKey(const QString &nodeId, const QString &app1Id, const QString &app2Id)
{
    return QString("%1:%2:%3").arg(nodeId, app1Id, app2Id);
}


void MulticastSender::sendMulticastMessage()
{
    QByteArray datagram;
    QDataStream out(&datagram, QIODevice::WriteOnly);

    // nodeData.nodeId="22";
    nodeData.ApplicationId="145";
    nodeData.ApplicationOccupiedScreen="1";
    nodeData.nodeScreen="0";

    out << m_part1Data << m_part2Status << nodeData;  // ✅ Directly serialize QVariantMap
    // qDebug() << "Sent Part 1:" << m_part1Status;
    // qDebug() << "Sent Part 2:" << m_part2Status;
    udpSocket.writeDatagram(datagram, QHostAddress(externalGroupAddress), 45454);
}

