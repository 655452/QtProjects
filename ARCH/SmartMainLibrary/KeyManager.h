#ifndef KEYMANAGER_H
#define KEYMANAGER_H

#include <QObject>
#include <QMap>
#include <QString>
#include <QXmlStreamReader>
#include <QFile>
#include <QDebug>
#include <QDomDocument>
#include <QKeySequence>


class KeyManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString activeComponent READ activeComponent WRITE setActiveComponent NOTIFY activeComponentChanged)

public:
    static KeyManager& instance();  // Singleton instance

    QString activeComponent() const;
    void setActiveComponent(const QString &component);

     Q_INVOKABLE void triggerKeyPressKeyEvents(int key);
    Q_INVOKABLE void triggerKeyPress(int key);

signals:
    void keyPressedMouseEvents(int key, QString popupName);
    void keyPressedKeyEvents(int key);
    void activeComponentChanged(QString component);

private:
    explicit KeyManager(QObject *parent = nullptr);
    void loadKeyMappings();  // Load mappings from XML

    QMap<QString, QMap<int, QString>> keyMappings; // { "comp1": {F1: "pop1", F2: "pop2"} }
    QString m_activeComponent;
};

#endif // KEYMANAGER_H
