#ifndef IMULTICASTRECEIVER_H
#define IMULTICASTRECEIVER_H

#include <QObject>
#define IMulticastReceiver_iid "com.example.IMulticastReceiver"

class IMulticastReceiver:public QObject{
    Q_OBJECT
public:
    explicit IMulticastReceiver(QObject *parent =nullptr):QObject(parent){}

    virtual ~IMulticastReceiver(){}
signals:
    virtual void part1DataReceived(const QList<int> &data)=0;
    virtual void part2DataReceived(const QList<int> &data)=0;

};
Q_DECLARE_INTERFACE(IMulticastReceiver, IMulticastReceiver_iid)
#endif // IMULTICASTRECEIVER_H
