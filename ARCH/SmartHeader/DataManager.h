#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>

class DataManager : public QObject {
    Q_OBJECT

public:
    static DataManager* instance();  // Singleton instance
    void setSharedValue(const QString &value);
    QString getSharedValue() const;

signals:
    void valueChanged(const QString &newValue);  // Signal when value changes

private:
    explicit DataManager(QObject *parent = nullptr);
    static DataManager* m_instance;
    QString sharedValue;
};

#endif // DATAMANAGER_H
