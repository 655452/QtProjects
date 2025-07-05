#include "smartmainlibrary.h"
#include <QFile>
#include <QDomDocument>
#include <QDebug>
#include "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartMainLibrary/lib/globalinterface.h"

SmartMainLibrary::SmartMainLibrary(QObject *parent) : QObject(parent)
{
}

SmartMainLibrary::~SmartMainLibrary()
{
}

bool SmartMainLibrary::loadConfig(const QString &configPath, QStringList &componentPaths)
{
    QFile file(configPath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open config file:" << configPath;
        return false;
    }

    QDomDocument doc;
    if (!doc.setContent(&file)) {
        qDebug() << "Failed to parse config file:" << configPath;
        return false;
    }

    QDomElement root = doc.documentElement();
    QDomNodeList componentNodes = root.elementsByTagName("Component");

    componentList.clear();
    for (int i = 0; i < componentNodes.count(); ++i) {
        QDomNode node = componentNodes.item(i);
        QDomElement element = node.toElement();
        if (!element.isNull()) {
            QString name = element.attribute("Name");
            QString path = element.attribute("Path");
            componentList.append(qMakePair(name, path));
            componentPaths.append(path);  // Optionally add the path to the provided list
        }
    }

    return true;
}

QQuickItem* SmartMainLibrary::createMainLibrary(QQmlEngine* engine, QQuickItem* parent)
{
    QStringList componentPaths;
    if (!loadConfig("/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartMainLibrary/ComponentConfig.xml", componentPaths)) {
        qDebug() << "Failed to load config.";
        return nullptr;
    }

    // Dynamically load components from the XML configuration
    QList<QObject*> loadedPlugins;
    QHash<QString, globalinterface*> interfaceMap;

    for (const auto& component : componentList) {
        const QString &name = component.first;
        const QString &path = component.second;

        // Load the plugin
        QPluginLoader loader(path);
        QObject *plugin = loader.instance();

        if (!plugin) {
            qDebug() << "Failed to load plugin for component" << name << ":" << loader.errorString();
            continue;
        }

        loadedPlugins.append(plugin);
        qDebug() << "Loaded plugin for component:" << name;

        // Retrieve the interface
        globalinterface *pluginInterface = qobject_cast<globalinterface*>(plugin);
        if (pluginInterface) {
            interfaceMap.insert(name, pluginInterface);
        } else {
            qDebug() << "Failed to cast plugin to globalinterface for component:" << name;
        }
    }

    // Create QQuickItems for each component
    QHash<QString, QQuickItem*> createdItems;

    for (auto it = interfaceMap.begin(); it != interfaceMap.end(); ++it) {
        const QString &name = it.key();
        globalinterface *pluginInterface = it.value();

        // Create the QQuickItem for this component
        QQuickItem *childItem = pluginInterface->createComponent(engine);
        if (childItem) {
            createdItems.insert(name, childItem);
            engine->rootContext()->setContextProperty(name.toLower(), childItem);
            qDebug() << "Created QQuickItem for component:" << name;
        } else {
            qDebug() << "Failed to create QQuickItem for component:" << name;
        }

        // Add components in the QVariants for exposing it in QML
        components.append(name.toLower());
    }
    engine->rootContext()->setContextProperty("components", components);
    // Create the main screen parent rectangle from QML
    QQmlComponent parentComponent(engine, QUrl(QStringLiteral("qrc:/SmartMainLibraryWindow.qml")));
    if (parentComponent.status() == QQmlComponent::Error) {
        qDebug() << "Error creating parent QML Component:" << parentComponent.errorString();
        return nullptr;
    }

    QQuickItem* parentRectangle = qobject_cast<QQuickItem*>(parentComponent.create());
    if (!parentRectangle) {
        qDebug() << "Failed to create parent rectangle.";
        return nullptr;
    }

    if (parent) {
        parentRectangle->setParentItem(parent);
    }

    // Now, we could dynamically arrange or position the components based on the layout or other logic
    // For now, the components are just added to the engine context

    if (createdItems.size() > 0) {
        qDebug() << "All components added successfully.";
    } else {
        qDebug() << "No components added.";
    }

    return parentRectangle;
}

