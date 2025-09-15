// ChartManager.h
#ifndef CHARTMANAGER_H
#define CHARTMANAGER_H

#include <QObject>
#include <QVariantList>

class ChartManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int minYAxisValue READ minYAxisValue WRITE setMinYAxisValue NOTIFY minYAxisValueChanged)
    Q_PROPERTY(int maxYAxisValue READ maxYAxisValue WRITE setMaxYAxisValue NOTIFY maxYAxisValueChanged)
    Q_PROPERTY(int minXAxisValue READ minXAxisValue WRITE setMinXAxisValue NOTIFY minXAxisValueChanged)
    Q_PROPERTY(int maxXAxisValue READ maxXAxisValue WRITE setMaxXAxisValue NOTIFY maxXAxisValueChanged)
    Q_PROPERTY(int timeStep READ timeStep WRITE setTimeStep NOTIFY timeStepChanged)
    Q_PROPERTY(int currentRangeIndex READ currentRangeIndex WRITE setCurrentRangeIndex NOTIFY currentRangeIndexChanged)
    Q_PROPERTY(QVariantList ranges READ ranges NOTIFY rangesChanged)

public:
    explicit ChartManager(QObject *parent = nullptr);

    // Properties
    int minYAxisValue() const;
    void setMinYAxisValue(int value);

    int maxYAxisValue() const;
    void setMaxYAxisValue(int value);

    int minXAxisValue() const;
    void setMinXAxisValue(int value);

    int maxXAxisValue() const;
    void setMaxXAxisValue(int value);

    int timeStep() const;
    void setTimeStep(int value);

    int currentRangeIndex() const;
    void setCurrentRangeIndex(int index);

    QVariantList ranges() const;

    // Methods
    void updateYAxisLabels(int currentRangeIndex);
    QString formatToHoursMinutes(int value);

signals:
    void minYAxisValueChanged();
    void maxYAxisValueChanged();
    void minXAxisValueChanged();
    void maxXAxisValueChanged();
    void timeStepChanged();
    void currentRangeIndexChanged();
    void rangesChanged();

private:
    int m_minYAxisValue;
    int m_maxYAxisValue;
    int m_minXAxisValue;
    int m_maxXAxisValue;
    int m_timeStep;
    int m_currentRangeIndex;
    QVariantList m_ranges;
};

#endif // CHARTMANAGER_H
