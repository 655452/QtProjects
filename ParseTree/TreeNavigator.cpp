// #include "TreeNavigator.h"

// TreeNavigator::TreeNavigator(TreeNode* root, QObject* parent)
//     : QObject(parent), root(root) {
//     path.push(root);
// }

// bool TreeNavigator::traverseForward(int index) {
//     TreeNode* current = path.top();
//     if (index >= 0 && index < current->children.size()) {
//         path.push(current->children[index]);
//         emit currentNodeChanged();
//         return true;
//     }
//     return false;
// }

// bool TreeNavigator::traverseBackward() {
//     if (path.size() > 1) {
//         path.pop();
//         emit currentNodeChanged();
//         return true;
//     }
//     return false;
// }

// QStringList TreeNavigator::currentChildren() const {
//     QStringList list;
//     TreeNode* current = path.top();
//     for (TreeNode* child : current->children)
//         list << child->name;
//     return list;
// }

// QString TreeNavigator::currentAction() const {
//     return path.top()->action;
// }

// QVariantMap TreeNavigator::activeKeyData() const {
//     QVariantMap map;
//     TreeNode* current = path.top();
//     for (TreeNode* child : current->children)
//         map[child->name] = child->action;
//     return map;
// }



// TreeNavigator.cpp

// ------------------------------------------------------------------------
// #include "TreeNavigator.h"

// TreeNavigator::TreeNavigator(QObject* parent)
//     : QObject(parent) {
//     componentTrees["C1"] = buildTree("C1", 0, 3);
//     componentTrees["C2"] = buildTree("C2", 0, 3);
//     componentTrees["C3"] = buildTree("C3", 0, 3);
//     componentTrees["C4"] = buildTree("C4", 0, 3);
//     setComponent("C1");
//     loadKeyMappings();

// }

// TreeNode* TreeNavigator::buildTree(const QString& name, int currentDepth, int maxDepth) {
//     QString action = QString("Action for %1 at depth %2").arg(name).arg(currentDepth);
//     TreeNode* node = new TreeNode(name, action);

//     if (currentDepth < maxDepth) {
//         for (int i = 1; i <= 9; ++i) {
//             QString childName = QString("F%1").arg(i);
//             TreeNode* child = buildTree(childName, currentDepth + 1, maxDepth);
//             node->addChild(child);
//         }
//     }
//     return node;
// }

// bool TreeNavigator::traverseForward(int index) {
//     TreeNode* current = path.top();
//     if (index >= 0 && index < current->children.size()) {
//         path.push(current->children[index]);
//         emit currentNodeChanged();
//         return true;
//     }
//     return false;
// }

// bool TreeNavigator::traverseBackward() {
//     if (path.size() > 1) {
//         path.pop();
//         emit currentNodeChanged();
//         return true;
//     }
//     return false;
// }

// void TreeNavigator::setComponent(const QString& component) {
//     if (componentTrees.contains(component)) {
//         path.clear();
//         path.push(componentTrees[component]);
//         emit currentNodeChanged();
//     }
// }

// QStringList TreeNavigator::currentChildren() const {
//     QStringList list;
//     TreeNode* current = path.top();
//     for (TreeNode* child : current->children)
//         list << child->name;
//     return list;
// }

// QString TreeNavigator::currentAction() const {
//     return path.top()->action;
// }

// QVariantMap TreeNavigator::activeKeyData() const {
//     QVariantMap map;
//     TreeNode* current = path.top();
//     for (TreeNode* child : current->children)
//         map[child->name] = child->action;
//     return map;
// }

// void TreeNavigator::parseDepthTree(QDomNodeList nodes,QString indentation){

//     if(nodes.isEmpty()){

//     }else{
//         for (int count = 0; count < nodes.count(); ++count) {
//             QDomElement keyElement = nodes.at(count).toElement();
//             QString functionKey = keyElement.attribute("key");
//             QString actions =keyElement.attribute("action");
//             qDebug()<<indentation+" key "<<functionKey<<" action "<<actions;
//             parseDepthTree(keyElement.childNodes(),"-------"+indentation);
//         }
//     }
// }
// void TreeNavigator::loadKeyMappings() {
//     QString configPath = "/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/FunctionKeyPanelV2.xml";
//     QFile file(configPath);

//     if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//         qDebug() << "Failed to open XML file.";
//         return;
//     }

