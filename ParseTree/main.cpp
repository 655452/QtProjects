// #include <QGuiApplication>
// #include <QQmlApplicationEngine>
// #include <QStack>
// #include <QList>
// #include <QString>
// #include <QStringList>
// #include <QDebug>

// class TreeNode {
// public:
//     QString name;
//     QString action;  // New field
//     QList<TreeNode*> children;

//     TreeNode(const QString& name, const QString& action = "")
//         : name(name), action(action) {}

//     void addChild(TreeNode* child) {
//         children.append(child);
//     }
// };


// class TreeNavigator {
//     TreeNode* root;
//     QStack<TreeNode*> path;

// public:
//     explicit TreeNavigator(TreeNode* root) : root(root) {
//         path.push(root);
//     }

//     bool traverseForward(int index) {
//         TreeNode* current = path.top();
//         if (index >= 0 && index < current->children.size()) {
//             path.push(current->children[index]);
//             return true;
//         }
//         return false;
//     }

//     bool traverseBackward() {
//         if (path.size() > 1) {
//             path.pop();
//             return true;
//         }
//         return false;
//     }

//     QString currentPath() const {
//         QStringList names;
//         for (const TreeNode* node : path)
//             names << node->name;
//         return names.join(" -> ");
//     }
//     TreeNode* currentNode() const {
//         return path.top();
//     }
// };

// TreeNode* buildTree(const QString& name, int currentDepth, int maxDepth) {
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


// void printTree(TreeNode* node, int depth = 0) {
//     QString indent(depth * 2, ' ');
//     qDebug().noquote() << indent + node->name<<" : "<<node->action;

//     for (TreeNode* child : node->children)
//         printTree(child, depth + 1);
// }

// int main(int argc, char *argv[])
// {
//     QGuiApplication app(argc, argv);  // Must come before any Qt object creation

//     int maxDepth = 2;
//     TreeNode* root = buildTree("C1", 0, maxDepth);
//     // TreeNode* root = buildTree();
//     TreeNavigator navigator(root);

//     qDebug() << "======= Tree Structure =======";
//     printTree(root);

//     qDebug() << "\n======= Traversal Example =======";
//     qDebug() << "Start:" << navigator.currentPath();
//     qDebug() << "Action:" << navigator.currentNode()->action;
//      qDebug() << "Action:" << navigator.currentNode()->children[0]->action;

//     navigator.traverseForward(0);  // into F1
//     qDebug() << "Forward to F1:" << navigator.currentPath();
//     qDebug() << "Action:" << navigator.currentNode()->action;

//     navigator.traverseForward(1);  // into F2 under F1
//     qDebug() << "Forward to F2 under F1:" << navigator.currentPath();
//     qDebug() << "Action:" << navigator.currentNode()->action;

//     navigator.traverseBackward();  // back to F1
//     qDebug() << "Backward:" << navigator.currentPath();
//     qDebug() << "Action:" << navigator.currentNode()->action;

//     navigator.traverseBackward();  // back to C1
//     qDebug() << "Back to root:" << navigator.currentPath();
//     qDebug() << "Action:" << navigator.currentNode()->action;

//     QQmlApplicationEngine engine;
//     const QUrl url(QStringLiteral("qrc:/ParseTree/main.qml"));
//     QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                      &app, [url](QObject *obj, const QUrl &objUrl) {
//                          if (!obj && url == objUrl)
//                              QCoreApplication::exit(-1);
//                      }, Qt::QueuedConnection);
//     engine.load(url);

//     return app.exec();
// }


// main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QStack>
#include <QList>
#include <QString>
#include <QStringList>
#include "TreeNavigator.h"
#include"ActionEventManager.h"

// TreeNode* buildTree(const QString& name, int currentDepth, int maxDepth) {
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

#include "main.moc"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    // TreeNode* root = buildTree("C1", 0, 4);
    TreeNavigator* navigator = new TreeNavigator();
ActionEventManager* actionEventManager = new ActionEventManager();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("navigator", navigator);
    engine.rootContext()->setContextProperty("actionEventManager", actionEventManager);

    const QUrl url(QStringLiteral("qrc:/ParseTree/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
