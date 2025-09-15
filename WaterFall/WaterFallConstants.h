#ifndef WATERFALLCONSTANTS_H
#define WATERFALLCONSTANTS_H

#include <QObject>

class WaterFallConstants : public QObject
{
    Q_OBJECT
public:
    explicit WaterFallConstants(QObject *parent = nullptr);
public:
    Q_INVOKABLE inline const int &a(){return m_a;}
    Q_INVOKABLE inline const int &b(){return m_b;}

private:
    const int m_a = 21;
    const int m_b = 42;
signals:
};

#endif // WATERFALLCONSTANTS_H