//     QDomDocument doc;
//     if (!doc.setContent(&file)) {
//         qDebug() << "Failed to parse XML file.";
//         file.close();
//         return;
//     }
//     file.close();

//     QDomElement root = doc.documentElement(); // <FunctionKeyMap>
//     QDomNodeList componentNodes = root.elementsByTagName("Component");

//     for (int i = 0; i < componentNodes.count(); ++i) {
//         QDomElement componentElement = componentNodes.at(i).toElement();
//         QString componentName = componentElement.attribute("name");
//         qDebug()<<" component name"<<componentName;
//         parseDepthTree(componentElement.childNodes(),"----");
//     }
// }

// ------------------------------------------------------------------------------------------


// TreeNavigator.cpp

// TreeNavigator.cpp
#include "TreeNavigator.h"
#include <QDebug>

TreeNavigator::TreeNavigator(QObject* parent)
    : QObject(parent) {
    loadKeyMappings();
    if (!componentTrees.isEmpty()) {
        setComponent(componentTrees.firstKey());
    }
}

TreeNode* TreeNavigator::parseNode(const QDomElement& element) {
    if (!element.hasAttribute("key")) return nullptr;

    QString name = element.attribute("key");
    QString action = element.attribute("action");
    TreeNode* node = new TreeNode(name, action);

    QDomNodeList children = element.childNodes();
    for (int i = 0; i < children.count(); ++i) {
        QDomElement childElem = children.at(i).toElement();
        if (!childElem.isNull() && childElem.hasAttribute("key")) {
            TreeNode* childNode = parseNode(childElem);
            if (childNode) node->addChild(childNode);
        }
    }
    return node;
}

void TreeNavigator::loadKeyMappings() {
    QString configPath = "/home/asit/ParseTree/FunctionKeyPanelV2.xml";
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

    QDomElement root = doc.documentElement();
    QDomNodeList componentNodes = root.elementsByTagName("Component");

    for (int i = 0; i < componentNodes.count(); ++i) {
        QDomElement componentElement = componentNodes.at(i).toElement();
        QString componentName = componentElement.attribute("name");

        TreeNode* rootNode = new TreeNode(componentName);
        QDomNodeList keyNodes = componentElement.childNodes();
        for (int j = 0; j < keyNodes.count(); ++j) {
            QDomElement keyElement = keyNodes.at(j).toElement();
            if (!keyElement.isNull() && keyElement.hasAttribute("key")) {
                TreeNode* keyNode = parseNode(keyElement);
                if (keyNode) rootNode->addChild(keyNode);
            }
        }
        componentTrees[componentName] = rootNode;
    }
}

bool TreeNavigator::traverseForward(int index) {
    if (path.isEmpty()) return false;
    TreeNode* current = path.top();

    if (index >= 0 && index < current->children.size()) {
        TreeNode* target = current->children[index];

        if (!target->children.isEmpty()) {
            overrideKey.clear();  // clear override if traversing
            path.push(target);
            emit currentNodeChanged();
            return true;
        } else {
            overrideKey = target->name;  // only set override
            emit currentNodeChanged();   // still emit to update QML/UI
            qDebug() << "Reached leaf node:" << target->name;
            return false;  // not pushed to path
        }
    }

    return false;
}


bool TreeNavigator::traverseBackward() {
    if (path.size() > 1) {
        path.pop();
        overrideKey.clear();
        emit currentNodeChanged();
        return true;
    }
    return false;
}

void TreeNavigator::setComponent(const QString& component) {
    if (componentTrees.contains(component)) {
        path.clear();
        overrideKey.clear();
        path.push(componentTrees[component]);
        emit currentNodeChanged();
    } else {
        qDebug() << "Component not found:" << component;
    }
}

QStringList TreeNavigator::currentChildren() const {
    QStringList list;
    if (path.isEmpty()) return list;
    TreeNode* current = path.top();
    for (TreeNode* child : current->children)
        list << child->name;
    return list;
}

QString TreeNavigator::currentAction() const {
    return path.isEmpty() ? QString() : path.top()->action;
}

QString TreeNavigator::currentKey() const {
    if (!overrideKey.isEmpty()) return overrideKey;
    return path.isEmpty() ? QString() : path.top()->name;
}


QVariantMap TreeNavigator::activeKeyData() const {
    QVariantMap map;
    if (path.isEmpty()) return map;
    TreeNode* current = path.top();
    for (TreeNode* child : current->children)
        map[child->name] = child->action;
    return map;
}
