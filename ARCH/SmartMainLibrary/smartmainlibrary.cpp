#include "smartmainlibrary.h"
#include <QFile>
#include <QDomDocument>
#include <QDebug>
#include <QQmlContext>
#include <QPluginLoader>

// #include "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/lib/globalinterface.h"

SmartMainLibrary::SmartMainLibrary(QObject *parent) : QObject(parent)
{
      componentManager = new ComponentManager(this);
}

SmartMainLibrary::~SmartMainLibrary()
{
        delete componentManager;
}

QQuickItem* SmartMainLibrary::createMainLibrary(QQmlEngine* engine, QQuickItem* parent) {

    // Load configurations using the ComponentManager
    if (!componentManager->loadComponentConfig("/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/ComponentConfig.xml")) {
        qDebug() << "Failed to load component configuration.";
        return nullptr;
    }
    if (!componentManager->loadLayoutConfig("/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/LayoutConfig.xml")) {
        qDebug() << "Failed to load layout configuration.";
        return nullptr;
    }


    // Create parent rectangle
    QQmlComponent parentComponent(engine, QUrl(QStringLiteral("qrc:/SmartMainLibraryWindow.qml")));
    parentRectangle = qobject_cast<QQuickItem*>(parentComponent.create());
    if (!parentRectangle) {
        qDebug() << "Failed to create parent rectangle.";
        return nullptr;
    }

    if (parent) {
        parentRectangle->setParentItem(parent);
    }

    // Use the ComponentManager to create QQuickItem components
    QHash<QString, QQuickItem*> componentItems = componentManager->createComponentMap(engine);

    // Assign components to zones based on the layout map
    QHash<QString, QString> layoutMap = componentManager->getLayoutMap();
    for (auto it = layoutMap.begin(); it != layoutMap.end(); ++it) {
        QString zone = it.key();         // Zone name (e.g., "zone1")
        QString component = it.value();  // Component name (e.g., "header")

        QQuickItem* item = componentItems.value(component);
        if (item) {
            // Find the zone by objectName
            QQuickItem* zoneItem = parentRectangle->findChild<QQuickItem*>(zone);
            if (!zoneItem) {
                qDebug() << "Zone not found:" << zone;
                continue;
            }

            // Assign the component to the zone
            item->setParentItem(zoneItem);
            // engine->rootContext()->setContextProperty(component.toLower(), item);

            qDebug() << "Assigned component" << component << "to zone" << zone;
        } else {
            qDebug() << "Component item not found for:" << component;
        }
    }
    // Create and register SmartMainLibrary to load dynamically the components
    engine->rootContext()->setContextProperty("KeyManager", &KeyManager::instance());

    engine->rootContext()->setContextProperty("smartMainLibrary", this);
    engine->rootContext()->setContextProperty("qmlEngine", engine);

    return parentRectangle;
}

bool SmartMainLibrary::loadComponentInZone(QQmlEngine* engine, const QString &componentPath, const QString &componentName, const QString &zoneName) {
    if (!parentRectangle) {
        qDebug() << "Parent rectangle not created. Cannot load component.";
        return false;
    }

    // Create the plugin loader on the heap
    QPluginLoader* loader = new QPluginLoader(componentPath);
    QObject* plugin = loader->instance();
    if (!plugin) {
        qDebug() << "Failed to load plugin for component" << componentName << ":" << loader->errorString();
        delete loader;
        return false;
    }
    qDebug() << "QPluginLoader pass";

    // Cast to the plugin interface
    globalinterface* pluginInterface = qobject_cast<globalinterface*>(plugin);
    if (!pluginInterface) {
        qDebug() << "Invalid plugin interface for component:" << componentName;
        delete loader;
        return false;
    }
    qDebug() << "globalinterface pass";

    // Create the QQuickItem from the plugin
    QQuickItem* item = pluginInterface->createComponent(engine);
    if (!item) {
        qDebug() << "Failed to create QQuickItem for component:" << componentName;
        delete loader;
        return false;
    }
    qDebug() << "pluginInterface pass";

    // Find the zone in the parent rectangle
    QQuickItem* zoneItem = parentRectangle->findChild<QQuickItem*>(zoneName);
    if (!zoneItem) {
        qDebug() << "Zone not found:" << zoneName;
        delete item;
        delete loader;
        return false;
    }
    qDebug() << "zoneItem pass";

    // Assign the component to the zone
    item->setParentItem(zoneItem);
    engine->rootContext()->setContextProperty(componentName.toLower(), item);

    // Track the loaded plugin and item
    loadedPlugins.insert(componentName, loader);  // Now storing the heap-allocated loader
    loadedComponentItems.insert(componentName, item);

    qDebug() << "Successfully loaded component" << componentName << "into zone" << zoneName;
    return true;
}

