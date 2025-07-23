#include "formdataprovider.h"

FormDataProvider::FormDataProvider(QObject *parent) : QObject(parent) {}

QStringList FormDataProvider::roles() const {
    return {"Admin", "User", "Guest"};
}

QStringList FormDataProvider::genders() const {
    return {"Male", "Female"};
}
