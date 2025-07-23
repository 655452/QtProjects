#ifndef FORMDATAHANDLER_H
#define FORMDATAHANDLER_H

#include <QObject>

class FormDataHandler : public QObject {
    Q_OBJECT
public:
    explicit FormDataHandler(QObject *parent = nullptr);

    Q_INVOKABLE void submitForm(const QString &name, const QString &gender, const QString &role);
};


#endif // FORMDATAHANDLER_H