/*


QQuickItem* SmartMainLibrary::createMainLibrary(QQmlEngine* engine, QQuickItem* parent)
{
    QString MainScreenLibraryPath = "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartMainScreen/lib/libSmartMainScreen.so";
    QString HeaderLibraryPath = "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartHeader/lib/libSmartHeader.so";
    QString FooterLibraryPath = "/home/wesee/WORKSPACE/SystemArbitrator/SystemArbitratorApp/SmartFooter/lib/libSmartFooter.so";


    QPluginLoader mainScreenLoader(MainScreenLibraryPath);
    QObject* mainScreenPlugin = mainScreenLoader.instance();

    QPluginLoader headerLoader(HeaderLibraryPath);
    QObject* headerPlugin = headerLoader.instance();

    QPluginLoader footerLoader(FooterLibraryPath);
    QObject* footerPlugin = footerLoader.instance();



    if (!mainScreenPlugin) {
        qDebug() << "Failed to load SmartMainScreen plugin:" << mainScreenLoader.errorString();
        return nullptr;
    }
    qDebug() << "SmartMainScreen plugin loaded successfully.";

    if (!headerPlugin) {
        qDebug() << "Failed to load SmartHeader plugin:" << headerLoader.errorString();
        return nullptr;
    }
    qDebug() << "SmartHeader plugin loaded successfully.";

    if (!footerPlugin) {
        qDebug() << "Failed to load SmartFooter plugin:" << footerLoader.errorString();
        return nullptr;
    }
    qDebug() << "SmartFooter plugin loaded successfully.";


    // Cast the plugins to their respective interfaces
    globalinterface* mainScreenInterface = qobject_cast<globalinterface*>(mainScreenPlugin);
    if (!mainScreenInterface) {
        qDebug() << "The plugin does not implement IMainScreenInterface.";
        return nullptr;
    }

    globalinterface* headerInterface = qobject_cast<globalinterface*>(headerPlugin);
    if (!headerInterface) {
        qDebug() << "The plugin does not implement IHeaderInterface.";
        return nullptr;
    }

    globalinterface* footerInterface = qobject_cast<globalinterface*>(footerPlugin);
    if (!footerInterface) {
        qDebug() << "The plugin does not implement IFooterInterface.";
        return nullptr;
    }

    // engine->rootContext()->setContextProperty("sharedDataModel", sharedDataModel);

    qDebug() << "Shared data model retrieved successfully.";

    // ----------------------------------------------------------------------------------------------------


    QQuickItem* childMainScreen = mainScreenInterface->createComponent(engine);
    QQuickItem* childHeader = headerInterface->createComponent(engine);
    QQuickItem* childFooter = footerInterface->createComponent(engine);

    engine->rootContext()->setContextProperty("childMainScreen", childMainScreen);
    engine->rootContext()->setContextProperty("childHeader", childHeader);
    engine->rootContext()->setContextProperty("childFooter", childFooter);

    // -------------------------------------------------------------------------------------------------------



    // Create the main screen parent rectangle
    QQmlComponent parentComponent(engine, QUrl(QStringLiteral("qrc:/SmartMainLibraryWindow.qml")));
    if (parentComponent.status() == QQmlComponent::Error) {
        qDebug() << "Error creating parent QML Component:" << parentComponent.errorString();
        return nullptr;
    }

    QQuickItem* parentRectangle = qobject_cast<QQuickItem*>(parentComponent.create());
    if (!parentRectangle) {
        qDebug() << "Failed to create parent rectangle.";
        return nullptr;
    }

    if (parent) {
        parentRectangle->setParentItem(parent);
    }

    if (childMainScreen && childHeader && childFooter) {
        qDebug() << "All components added successfully.";
    } else {
        qDebug() << "Failed to add components.";
    }

    return parentRectangle;
}

*/

