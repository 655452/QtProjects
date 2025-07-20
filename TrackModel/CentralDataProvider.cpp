
// // centraldataprovider.cpp
// #include "CentralDataProvider.h"

// CentralDataProvider::CentralDataProvider(QObject *parent)
//     : QObject(parent)
// {
//     buildCentralData();
// }

// QVariantMap CentralDataProvider::centralData() const {
//     return m_centralData;
// }

// void CentralDataProvider::buildCentralData() {
//     QVariantList items;

//     QVariantMap item1;
//     item1["name"] = "Item21";
//     item1["color"] = "yellow";
//     item1["category"] = "category1";
//     item1["classification"] = "Land";
//     item1["treeCategory"] = "Home";
//     item1["nominate"] = true;
//     item1["promote"] = false;

//     QVariantList parameters;
//     parameters.append(QVariantMap{{"name", "param1"}, {"value", "0.2"}});
//     parameters.append(QVariantMap{{"name", "param2"}, {"value", "0.1"}});
//     parameters.append(QVariantMap{{"name", "param3"}, {"value", "0.3"}});
//     parameters.append(QVariantMap{{"name", "param4"}, {"value", "0.4"}});
//     item1["parameters"] = parameters;

//     QVariantList children;
//     QVariantMap child;
//     child["name"] = "Item2.1";
//     child["color"] = "gray";
//     child["parameters"] = parameters;
//     children.append(child);

//     item1["children"] = children;
//     items.append(item1);

//     // Add more items here in similar fashion
//     m_centralData["classification"] = QVariantList{"Air", "Land", "Unknown"};
//     m_centralData["Items"] = items;

//     m_centralData["treeCategoryData"] = QVariantList{
//         QVariantMap{
//             {"name", "Home"},
//             {"category", QVariantList{"category1", "category2", "category3"}},
//             {"classification", QVariantList{"Unknown", "Land", "Air"}}
//         },
//         QVariantMap{
//             {"name", "Activity"},
//             {"category", QVariantList{"category3", "category4"}},
//             {"classification", QVariantList{"Unknown", "Land", "Air"}}
//         }
//     };
// }
#include "CentralDataProvider.h"

CentralDataProvider::CentralDataProvider(QObject *parent)
    : QObject(parent)
{
    buildCentralData();
}

QVariantMap CentralDataProvider::centralData() const {
    return m_centralData;
}

void CentralDataProvider::buildCentralData() {
    // Classification List
    m_centralData["classification"] = QVariantList{"Air", "Land", "Unknown"};

    // Items
    QVariantList items;

    // Helper: Parameters List
    auto makeParams = []() -> QVariantList {
        return QVariantList{
            QVariantMap{{"name", "param1"}, {"value", "0.2"}},
            QVariantMap{{"name", "param2"}, {"value", "0.1"}},
            QVariantMap{{"name", "param3"}, {"value", "0.3"}},
            QVariantMap{{"name", "param4"}, {"value", "0.4"}}
        };
    };

    // Helper: Create children
    auto makeChildren = [&makeParams](const QString &baseName) -> QVariantList {
        return QVariantList{
            QVariantMap{{"name", baseName}, {"color", "gray"}, {"parameters", makeParams()}}
        };
    };

    items.append(QVariantMap{{"name", "Item21"}, {"color", "yellow"}, {"category", "category1"},
                             {"classification", "Land"}, {"treeCategory", "Home"},
                             {"nominate", true}, {"promote", false},
                             {"parameters", makeParams()},
                             {"children", makeChildren("Item2.1")}});

    items.append(QVariantMap{{"name", "Item22"}, {"color", "green"}, {"category", "category1"},
                             {"classification", "Land"}, {"treeCategory", "Home"},
                             {"nominate", false}, {"promote", false},
                             {"parameters", makeParams()},
                             {"children", makeChildren("Item2.1")}});

    items.append(QVariantMap{{"name", "Item11"}, {"color", "red"}, {"category", "category2"},
                             {"classification", "Air"}, {"treeCategory", "Home"},
                             {"nominate", true}, {"promote", true},
                             {"parameters", makeParams()},
                             {"children", QVariantList{
                                              QVariantMap{{"name", "Item1.1"}, {"color", "green"}, {"parameters", makeParams()}},
                                              QVariantMap{{"name", "Item1.2"}, {"color", "pink"}, {"parameters", makeParams()}}
                                          }}});

    items.append(QVariantMap{{"name", "Item12"}, {"color", "gray"}, {"category", "category2"},
                             {"classification", "Air"}, {"treeCategory", "Home"},
                             {"nominate", false}, {"promote", true},
                             {"parameters", makeParams()},
                             {"children", QVariantList{
                                              QVariantMap{{"name", "Item1.1"}, {"color", "green"}, {"parameters", makeParams()}},
                                              QVariantMap{{"name", "Item1.2"}, {"color", "pink"}, {"parameters", makeParams()}}
                                          }}});

    items.append(QVariantMap{{"name", "Item2"}, {"color", "yellow"}, {"category", "category3"},
                             {"classification", "Land"}, {"treeCategory", "Home"},
                             {"nominate", true}, {"promote", true}, {"adopt", true},
                             {"parameters", makeParams()},
                             {"children", makeChildren("Item2.1")}});

    items.append(QVariantMap{{"name", "Item3"}, {"color", "yellow"}, {"category", "category3"},
                             {"classification", "Unknown"}, {"treeCategory", "Activity"},
                             {"nominate", false},
                             {"parameters", makeParams()},
                             {"children", makeChildren("Item3.1")}});

    items.append(QVariantMap{{"name", "Item4"}, {"color", "pink"}, {"category", "category3"},
                             {"classification", "Unknown"}, {"treeCategory", "Activity"},
                             {"nominate", false},
                             {"parameters", makeParams()},
                             {"children", makeChildren("Item4.1")}});

    m_centralData["Items"] = items;

    // Tree Category Data
    QVariantList treeCategoryData;

    treeCategoryData.append(QVariantMap{
        {"name", "Home"},
        {"category", QVariantList{"category1", "category2", "category3", "category4", "category5", "category6"}},
        {"classification", QVariantList{"Unknown", "Land", "Air"}}
    });

    treeCategoryData.append(QVariantMap{
        {"name", "Activity"},
        {"category", QVariantList{"category1", "category2", "category3", "category4"}},
        {"classification", QVariantList{"Unknown", "Land", "Air"}}
    });

    m_centralData["treeCategoryData"] = treeCategoryData;

    emit centralDataChanged();
}
