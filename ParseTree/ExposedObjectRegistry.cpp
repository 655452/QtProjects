// ExposedObjectRegistry.cpp
#include "ExposedObjectRegistry.h"
#include <QMetaMethod>
#include <QMetaObject>
#include <QGenericArgument>

ExposedObjectRegistry& ExposedObjectRegistry::instance() {
    static ExposedObjectRegistry instance;
    return instance;
}

ExposedObjectRegistry::ExposedObjectRegistry(QObject* parent)
    : QObject(parent) {}

void ExposedObjectRegistry::registerObject(const QString& name, QObject* object) {
    if (object) {
        objectMap[name] = object;
        qDebug() << "Registered object:" << name;
    }
}

QObject* ExposedObjectRegistry::getObject(const QString& name) const {
    return objectMap.value(name, nullptr);
}

bool ExposedObjectRegistry::invoke(const QString& objectName, const QString& methodName, const QVariantList& args) {
    QObject* obj = getObject(objectName);
    if (!obj) {
        qWarning() << "Object not found:" << objectName;
        return false;
    }

    const QMetaObject* metaObj = obj->metaObject();
    QByteArray methodNameUtf8 = methodName.toUtf8();

    for (int i = 0; i < metaObj->methodCount(); ++i) {
        QMetaMethod method = metaObj->method(i);
        if (method.name() == methodNameUtf8 && method.parameterCount() == args.size()) {
            QGenericArgument genericArgs[10];
            for (int j = 0; j < args.size() && j < 10; ++j) {
                genericArgs[j] = QGenericArgument(args[j].typeName(), args[j].constData());
            }

            bool ok = false;
            switch (args.size()) {
            case 0:
                ok = method.invoke(obj, Qt::DirectConnection);
                break;
            case 1:
                ok = method.invoke(obj, Qt::DirectConnection, genericArgs[0]);
                break;
            case 2:
                ok = method.invoke(obj, Qt::DirectConnection, genericArgs[0], genericArgs[1]);
                break;
            case 3:
                ok = method.invoke(obj, Qt::DirectConnection, genericArgs[0], genericArgs[1], genericArgs[2]);
                break;
            case 4:
                ok = method.invoke(obj, Qt::DirectConnection, genericArgs[0], genericArgs[1], genericArgs[2], genericArgs[3]);
                break;
            default:
                qWarning() << "invoke supports max 4 args.";
                return false;
            }

            if (!ok)
                qWarning() << "Failed to invoke method:" << methodName << "on object:" << objectName;
            return ok;
        }
    }
    qWarning() << "No matching method found for" << methodName << "with" << args.size() << "args.";
    return false;
}
