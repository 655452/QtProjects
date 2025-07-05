// TreeItem.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: treeItem
    width: parent.width/2
    property alias text: label.text
    property var childrenModel: []
    property bool expanded: false

    Column {
        id: treeColumn
        width: parent.width
        spacing: 4

        Button {
            id: label
            width: parent.width
            text: treeItem.text + (treeItem.expanded ? " [-]" : " [+]")
            onClicked: treeItem.expanded = !treeItem.expanded
        }

        Column {
            spacing: 4
            visible: treeItem.expanded
            width: parent.width
            Repeater {
                model: treeItem.childrenModel
                Text {
                    text: "- " + modelData
                    font.pixelSize: 14
                    width: parent.width
                    padding: 8
                }
            }
        }
    }
}


/*
// TreeItem.qml
// TreeItem.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: treeItem
    property string text: ""
    property var children: []
    property bool expanded: false

    Column {
        spacing: 4

        Button {
            text: treeItem.text + (children.length > 0 ? (expanded ? " [-]" : " [+]") : "")
            onClicked: if (children.length > 0) expanded = !expanded
        }

        Column {
            spacing: 4
            visible: expanded

            Repeater {
                model: children

                delegate: Component {
                    TreeItem {
                        text: modelData.text
                        children: modelData.children
                    }
                }
            }
        }
    }
}
*/
