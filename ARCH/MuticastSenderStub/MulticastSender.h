// #ifndef MULTICASTSENDER_H
// #define MULTICASTSENDER_H

// #include <QObject>
// #include <QUdpSocket>
// #include <QTimer>
// #include <QDebug>

// class MulticastSender : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(QList<int> part1Status READ part1Status NOTIFY part1StatusChanged)
//     Q_PROPERTY(QList<int> part2Status READ part2Status NOTIFY part2StatusChanged)

// public:
//     explicit MulticastSender(QObject *parent = nullptr);
//     ~MulticastSender();

//     Q_INVOKABLE void toggleNode(int part, int index);

//     QList<int> part1Status() const;
//     QList<int> part2Status() const;

// signals:
//     void part1StatusChanged();
//     void part2StatusChanged();

// private:
//     void sendMulticastMessage();

//     QUdpSocket udpSocket;
//     QString groupAddress;
//     QTimer broadcastTimer;
//     QList<int> m_part1Status;
//     QList<int> m_part2Status;
// };

// #endif // MULTICASTSENDER_H
#ifndef MULTICASTSENDER_H
#define MULTICASTSENDER_H

#include <QObject>
#include <QUdpSocket>
#include <QTimer>
#include <QDebug>
#include <QVariantMap>

#include <QFile>
#include <QDomDocument>


struct NodeData {
    QString nodeId;
    QString ApplicationId;
    QString ApplicationOccupiedScreen;
    QString nodeScreen;

    friend QDataStream &operator<<(QDataStream &out, const NodeData &data)
    {
        out << data.nodeId
            << data.ApplicationId
            << data.ApplicationOccupiedScreen
            << data.nodeScreen;
        return out;
    }

    friend QDataStream &operator>>(QDataStream &in, NodeData &data)
    {
        in >> data.nodeId
            >> data.ApplicationId
            >> data.ApplicationOccupiedScreen
            >> data.nodeScreen;
        return in;
    }
};

class MulticastSender : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap part1Status READ part1Status NOTIFY part1StatusChanged)
    Q_PROPERTY(QVariantMap part2Status READ part2Status NOTIFY part2StatusChanged)

public:
    explicit MulticastSender(QObject *parent = nullptr);
    ~MulticastSender();

    void readXmlConfig();
    Q_INVOKABLE void toggleNode(int part, QString nodeId,QString app1,QString app2);

    // Helper to generate a combined key with format "nodeId:app1Id:app2Id"
    QString generateNodeKey(const QString &nodeId, const QString &app1Id, const QString &app2Id);

    QVariantMap part1Status() const { return m_part1Status; }
    QVariantMap part2Status() const { return m_part2Status; }

signals:
    void part1StatusChanged();
    void part2StatusChanged();

private:
    void sendMulticastMessage();

    QUdpSocket udpSocket;
    QString internalGroupAddress;
    QString externalGroupAddress;
    QTimer broadcastTimer;

    QVariantMap m_part1Status;  // ✅ Directly use QVariantMap
    QVariantMap m_part2Status;  // ✅ Directly use QVariantMap
    QString m_part1Data;
      NodeData  nodeData;
};

#endif // MULTICASTSENDER_H
