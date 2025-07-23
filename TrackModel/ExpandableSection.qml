// ExpandableSection.qml
// import QtQuick 2.15
// import QtQuick.Controls 2.15
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Item {
    id: root
    property string title: "Section"
    property string contentText: ""
    property bool expanded: false
    property string tabColor: ""
    property int rowHeight: 40
    property int baseHeight: 40
    property int visibleTreeRows: 0
    property var treeModel:[]
    property int noOfItems:0

    // Component.onCompleted:{
    //     noOfItems=treeModel.getVisibleItemCount()
    // }
    width: parent.width
    implicitHeight: baseHeight + (expanded ?treeView.contentHeight: 0)
    Column {
        spacing: 4
        width: parent.width

        Rectangle {
            width: parent.width
            height: 40
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: tabColor }
                GradientStop { position: 1.0; color: "transparent" }
            }
            Text {
                anchors.centerIn: parent
                text: title
            }
            Text{
                // text:parseFloat(noOfItems)
                text:noOfItems
                anchors.left:parent.left
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.expanded = !root.expanded
            }
        }

        Rectangle {
            width: parent.width
            height: root.expanded ?treeView.contentHeight : 0
            color: "gray"
            opacity: root.expanded ? 1 : 0

            Behavior on height { NumberAnimation { duration: 200 } }
            Behavior on opacity { NumberAnimation { duration: 200 } }

            TreeView {
                id: treeView
                anchors.fill: parent
                // anchors.margins: 10
                clip: true

                interactive:true
                selectionModel: ItemSelectionModel {}

                // The model needs to be a QAbstractItemModel
                // model: yourTreeModel
                // model:TreeModel
                model:treeModel
                // rowHeightProvider: function(row) {
                //     const item = treeView.itemAtRow(row)
                //     if (!item)
                //         return 40; // default height

                //     if (item.showDetails)
                //         return 100; // manually return bigger height
                //     return 40
                // }
                /*
                delegate: Item {
                    implicitWidth: root.width
                    implicitHeight: label.implicitHeight+parameters.implicitHeight+20

                    readonly property real indentation: 20
                    readonly property real padding: 5

                    required property TreeView treeView
                    required property bool isTreeNode
                    required property bool expanded
                    required property bool hasChildren
                    required property int depth
                    required property int row
                    required property int column
                    required property bool current

                    readonly property real boxOffsetX: padding + depth * indentation


                    // L-shaped lines (outside the background)
                    Canvas {
                        id: treeLines
                        width: boxOffsetX + 20
                        height: parent.height
                        anchors.left: parent.left
                        contextType: "2d"

                        onPaint: {
                            const ctx = context;
                            ctx.reset();
                            ctx.strokeStyle = "#fff";
                            ctx.lineWidth = 1;

                            const x = boxOffsetX + 8;
                            const yMid = height / 2;

                            // Vertical line
                            ctx.beginPath();
                            ctx.moveTo(x, 0);
                            ctx.lineTo(x, height);
                            ctx.stroke();

                            // Horizontal line
                            ctx.beginPath();
                            ctx.moveTo(x, yMid);
                            ctx.lineTo(x + 8, yMid);
                            ctx.stroke();
                        }
                    }


                    Shape {
                        id: treeLines
                        width: boxOffsetX + 20
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top

                        ShapePath {
                            strokeWidth: 1
                            strokeColor: "#ffffff"
                            fillColor: "transparent"

                            startX: boxOffsetX + 8
                            startY: 0

                            // Vertical line
                            PathLine { x: boxOffsetX + 8; y: parent.height / 2 }

                            // Horizontal line
                            PathLine { x: boxOffsetX + 16; y: parent.height / 2 }
                        }
                    }

                    // Expand/collapse button
                    Rectangle {
                        id: indicatorBox
                        width: 16
                        height: 16
                        radius: 2
                        border.color: "black"
                        color: "green"
                        visible: isTreeNode && hasChildren
                        anchors.verticalCenter: parent.verticalCenter
                        x: boxOffsetX + 8

                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 12
                            text: expanded ? "-" : "+"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                let index = treeView.index(row, column);
                                treeView.selectionModel.setCurrentIndex(index, ItemSelectionModel.NoUpdate);
                                treeView.toggleExpanded(row);
                            }
                        }
                    }

                    Rectangle {
                        id: background
                        anchors {
                            left: indicatorBox.right
                            right: parent.right
                            top: parent.top
                            bottom: parent.bottom
                            leftMargin: 6
                        }
                        border.color: current ? "white" : "green"
                        border.width: 1
                        radius: 2
                        opacity: 1

                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop {
                                position: 0.0
                                color:  model.color // No more palette.highlight
                            }
                            GradientStop {
                                position: 1.0
                                color: "pink"
                            }
                        }

                        Label {
                            id: label
                            // anchors.centerIn: parent
                            text: model.name
                            color: "white"
                            elide: Text.ElideRight
                            // verticalAlignment: Text.AlignVCenter
                            // horizontalAlignment: Text.AlignLeft
                            anchors.horizontalCenter: parent.horizontalCenter

                        }
                        Row{
                            // id:parameters
                            width:parent.width
                            anchors.top: label.bottom
                            visible: current
                            spacing:5

                            anchors.horizontalCenter: parent.horizontalCenter
                            Repeater{
                                // model:[
                                //     {"name":"param1","value":"0.2"},
                                //     {"name":"param2","value":"0.1"},
                                //     {"name":"param3","value":"0.3"},
                                //     {"name":"param4","value":"0.4"},
                                // ]
                                model:parameters

                                delegate:Column{

                                    Label{
                                        text:modelData.name
                                    }
                                    Label{
                                        text:modelData.value
                                    }
                                }
                                Component.onCompleted:{
                                    console.log(JSON.stringify(parameters))
                                }

                            }

                        }

                    }

                }
*/

                delegate: Item {
                    id: delegateItem
                    required property TreeView treeView
                    // required property bool isTreeNode

                    property bool isTreeNode: treeView.model.hasChildren(treeView.index(row, 0))
                    required property bool expanded
                    required property bool hasChildren
                    required property int depth
                    required property int row
                    required property int column
                    required property bool current

                    property bool showDetails: false

                    readonly property real indentation: 20
                    readonly property real padding: 5
                    readonly property real boxOffsetX: padding + depth * indentation
                    required property bool selected


                    onImplicitHeightChanged:{

                        console.log("height --- > ",implicitHeight)
                    }
                    onShowDetailsChanged: {
                        console.log(" show details --- > ",showDetails)
                        // let m = treeView.model
                        // treeView.model = null
                        // treeView.model = m
                        // treeView.forceLayout()
                    }

                    // width: root.width
                    implicitHeight: label.height + (selected ? detailsBlock.implicitHeight : 0) + 20

                    implicitWidth: root.width
                    // implicitHeight: label.implicitHeight+parameters.implicitHeight+20

                    // Indicator Box: only for child expansion
                    Rectangle {
                        id: indicatorBox
                        width: 16
                        height: 16
                        radius: 2
                        border.color: "black"
                        color: "green"
                        visible: isTreeNode
                        anchors.verticalCenter: parent.verticalCenter
                        x: boxOffsetX + 8

                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 12
                            text: expanded ? "-" : "+"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {

                                selected = !selected
                                // treeView.expand(row)
                                let index = treeView.index(row, column)
                                treeView.selectionModel.setCurrentIndex(index, ItemSelectionModel.NoUpdate)
                                treeView.toggleExpanded(row)

                                treeView.forceLayout() // If available
                            }
                        }
                    }

                    Rectangle {
                        id: background
                        anchors {
                            left: indicatorBox.right
                            right: parent.right
                            top: parent.top
                            bottom: parent.bottom
                            leftMargin: 6
                        }
                        border.color: current ? "white" : "green"
                        border.width: 1
                        radius: 2

                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop {
                                position: 0.0
                                color: model.color
                            }
                            GradientStop {
                                position: 1.0
                                color: "pink"
                            }
                        }

                        Column {
                            id: contentBlock
                            anchors.fill: parent
                            anchors.margins: 5

                            Label {
                                id: label
                                text: model.name
                                color: "white"
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            // Parameters section (hidden/shown)
                            Row {
                                id: detailsBlock
                                visible: selected
                                spacing: 5
                                anchors.horizontalCenter: parent.horizontalCenter

                                Repeater {
                                    model: parameters
                                    delegate: Column {
                                        Label { text: modelData.name }
                                        Label { text: modelData.value }
                                    }
                                }
                            }
                        }

                        // Toggle parameters visibility on background click
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                selected = !selected
                            }
                        }
                    }
                }

            }
        }
    }
}

