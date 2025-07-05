
#include <QObject>
#include <QQuickItem>
#include <QQmlEngine>

class globalinterface
{
public:
    virtual ~globalinterface() = default;
    // Method to create and return the main library item
    virtual QQuickItem* createComponent(QQmlEngine* engine) = 0;
};

#define globalinterface_iid "com.example.globalinterface"
Q_DECLARE_INTERFACE(globalinterface, globalinterface_iid)


