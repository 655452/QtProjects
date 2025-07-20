// treeitem.cpp
#include "treeitem.h"

// TreeItem::TreeItem(const QVariant &data, TreeItem *parent)
//     : m_itemData(data), m_parentItem(parent) {}

TreeItem::TreeItem(const QString &data, TreeItem *parent, const QString &color)
    : m_name(data), m_color(color), m_parentItem(parent) {}

QString TreeItem::color() const {
    return m_color;
}
void TreeItem::clearChildren() {
    for (TreeItem *child : qAsConst(m_childItems)) {
        delete child;
    }
    m_childItems.clear();
}

QString TreeItem::name() const {
    return m_name;
}
TreeItem::~TreeItem() {
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *child) {
    m_childItems.append(child);
}

TreeItem *TreeItem::child(int row) {
    return m_childItems.value(row);
}

int TreeItem::childCount() const {
    return m_childItems.count();
}

int TreeItem::columnCount() const {
    return 1;
}

QVariant TreeItem::data(int column) const {
    return column == 0 ? m_name : QVariant();
}

int TreeItem::row() const {
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem *>(this));
    return 0;
}

TreeItem *TreeItem::parentItem() {
    return m_parentItem;
}

void TreeItem::setParameters(const QVariantList &params) {
    m_parameters = params;
}

QVariantList TreeItem::parameters() const {
    return m_parameters;
}
