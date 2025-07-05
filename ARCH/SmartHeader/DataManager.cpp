#include "DataManager.h"

DataManager* DataManager::m_instance = nullptr;

DataManager* DataManager::instance() {
    if (!m_instance)
        m_instance = new DataManager();
    return m_instance;
}

DataManager::DataManager(QObject *parent) : QObject(parent), sharedValue("") {}

void DataManager::setSharedValue(const QString &value) {
    if (sharedValue != value) {
        sharedValue = value;
        emit valueChanged(value);  // Notify all connected components
    }
}

QString DataManager::getSharedValue() const {
    return sharedValue;
}
