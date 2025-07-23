#include "formdatahandler.h"

#include <QDebug>

FormDataHandler::FormDataHandler(QObject *parent)
    : QObject(parent) {}

void FormDataHandler::submitForm(const QString &name, const QString &gender, const QString &role) {
    qDebug() << "Form Submitted:";
    qDebug() << "Name:" << name;
    qDebug() << "Gender:" << gender;
    qDebug() << "Role:" << role;
}
