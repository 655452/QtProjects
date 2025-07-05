#include <QMap>
#include <QVariant>
#include <QDebug>

class ExposedObjectRegistry : public QObject {
    Q_OBJECT
public:
    static ExposedObjectRegistry& instance();

    void registerObject(const QString& name, QObject* object);
    QObject* getObject(const QString& name) const;

    Q_INVOKABLE bool invoke(const QString& objectName, const QString& methodName, const QVariantList& args = {});

private:
    explicit ExposedObjectRegistry(QObject* parent = nullptr);
    Q_DISABLE_COPY(ExposedObjectRegistry)

    QMap<QString, QObject*> objectMap;
};
