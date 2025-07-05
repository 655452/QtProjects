// #pragma once

// #include <QObject>
// #include <QStack>
// #include <QList>
// #include <QString>
// #include <QStringList>
// #include <QVariantMap>

// class TreeNode {
// public:
//     QString name;
//     QString action;
//     QList<TreeNode*> children;

//     TreeNode(const QString& name, const QString& action = "")
//         : name(name), action(action) {}

//     void addChild(TreeNode* child) {
//         children.append(child);
//     }
// };

// class TreeNavigator : public QObject {
//     Q_OBJECT
//     Q_PROPERTY(QStringList currentChildren READ currentChildren NOTIFY currentNodeChanged)
//     Q_PROPERTY(QString currentAction READ currentAction NOTIFY currentNodeChanged)
//     Q_PROPERTY(QVariantMap activeKeyData READ activeKeyData NOTIFY currentNodeChanged)

// public:
//     explicit TreeNavigator(TreeNode* root, QObject* parent = nullptr);

//     Q_INVOKABLE bool traverseForward(int index);
//     Q_INVOKABLE bool traverseBackward();

//     QStringList currentChildren() const;
//     QString currentAction() const;
//     QVariantMap activeKeyData() const;

// signals:
//     void currentNodeChanged();

// private:
//     TreeNode* root;
//     QStack<TreeNode*> path;
// };

// TreeNavigator.h

// -------------------------------------------------------------------
// #pragma once

// #include <QObject>
// #include <QString>
// #include <QStack>
// #include <QList>
// #include <QStringList>
// #include <QVariantMap>
// #include <QMap>
// #include <QDomDocument>
// #include <QFile>
// class TreeNode {
// public:
//     QString name;
//     QString action;
//     QList<TreeNode*> children;

//     TreeNode(const QString& name, const QString& action = "")
//         : name(name), action(action) {}

//     void addChild(TreeNode* child) {
//         children.append(child);
//     }
// };

// class TreeNavigator : public QObject {
//     Q_OBJECT
//     Q_PROPERTY(QStringList currentChildren READ currentChildren NOTIFY currentNodeChanged)
//     Q_PROPERTY(QString currentAction READ currentAction NOTIFY currentNodeChanged)
//     Q_PROPERTY(QVariantMap activeKeyData READ activeKeyData NOTIFY currentNodeChanged)

// public:
//     explicit TreeNavigator(QObject* parent = nullptr);

//     Q_INVOKABLE bool traverseForward(int index);
//     Q_INVOKABLE bool traverseBackward();
//     Q_INVOKABLE void setComponent(const QString& component);

//     QStringList currentChildren() const;
//     QString currentAction() const;
//     QVariantMap activeKeyData() const;


//     void loadKeyMappings();
//     void parseDepthTree(QDomNodeList nodes,QString indentation);

// signals:
//     void currentNodeChanged();

// private:
//     TreeNode* buildTree(const QString& name, int currentDepth, int maxDepth);

//     QMap<QString, TreeNode*> componentTrees;
//     QStack<TreeNode*> path;
// };

// -----------------------------------------------------------------
// TreeNavigator.h
// TreeNavigator.h
#pragma once

#include <QObject>
#include <QString>
#include <QStack>
#include <QList>
#include <QStringList>
#include <QVariantMap>
#include <QMap>
#include <QDomDocument>
#include <QFile>

class TreeNode {
public:
    QString name;
    QString action;
    QList<TreeNode*> children;

    TreeNode(const QString& name, const QString& action = "")
        : name(name), action(action) {}

    void addChild(TreeNode* child) {
        children.append(child);
    }
};

class TreeNavigator : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList currentChildren READ currentChildren NOTIFY currentNodeChanged)
    Q_PROPERTY(QString currentAction READ currentAction NOTIFY currentNodeChanged)
     Q_PROPERTY(QString currentKey READ currentKey NOTIFY currentNodeChanged)
    Q_PROPERTY(QVariantMap activeKeyData READ activeKeyData NOTIFY currentNodeChanged)

public:
    explicit TreeNavigator(QObject* parent = nullptr);

    Q_INVOKABLE bool traverseForward(int index);
    Q_INVOKABLE bool traverseBackward();
    Q_INVOKABLE void setComponent(const QString& component);

    QStringList currentChildren() const;
    QString currentAction() const;
     QString currentKey() const;
    QVariantMap activeKeyData() const;

signals:
    void currentNodeChanged();

private:
    void loadKeyMappings();
    TreeNode* parseNode(const QDomElement& element);

    QString overrideKey;
    QMap<QString, TreeNode*> componentTrees;
    QStack<TreeNode*> path;
};
