// ActionEventManager.h
#pragma once

#include <QObject>
#include <QString>
#include <QMap>
#include <functional>
#include <QMetaMethod>
#include <QMetaObject>
#include <QVariant>
class ActionEventManager : public QObject {
    Q_OBJECT

public:
    explicit ActionEventManager(QObject* parent = nullptr);

    void registerHandler(const QString& action, std::function<void()> handler);
    void registerHandler(const QString& action, std::function<void(const QString&)> handler);

    Q_INVOKABLE void activeFunct1();
    Q_INVOKABLE void triggerAction(const QString& action);
    Q_INVOKABLE void triggerAction(const QString& action, const QString& argument);

    // Q_INVOKABLE void invokeByName(const QString& methodName);
    Q_INVOKABLE void invokeByName(const QString& methodName, const QVariantList& args = {});


signals:
    void actionTriggered(const QString& action);

private:
    QMap<QString, std::function<void()>> simpleHandlers;
    QMap<QString, std::function<void(const QString&)>> paramHandlers;
};
