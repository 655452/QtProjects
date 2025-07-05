
// ActionEventManager.cpp
#include "ActionEventManager.h"
#include <QDebug>

ActionEventManager::ActionEventManager(QObject* parent) : QObject(parent) {}

void ActionEventManager::registerHandler(const QString& action, std::function<void()> handler) {
    simpleHandlers[action] = handler;
    qDebug() << "Simple handler registered for action:" << action;
}

void ActionEventManager::registerHandler(const QString& action, std::function<void(const QString&)> handler) {
    paramHandlers[action] = handler;
    qDebug() << "Parameterized handler registered for action:" << action;
}

void ActionEventManager::activeFunct1()
{
    qDebug()<<" activeFunct 1 called";
}

void ActionEventManager::triggerAction(const QString& action) {
    if (simpleHandlers.contains(action)) {
        qDebug() << "Triggering simple handler for action:" << action;
        simpleHandlers[action]();
        emit actionTriggered(action);
    } else {
        qWarning() << "No simple handler found for action:" << action;
    }
}
// void ActionEventManager::invokeByName(const QString& methodName) {
//     bool ok = QMetaObject::invokeMethod(this, methodName.toUtf8().constData(), Qt::DirectConnection);
//     if (!ok)
//         qWarning() << "Failed to invoke:" << methodName;
// }


void ActionEventManager::invokeByName(const QString& methodName, const QVariantList& args) {
    const QMetaObject* metaObj = this->metaObject();
    QByteArray methodNameUtf8 = methodName.toUtf8();

    for (int i = 0; i < metaObj->methodCount(); ++i) {
        QMetaMethod method = metaObj->method(i);
        if (method.name() == methodNameUtf8 && method.parameterCount() == args.size()) {

            // Convert QVariantList to QGenericArgument
            QGenericArgument genericArgs[10];
            for (int j = 0; j < args.size() && j < 10; ++j) {
                genericArgs[j] = QGenericArgument(args[j].typeName(), args[j].constData());
            }

            bool ok = false;
            switch (args.size()) {
            case 0:
                ok = method.invoke(this, Qt::DirectConnection);
                break;
            case 1:
                ok = method.invoke(this, Qt::DirectConnection, genericArgs[0]);
                break;
            case 2:
                ok = method.invoke(this, Qt::DirectConnection, genericArgs[0], genericArgs[1]);
                break;
            case 3:
                ok = method.invoke(this, Qt::DirectConnection, genericArgs[0], genericArgs[1], genericArgs[2]);
                break;
            case 4:
                ok = method.invoke(this, Qt::DirectConnection, genericArgs[0], genericArgs[1], genericArgs[2], genericArgs[3]);
                break;
            case 5:
                ok = method.invoke(this, Qt::DirectConnection, genericArgs[0], genericArgs[1], genericArgs[2], genericArgs[3], genericArgs[4]);
                break;
            default:
                qWarning() << "invokeByName supports max 5 args.";
                return;
            }

            if (!ok)
                qWarning() << "Failed to invoke" << methodName << "with args:" << args;
            return;
        }
    }

    qWarning() << "No matching method found for" << methodName << "with" << args.size() << "args.";
}


void ActionEventManager::triggerAction(const QString& action, const QString& argument) {
    if (paramHandlers.contains(action)) {
        qDebug() << "Triggering parameterized handler for action:" << action << "with argument:" << argument;
        paramHandlers[action](argument);
        emit actionTriggered(action);
    } else {
        qWarning() << "No parameterized handler found for action:" << action;
    }
}
