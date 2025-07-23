#ifndef FORMDATAPROVIDER_H
#define FORMDATAPROVIDER_H

#include <QObject>
#include <QStringList>

class FormDataProvider : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList roles READ roles CONSTANT)
    Q_PROPERTY(QStringList genders READ genders CONSTANT)

public:
    explicit FormDataProvider(QObject *parent = nullptr);

    QStringList roles() const;
    QStringList genders() const;
};
#endif // FORMDATAPROVIDER_H
