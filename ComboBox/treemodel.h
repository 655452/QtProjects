// treemodel.h
#pragma once
#include <QAbstractItemModel>
#include "treeitem.h"
enum TreeRoles {
    NameRole = Qt::UserRole + 1,
    ColorRole,
       ParametersRole   // ← Add this
};
class TreeModel : public QAbstractItemModel {
    Q_OBJECT
public:
    explicit TreeModel(QObject *parent = nullptr);
    ~TreeModel();

    QVariant data(const QModelIndex &index, int role) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &index) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;

    Q_INVOKABLE void addTreeData(const QVariantMap &treeNode);
    void addRecursive(const QVariantMap &node, TreeItem *parentItem);
    Q_INVOKABLE void clearAll();

    // Q_INVOKABLE void resetWithClassification(const QString &classification);
    // Q_INVOKABLE void resetWithClassification(const QString &classification, const QString &treeCategory);
    Q_INVOKABLE int resetWithFilter(const QString &classification, const QString &treeCategory, const QString &category,const bool &nominatedItem);

    QString  resolveColor(const QVariantMap &item) const;
    // QList<QVariant> m_allItems;
    QVector<QVariantMap> allItems;  // Add this in TreeModel class private section

    Q_INVOKABLE void setAllItems(const QVariantList &items); // Add this too
    Q_INVOKABLE int getVisibleItemCount() const;

    QHash<int, QByteArray> roleNames() const override;

private:
    TreeItem *rootItem;
};
