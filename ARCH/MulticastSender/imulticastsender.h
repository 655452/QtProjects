#ifndef IMULTICASTSENDER_H
#define IMULTICASTSENDER_H

#include <QObject>

#define IMulticastSender_iid "com.example.IMulticastSender"

class IMulticastSender : public QObject {
    Q_OBJECT
public:
    // Constructor accepting QObject parent
    explicit IMulticastSender(QObject *parent = nullptr) : QObject(parent) {}
    virtual ~IMulticastSender() {}

    virtual void startBroadcasting() = 0;
    virtual void stopBroadcasting() = 0;
};

Q_DECLARE_INTERFACE(IMulticastSender, IMulticastSender_iid)

#endif // IMULTICASTSENDER_H
