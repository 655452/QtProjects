#include "KeyManager.h"

KeyManager::KeyManager(QObject *parent) : QObject(parent) {
    loadKeyMappings();  // Load key mappings from XML file
}

KeyManager& KeyManager::instance() {
    static KeyManager instance;
    return instance;
}

QString KeyManager::activeComponent() const {
    return m_activeComponent;
}

void KeyManager::setActiveComponent(const QString &component) {
    if (m_activeComponent != component) {
        m_activeComponent = component;
        emit activeComponentChanged(component);
    }
}

void KeyManager::triggerKeyPressKeyEvents(int key)
{
    emit keyPressedKeyEvents(key);
}
void KeyManager::triggerKeyPress(int key) {
    if (!keyMappings.contains(m_activeComponent)) return;

    auto componentMap = keyMappings[m_activeComponent];

    if (componentMap.contains(key)) {
        QString value = componentMap[key];

        if (value.startsWith("popup")) {
            m_activeComponent = value;  // Set active popup
            emit activeComponentChanged(value);
        } else {
            emit keyPressedMouseEvents(key, value);
        }
    }
}

/*
void KeyManager::triggerKeyPress(int key) {
    // loadKeyMappings();

    qDebug()<<"triggerKeyPress ------------ "<<keyMappings;

    if (keyMappings.contains(m_activeComponent) && keyMappings[m_activeComponent].contains(key)) {
    qDebug()<<"triggerKeyPress ------------ "<<key;
        QString popupName = keyMappings[m_activeComponent][key];
        emit keyPressedMouseEvents(key, popupName);
    }
}

void KeyManager::loadKeyMappings() {
    QString configPath = "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/FunctionKeyPanel.xml";

    QFile file(configPath);  // Update with actual path if necessary
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open key_mappings.xml";
        return;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qWarning() << "Failed to parse XML file";
        file.close();
        return;
    }
    file.close();

    QDomElement root = doc.documentElement();  // <FunctionKeyMap>
    QDomNodeList components = root.elementsByTagName("Component");

    for (int i = 0; i < components.count(); i++) {
        QDomElement componentElem = components.at(i).toElement();
        QString componentName = componentElem.attribute("name");

        if (!componentName.isEmpty()) {
            QMap<int, QString> keyMap;

            QDomNodeList keys = componentElem.elementsByTagName("Key");
            qDebug()<<" while parsing xml  "<<keyMap;
            for (int j = 0; j < keys.count(); j++) {
                QDomElement keyElem = keys.at(j).toElement();
                QString keyName = keyElem.attribute("key");
                QString popupName = keyElem.text();
                qDebug()<<" while parsing xml  "<<keyName;

                if (keyName.startsWith("F")) {
                    int keyCode = Qt::Key_F1 + keyName.mid(1).toInt() - 1;
                    keyMap[keyCode] = popupName;
                }
            }

            keyMappings[componentName] = keyMap;
        }
    }

    qDebug() << "Key mappings loaded successfully!"<<keyMappings ;
}
*/

void KeyManager::loadKeyMappings() {
    QString configPath = "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/FunctionKeyPanelV2.xml";

    QFile file(configPath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open XML file.";
        return;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qDebug() << "Failed to parse XML file.";
        file.close();
        return;
    }
    file.close();

    QDomElement root = doc.documentElement(); // <FunctionKeyMap>

    QDomNodeList components = root.elementsByTagName("Component");
    for (int i = 0; i < components.count(); i++) {
        QDomElement componentElement = components.at(i).toElement();
        QString componentName = componentElement.attribute("name");

        QDomNodeList keys = componentElement.elementsByTagName("Key");
        for (int j = 0; j < keys.count(); j++) {
            QDomElement keyElement = keys.at(j).toElement();
            int keyCode = QKeySequence(keyElement.attribute("key")).toString().toInt();

            QDomNode popupNode = keyElement.firstChild();
            if (!popupNode.isNull() && popupNode.isElement()) {
                QDomElement popupElement = popupNode.toElement();
                if (popupElement.tagName() == "Popup") {
                    keyMappings[componentName][keyCode] = popupElement.attribute("name");
                } else {
                    keyMappings[componentName][keyCode] = popupElement.text();
                }
            }
        }
    }
}
