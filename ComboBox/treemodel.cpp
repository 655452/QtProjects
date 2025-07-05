
// ---------------------------------------------------------------------------------------
#include "treemodel.h"
#include <QDomDocument>
#include <QFile>
#include <QDebug>

TreeModel::TreeModel(QObject *parent)
    : QAbstractItemModel(parent) {
    rootItem = new TreeItem("Root");
}

TreeModel::~TreeModel() {
    delete rootItem;
}

void TreeModel::addTreeData(const QVariantMap &treeNode) {
    if (!rootItem)
        return;

    beginResetModel();  // Reset for batch change (or use beginInsertRows for finer control)

    addRecursive(treeNode, rootItem);

    endResetModel();
}
void TreeModel::clearAll() {
    beginResetModel();

    // Assuming rootItem is valid and has children
    if (rootItem) {
        rootItem->clearChildren(); // You must implement this in TreeItem
    }
    endResetModel();
}

int TreeModel::resetWithFilter(const QString &classification,
                                const QString &treeCategory,
                                const QString &category,
                               const bool &nominatedItem)
{
    beginResetModel();
    rootItem->clearChildren();
    int count=0;
    for (const QVariantMap &item : std::as_const(allItems)) {
        if (item.value("classification").toString() == classification &&
            item.value("treeCategory").toString() == treeCategory &&
            item.value("category").toString() == category) {

            if(nominatedItem){
                // addRecursive(item, rootItem);
                // count++;
                if(item.value("nominate").toBool()){

                    addRecursive(item, rootItem);
                    count++;
                }
                continue;
            }
            else{

                addRecursive(item, rootItem);
                count++;
            }
        }
    }
 qDebug()<<" root count resetWithFilter ---------------"<<count;

    endResetModel();

 return count;
}

void TreeModel::setAllItems(const QVariantList &items) {
    beginResetModel();
    allItems.clear();
    for (const QVariant &item : items) {
        allItems.append(item.toMap());
    }
    // qDebug()<<" root count ---------------"<< rootItem->childCount() ;

    endResetModel();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid())
        return QVariant();

    TreeItem *item = static_cast<TreeItem *>(index.internalPointer());

    switch (role) {
    case NameRole:
        return item->name();
    case ColorRole:
        return item->color();
    case ParametersRole:
        return item->parameters();  // ← new
    default:
        return QVariant();
    }
}
QHash<int, QByteArray> TreeModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ColorRole] = "color";
    roles[ParametersRole] = "parameters";  // ← new
    return roles;
}
QString TreeModel::resolveColor(const QVariantMap &item) const {
    bool nominate = item.value("nominate").toBool();
    bool promote = item.value("promote").toBool();
    bool adopt   = item.value("adopt").toBool();

    QString ItemColor="gray";
    // Set priority-based color logic here
    if ((nominate && promote && adopt) || (adopt && !promote && !nominate))
        ItemColor="pink";
    else if (nominate)
        ItemColor="yellow";
    else if (nominate&&promote || promote)
        ItemColor="green";

    return ItemColor;
}

void TreeModel::addRecursive(const QVariantMap &node, TreeItem *parentItem) {
    QString name = node.value("name").toString();
    // QString color = node.value("color").toString();
     QString color = resolveColor(node);
    TreeItem *newItem = new TreeItem(name, parentItem, color);

    if (node.contains("parameters")) {
        newItem->setParameters(node.value("parameters").toList());  // ← set parameters
    }
    parentItem->appendChild(newItem);

    if (node.contains("children")) {
        const QVariantList children = node.value("children").toList();
        for (const QVariant &child : children) {
            addRecursive(child.toMap(), newItem);
        }
    }
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const {
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    TreeItem *parentItem = parent.isValid() ? static_cast<TreeItem *>(parent.internalPointer()) : rootItem;
    TreeItem *childItem = parentItem->child(row);
    return childItem ? createIndex(row, column, childItem) : QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex &index) const {
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = static_cast<TreeItem *>(index.internalPointer());
    TreeItem *parentItem = childItem->parentItem();

    if (parentItem == rootItem || !parentItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const {
    TreeItem *parentItem = parent.isValid() ? static_cast<TreeItem *>(parent.internalPointer()) : rootItem;
    return parentItem->childCount();
}

int TreeModel::columnCount(const QModelIndex &parent) const {
    return 1;
}

int  TreeModel::getVisibleItemCount() const {
    // qDebug()<<" root count ---------------"<< rootItem->childCount() ;
    return rootItem ? rootItem->childCount() : 0;
}