bool SmartMainLibrary::unloadComponentFromZone(QQmlEngine* engine, const QString &componentName, const QString &zoneName) {
    if (!parentRectangle) {
        qDebug() << "Parent rectangle not created. Cannot unload component.";
        return false;
    }

    // Check if the component is loaded
    QQuickItem* item = loadedComponentItems.value(componentName, nullptr);
    if (!item) {
        qDebug() << "Component not found in zone:" << componentName;
        return false;
    }

    // Remove the component item from its parent
    item->setParentItem(nullptr);
    item->deleteLater();

    // Remove the component from the hash
    loadedComponentItems.remove(componentName);

    // Unload the plugin
    QPluginLoader* loader = loadedPlugins.take(componentName);
    if (loader) {
        if (loader->unload()) {
            qDebug() << "Successfully unloaded plugin for component:" << componentName;
        } else {
            qDebug() << "Failed to unload plugin for component:" << componentName;
        }
        delete loader;  // Properly delete the loader
    }

    // Remove the context property
    engine->rootContext()->setContextProperty(componentName.toLower(), nullptr);

    qDebug() << "Successfully unloaded component" << componentName << "from zone" << zoneName;
    return true;
}
// ------------------------------------------------------------------------------------------
void SmartMainLibrary::loadFunctionKeyMapping(const QString &filePath) {
    // poplibPath mapping
    loadPopLibPath();

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open XML file!";
        return;
    }

    QXmlStreamReader xml(&file);
    QString currentComponent;

    while (!xml.atEnd() && !xml.hasError()) {
        xml.readNext();
        if (xml.isStartElement()) {
            if (xml.name() == "Component") {
                currentComponent = xml.attributes().value("name").toString();
            } else if (xml.name() == "Key") {
                if (!currentComponent.isEmpty()) {
                    QKeySequence keySequence(xml.attributes().value("key").toString());
                    int keyCode = keySequence[0]; // Get the first key
                    QString popup = xml.readElementText();
                    functionKeyMapping[currentComponent][keyCode] = popup;
                }
            }
        }
    }

    if (xml.hasError()) {
        qWarning() << "XML Parsing Error: " << xml.errorString();
    }

    file.close();
}

void SmartMainLibrary::loadPopLibPath()
{
    QString configPath = "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/ComponentConfig.xml";
    QFile file(configPath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open component config file:" << configPath;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qDebug() << "Failed to parse component config file:" << configPath;
    }

    QDomElement root = doc.documentElement();
    QDomNodeList componentNodes = root.elementsByTagName("Component");

    for (int i = 0; i < componentNodes.count(); ++i) {
        QDomNode node = componentNodes.item(i);
        QDomElement element = node.toElement();
        if (!element.isNull()) {
            QString name = element.attribute("Name");
            QString path = element.attribute("Path");
            popupLibPathMaping.insert(name, path);
        }
    }
    qDebug() << "Component configuration loaded successfully. "<<popupLibPathMaping;
}

QString SmartMainLibrary::getPopupForKey(const QString &component, int keyCode) {
    return functionKeyMapping.contains(component) && functionKeyMapping[component].contains(keyCode)
    ? functionKeyMapping[component][keyCode]
    : "";
}

QString SmartMainLibrary::getPopupLibPath(const QString &component)
{
    if(popupLibPathMaping.contains(component)){
        return popupLibPathMaping.value(component);
    }else{
          return "";
    }
}
