// ChartManager.cpp
#include "ChartManager.h"

ChartManager::ChartManager(QObject *parent)
    : QObject(parent),
    m_minYAxisValue(0),
    m_maxYAxisValue(240),
    m_minXAxisValue(0),
    m_maxXAxisValue(360),
    m_timeStep(50),
    m_currentRangeIndex(0)
{
    m_ranges = QVariantList{
        QVariantMap{{"min", -0.5}, {"max", 15}, {"labels", QVariantList{"", "000", "002", "005", "008", "010", "012", "015"}}},
        QVariantMap{{"min", -1}, {"max", 30}, {"labels", QVariantList{"", "000", "005", "010", "015", "020", "025", "030"}}},
        QVariantMap{{"min", -2}, {"max", 60}, {"labels", QVariantList{"", "000", "010", "020", "030", "040", "050", "060"}}},
        QVariantMap{{"min", -4}, {"max", 120}, {"labels", QVariantList{"", "000", "020", "040", "060", "080", "100", "120"}}},
        QVariantMap{{"min", -8}, {"max", 240}, {"labels", QVariantList{"", "000", "040", "080", "120", "160", "200", "240"}}}
    };
}

int ChartManager::minYAxisValue() const {
    return m_minYAxisValue;
}

void ChartManager::setMinYAxisValue(int value) {
    if (m_minYAxisValue != value) {
        m_minYAxisValue = value;
        emit minYAxisValueChanged();
    }
}

int ChartManager::maxYAxisValue() const {
    return m_maxYAxisValue;
}

void ChartManager::setMaxYAxisValue(int value) {
    if (m_maxYAxisValue != value) {
        m_maxYAxisValue = value;
        emit maxYAxisValueChanged();
    }
}

int ChartManager::minXAxisValue() const {
    return m_minXAxisValue;
}

void ChartManager::setMinXAxisValue(int value) {
    if (m_minXAxisValue != value) {
        m_minXAxisValue = value;
        emit minXAxisValueChanged();
    }
}

int ChartManager::maxXAxisValue() const {
    return m_maxXAxisValue;
}

void ChartManager::setMaxXAxisValue(int value) {
    if (m_maxXAxisValue != value) {
        m_maxXAxisValue = value;
        emit maxXAxisValueChanged();
    }
}

int ChartManager::timeStep() const {
    return m_timeStep;
}

void ChartManager::setTimeStep(int value) {
    if (m_timeStep != value) {
        m_timeStep = value;
        emit timeStepChanged();
    }
}

int ChartManager::currentRangeIndex() const {
    return m_currentRangeIndex;
}

void ChartManager::setCurrentRangeIndex(int index) {
    if (m_currentRangeIndex != index) {
        m_currentRangeIndex = index;
        emit currentRangeIndexChanged();
    }
}

QVariantList ChartManager::ranges() const {
    return m_ranges;
}

void ChartManager::updateYAxisLabels(int currentRangeIndex) {
    // Update the Y-axis min/max and categories based on the selected range
    // This will likely be integrated with QML later
    qDebug() << "Updating Y-axis labels for range index" << currentRangeIndex;
}

QString ChartManager::formatToHoursMinutes(int value) {
    int hours = value / 60;
    int minutes = value % 60;
    return QString("%1:%2").arg(hours).arg(minutes, 2, 10, QChar('0'));
}
