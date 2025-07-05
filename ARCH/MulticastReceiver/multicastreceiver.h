#ifndef MULTICASTRECEIVER_H
#define MULTICASTRECEIVER_H

#include "MulticastReceiver_global.h"
#include <QUdpSocket>
#include <QNetworkDatagram>
#include "iMulticastReceiver.h"
#include <QVariant>
#include <QTimer>
#include <QMap>

class MulticastReceiver : public IMulticastReceiver
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID IMulticastReceiver_iid)
    Q_INTERFACES(IMulticastReceiver)
    Q_PROPERTY(QList<int> part1Data READ part1Data NOTIFY part1DataReceived)
    Q_PROPERTY(QList<int> part2Data READ part2Data NOTIFY part2DataReceived)

public:
    explicit MulticastReceiver(QObject *parent = nullptr);
    ~MulticastReceiver();

    QList<int> part1Data() const { return m_part1Data; }
    QList<int> part2Data() const { return m_part2Data; }

signals:
    void part1DataReceived(const QList<int> &data);
    void part2DataReceived(const QList<int> &data);

private slots:
    void readPendingDatagrams();
    void handleNodeTimeout(int nodeId);

private:
    QUdpSocket udpSocket;
    QString groupAddress;
    QList<int> m_part1Data;
    QList<int> m_part2Data;
    QMap<int, QTimer*> nodeTimers;

    void initializeTimers();
};

#endif // MULTICASTRECEIVER_H
