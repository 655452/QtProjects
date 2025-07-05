// treeitem.h
#pragma once
#include <QVariant>
#include <QVector>

class TreeItem {
public:
    // explicit TreeItem(const QVariant &data, TreeItem *parent = nullptr);
    explicit TreeItem(const QString &data, TreeItem *parent = nullptr, const QString &color = "gray");

    ~TreeItem();


    void appendChild(TreeItem *child);
    TreeItem *child(int row);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    int row() const;
    TreeItem *parentItem();
    QString color() const;  // <- New getter QString m_color;
 QString name() const;
 void clearChildren();

    void setParameters(const QVariantList &params);
    QVariantList parameters() const;
private:
    QVector<TreeItem *> m_childItems;
    QVariant m_itemData;
    TreeItem *m_parentItem;
    QString m_color;
     QString m_name;
    QVariantList m_parameters;  // ← Add this

};
