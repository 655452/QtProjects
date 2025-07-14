
// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts

// Window {
//     width: 800
//     height: 600
//     visible: true
//     title: qsTr("Draggable Resizable Layout")

//     // Global alignment properties
//     property int maxNameWidth: 0
//     property int maxColonWidth: 0

//     // Function to calculate maximum widths
//     function updateMaxWidths() {
//         maxNameWidth = 0;
//         maxColonWidth = 0;

//         // Calculate from both grids
//         for (let i = 0; i < grid1.children.length; i++) {
//             let item = grid1.children[i];
//             if (item.nameLabel) {
//                 maxNameWidth = Math.max(maxNameWidth, item.nameLabel.implicitWidth);
//             }
//             if (item.colonLabel) {
//                 maxColonWidth = Math.max(maxColonWidth, item.colonLabel.implicitWidth);
//             }
//         }

//         for (let i = 0; i < grid2.children.length; i++) {
//             let item = grid2.children[i];
//             if (item.nameLabel) {
//                 maxNameWidth = Math.max(maxNameWidth, item.nameLabel.implicitWidth);
//             }
//             if (item.colonLabel) {
//                 maxColonWidth = Math.max(maxColonWidth, item.colonLabel.implicitWidth);
//             }
//         }
//     }

//     Rectangle {
//         id: draggableRect
//         color: "lightgreen"
//         property real fontScale: Math.max(12, width / 25)

//         // Initial size and position
//         width: 400
//         height: 300
//         x: 200
//         y: 150

//         // Minimum size constraints
//         property int minWidth: 300
//         property int minHeight: 200

//         // Border for resize handles
//         border.width: 2
//         border.color: "darkgreen"

//         // Make it draggable
//         MouseArea {
//             id: dragArea
//             anchors.fill: parent
//             anchors.margins: 10 // Leave margins for resize handles

//             drag.target: draggableRect
//             // drag.axis: Drag.XAndYAxis

//             // Prevent dragging when near edges (for resizing)
//             // enabled: !resizeArea.containsMouse

//             // cursorShape: enabled ? Qt.SizeAllCursor : Qt.ArrowCursor
//         }

//         MouseArea {
//             id: resizeArea
//             anchors.fill: parent
//             hoverEnabled: true

//             property bool isResizing: false
//             property point startPos
//             property size startSize
//             property point startRectPos
//             property string resizeDirection: ""

//             property bool nearRightEdge: mouseX > parent.width - 10
//             property bool nearBottomEdge: mouseY > parent.height - 10
//             property bool nearLeftEdge: mouseX < 10
//             property bool nearTopEdge: mouseY < 10

//             cursorShape: {
//                 if (nearLeftEdge && nearTopEdge) return Qt.SizeFDiagCursor
//                 if (nearRightEdge && nearBottomEdge) return Qt.SizeFDiagCursor
//                 if (nearRightEdge && nearTopEdge) return Qt.SizeBDiagCursor
//                 if (nearLeftEdge && nearBottomEdge) return Qt.SizeBDiagCursor
//                 if (nearRightEdge || nearLeftEdge) return Qt.SizeHorCursor
//                 if (nearBottomEdge || nearTopEdge) return Qt.SizeVerCursor
//                 return Qt.ArrowCursor
//             }

//             onPressed: {
//                 // Detect which edge/corner is being pressed
//                 if (nearLeftEdge && nearTopEdge) resizeDirection = "topLeft"
//                 else if (nearRightEdge && nearBottomEdge) resizeDirection = "bottomRight"
//                 else if (nearRightEdge && nearTopEdge) resizeDirection = "topRight"
//                 else if (nearLeftEdge && nearBottomEdge) resizeDirection = "bottomLeft"
//                 else if (nearLeftEdge) resizeDirection = "left"
//                 else if (nearRightEdge) resizeDirection = "right"
//                 else if (nearTopEdge) resizeDirection = "top"
//                 else if (nearBottomEdge) resizeDirection = "bottom"
//                 else resizeDirection = ""

//                 if (resizeDirection !== "") {
//                     isResizing = true
//                     startPos = Qt.point(mouseX, mouseY)
//                     startSize = Qt.size(draggableRect.width, draggableRect.height)
//                     startRectPos = Qt.point(draggableRect.x, draggableRect.y)
//                 }
//             }

//             onPositionChanged: {
//                 if (!isResizing) return;

//                 let dx = mouseX - startPos.x
//                 let dy = mouseY - startPos.y

//                 let minWidth = draggableRect.minWidth
//                 let minHeight = draggableRect.minHeight

//                 // Copy current values to mutate
//                 let newX = startRectPos.x
//                 let newY = startRectPos.y
//                 let newW = startSize.width
//                 let newH = startSize.height

//                 switch (resizeDirection) {
//                 case "right":
//                     newW = Math.max(minWidth, startSize.width + dx)
//                     break;
//                 case "bottom":
//                     newH = Math.max(minHeight, startSize.height + dy)
//                     break;
//                 case "bottomRight":
//                     newW = Math.max(minWidth, startSize.width + dx)
//                     newH = Math.max(minHeight, startSize.height + dy)
//                     break;
//                 case "left":
//                     newW = Math.max(minWidth, startSize.width - dx)
//                     newX = startRectPos.x + dx
//                     if (newW === minWidth)
//                         newX = startRectPos.x + (startSize.width - minWidth)
//                     break;
//                 case "top":
//                     newH = Math.max(minHeight, startSize.height - dy)
//                     newY = startRectPos.y + dy
//                     if (newH === minHeight)
//                         newY = startRectPos.y + (startSize.height - minHeight)
//                     break;
//                 case "topLeft":
//                     newW = Math.max(minWidth, startSize.width - dx)
//                     newH = Math.max(minHeight, startSize.height - dy)
//                     newX = startRectPos.x + dx
//                     newY = startRectPos.y + dy
//                     if (newW === minWidth)
//                         newX = startRectPos.x + (startSize.width - minWidth)
//                     if (newH === minHeight)
//                         newY = startRectPos.y + (startSize.height - minHeight)
//                     break;
//                 case "topRight":
//                     newW = Math.max(minWidth, startSize.width + dx)
//                     newH = Math.max(minHeight, startSize.height - dy)
//                     newY = startRectPos.y + dy
//                     if (newH === minHeight)
//                         newY = startRectPos.y + (startSize.height - minHeight)
//                     break;
//                 case "bottomLeft":
//                     newW = Math.max(minWidth, startSize.width - dx)
//                     newX = startRectPos.x + dx
//                     if (newW === minWidth)
//                         newX = startRectPos.x + (startSize.width - minWidth)
//                     newH = Math.max(minHeight, startSize.height + dy)
//                     break;
//                 }
//                 draggableRect.x = newX
//                 draggableRect.y = newY
//                 draggableRect.width = newW
//                 draggableRect.height = newH
//             }

//             onReleased: isResizing = false;
//         }
//         // Content that adapts to rectangle size
//         ScrollView {
//             id: scrollView
//             anchors.fill: parent
//             anchors.margins: 10

//             contentWidth: contentColumn.implicitWidth
//             contentHeight: contentColumn.implicitHeight

//             ColumnLayout {
//                 id: contentColumn
//                 width: scrollView.width
//                 spacing: 20

//                 // First Grid
//                 GridLayout {
//                     id: grid1
//                     columns: 3
//                     columnSpacing: 10
//                     rowSpacing: 8
//                     Layout.fillWidth: true

//                     // Header (optional)
//                     Label {
//                         text: "Group 1"
//                         font.bold: true
//                         Layout.columnSpan: 3
//                         Layout.fillWidth: true
//                         font.pixelSize: draggableRect.fontScale
//                         horizontalAlignment: Text.AlignHCenter
//                     }

//                     Repeater {
//                         model: [
//                             { value: "nepo", name: "asit" },
//                             { value: "nepo", name: "shyam" },
//                             { value: "nepo", name: "moonson" },
//                             { value: "nepo", name: "tree" },
//                             { value: "nepo", name: "manure tent" }
//                         ]

//                         delegate: Item {
//                             Layout.fillWidth: true
//                             Layout.columnSpan: 3
//                             height: childrenRect.height

//                             property alias nameLabel: nameLabel
//                             property alias colonLabel: colonLabel

//                             RowLayout {
//                                 anchors.left: parent.left
//                                 anchors.right: parent.right
//                                 spacing: 10

//                                 Label {
//                                     id: nameLabel
//                                     text: modelData.name
//                                     Layout.preferredWidth: maxNameWidth
//                                     Layout.minimumWidth: implicitWidth
//                                     horizontalAlignment: Text.AlignRight
//                                     font.pixelSize: draggableRect.fontScale

//                                     onImplicitWidthChanged: updateMaxWidths()
//                                 }

//                                 Label {
//                                     id: colonLabel
//                                     text: ":"
//                                     Layout.preferredWidth: maxColonWidth
//                                     Layout.minimumWidth: implicitWidth
//                                     horizontalAlignment: Text.AlignHCenter

//                                     onImplicitWidthChanged: updateMaxWidths()
//                                 }

//                                 Label {
//                                     text: modelData.value
//                                     Layout.fillWidth: true
//                                     font.pixelSize: draggableRect.fontScale
//                                     wrapMode: Text.WordWrap
//                                 }
//                             }
//                         }
//                     }
//                 }

//                 // Separator
//                 Rectangle {
//                     Layout.fillWidth: true
//                     height: 2
//                     color: "darkgreen"
//                     Layout.topMargin: 10
//                     Layout.bottomMargin: 10
//                 }

//                 // Second Grid
//                 GridLayout {
//                     id: grid2
//                     columns: 3
//                     columnSpacing: 10
//                     rowSpacing: 8
//                     Layout.fillWidth: true

//                     // Header (optional)
//                     Label {
//                         text: "Group 2"
//                         font.bold: true
//                         Layout.columnSpan: 3
//                         font.pixelSize: draggableRect.fontScale
//                         Layout.fillWidth: true
//                         horizontalAlignment: Text.AlignHCenter
//                     }

//                     Repeater {
//                         model: [
//                             { value: "nepo", name: "asit bakade" },
//                             { value: "nepo", name: "shyam nimje" },
//                             { value: "nepo", name: "moonson" },
//                             { value: "nepo", name: "tree" },
//                             { value: "nepo", name: "manure tent" }
//                         ]

//                         delegate: Item {
//                             Layout.fillWidth: true
//                             Layout.columnSpan: 3
//                             height: childrenRect.height

//                             property alias nameLabel: nameLabel2
//                             property alias colonLabel: colonLabel2

//                             RowLayout {
//                                 anchors.left: parent.left
//                                 anchors.right: parent.right
//                                 spacing: 10

//                                 Label {
//                                     id: nameLabel2
//                                     text: modelData.name
//                                     Layout.preferredWidth: maxNameWidth
//                                     Layout.minimumWidth: implicitWidth
//                                     horizontalAlignment: Text.AlignRight

//                                     onImplicitWidthChanged: updateMaxWidths()
//                                 }

//                                 Label {
//                                     id: colonLabel2
//                                     text: ":"
//                                     Layout.preferredWidth: maxColonWidth
//                                     Layout.minimumWidth: implicitWidth
//                                     horizontalAlignment: Text.AlignHCenter
//                                     font.pixelSize: draggableRect.fontScale
//                                     onImplicitWidthChanged: updateMaxWidths()
//                                 }

//                                 Label {
//                                     text: modelData.value
//                                     Layout.fillWidth: true
//                                     wrapMode: Text.WordWrap
//                                     font.pixelSize: draggableRect.fontScale
//                                 }
//                             }
//                         }
//                     }
//                 }
//             }
//         }

//         // Resize handle indicator (optional visual feedback)
//         Rectangle {
//             width: 15
//             height: 15
//             color: "darkgreen"
//             anchors.right: parent.right
//             anchors.bottom: parent.bottom
//             anchors.margins: 2

//             Rectangle {
//                 width: 2
//                 height: 8
//                 color: "white"
//                 anchors.centerIn: parent
//                 rotation: 45
//             }

//             Rectangle {
//                 width: 8
//                 height: 2
//                 color: "white"
//                 anchors.centerIn: parent
//                 rotation: 45
//             }
//         }
//     }

//     // Instructions
//     Text {
//         anchors.top: parent.top
//         anchors.left: parent.left
//         anchors.margins: 20
//         font.pixelSize: draggableRect.fontScale
//         text: "• Drag the rectangle to move it\n• Hover near edges/corners to resize\n• Content automatically adapts to size"
//         color: "gray"
//     }

//     Component.onCompleted: {
//         updateMaxWidths()
//     }
// }
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MyApp 1.0
import "AnchorUtil.js" as Utils


ApplicationWindow {
    width: 800; height: 600; visible: true
/*
    // Draggable Box
    Rectangle {
        id: box
        width: 400; height: 300; x: 200; y: 150
        color: "lightgreen"
        property real fontScale: Math.max(12, width / 25)
        // minimumWidth: 150; minimumHeight: 100
        property int minimumWidth: 150
        property int minimumHeight: 100

        antialiasing:true
        // Drag anywhere except the resize handle
        MouseArea {
            anchors.fill: parent
            drag.target: parent
            anchors.margins: 16
        }

        // Simple resize handle
        Rectangle {
            width: 20; height: 20; color: "darkgreen"
            anchors.right: parent.right; anchors.bottom: parent.bottom
            radius: 6

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.SizeFDiagCursor
                property real startW
                property real startH
                property real startX
                property real startY
                onPressed: {
                    startW = box.width
                    startH = box.height
                    startX = mouse.x
                    startY = mouse.y
                }
                onPositionChanged: {
                    box.width = Math.max(box.minimumWidth, startW + mouse.x - startX)
                    box.height = Math.max(box.minimumHeight, startH + mouse.y - startY)
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: "Drag me!\nResize me (bottom right)."
            font.pixelSize: box.fontScale
        }
    }

        // popup proper Layout
    Rectangle{
        width:400
        height:600
        color:"black"
        border.width:1
        border.color:"white"


        // GIve the proper card through which i should take the input  for  our  website in details explain How these
        // can be made with proper qml  best practices and how to use the columnLayout effectively and properly explain
        // the card should be scallable and dragable also please keep these in consideration
        ColumnLayout{
            anchors.margins:10
            MouseArea{
                anchors.fill:parent
                drag.target:parent
            }
            spacing:10
            Rectangle{
                anchors.fill:parent
                color:"gray"
                opacity:0.7
            }
            RowLayout {
                // anchors.fill: parent
                // Layout.fillWidth:true
                Layout.alignment:Qt.AlignHCenter
                spacing: 10

                Rectangle {
                    // Layout.columnSpan:2
                    color: "lightblue"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    Layout.horizontalStretchFactor: 1
                    Text { anchors.centerIn: parent; text: "1" }
                }

                Rectangle {
                    // Layout.columnSpan:2
                    color: "lightgreen"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    Layout.horizontalStretchFactor: 2
                    Text { anchors.centerIn: parent; text: "2" }
                }

                Rectangle {
                    // Layout.columnSpan:2
                    color: "lightcoral"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    Layout.horizontalStretchFactor: 1
                    Text { anchors.centerIn: parent; text: "1" }
                }
            }

            RowLayout{
                Layout.fillWidth:true
                // width:parent.implicitWidth
                // uniformCellSizes:true


                Label{
                    text:"Item"
                    Layout.fillWidth:true
                    color:"white"
                    background:Rectangle{
                        color:"gray"
                    }
                }

                Rectangle{
                    width:20
                    height:20
                    color:"transparent"
                    radius:width/2
                    border.width:1
                    border.color:"white"
                }
            }

            GridLayout{
                columns:6
                columnSpacing:20

                Label{
                    color:"white"
                    text:"Category"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"Fruits"
                }

                // ---------------------------------
                Label{
                    color:"white"
                    text:"vegetables"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"spinach"
                }

                Label{
                    color:"white"
                    text:"Snacks"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"Kurkurey"
                }

                // ---------------------------------
                Label{
                    color:"white"
                    text:"vegetables"

                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"spinach"
                }

            }
            
            
            GridLayout{
                columns:4
                columnSpacing:20
                uniformCellWidths:true

                Rectangle {
                    Layout.columnSpan:2
                    color: "lightblue"
                    // Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    // Layout.horizontalStretchFactor: 1
                    Text { anchors.centerIn: parent; text: "1" }
                }

                Rectangle {
                    Layout.columnSpan:2
                    color: "lightgreen"
                    // Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    // Layout.horizontalStretchFactor: 2
                    Text { anchors.centerIn: parent; text: "2" }
                }

                Rectangle {
                    Layout.columnSpan:2
                    color: "lightcoral"
                    // Layout.preferredWidth: 50
                    Layout.preferredHeight:50
                    Layout.fillHeight: true
                    Layout.fillWidth:true
                    // Layout.horizontalStretchFactor: 1
                    Text { anchors.centerIn: parent; text: "1" }
                }

                Label{
                    color:"white"
                    text:"animals"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"Cat"
                }

                // ---------------------------------
                Label{
                    color:"white"
                    text:"vegei"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"carrot"
                }

                Label{
                    color:"white"
                    text:"CHip"
                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"mita"
                }

                // ---------------------------------
                Label{
                    color:"white"
                    text:"vegetables"

                }
                Label{
                    color:"white"
                    text:":"
                }
                Label{
                    color:"white"
                    text:"spinach"
                }

            }
            
        }
    }

    */
    // LAyout for xml to qml file generation

        ZoneLoader {
            id: loader
            onZonesChanged: repeater.model = loader.zones
        }

        Component.onCompleted: {
            loader.loadZonesFromXml("/home/asit/WORKSPACE/Layout/Zones.xml")
        }

        Rectangle{
            id:taskBar
            width:20
            height:60
            color:"red"
            radius:50
            anchors.right:parent.right
            anchors.verticalCenter:parent.verticalCenter
        }

        // ColumnLayout {
        //     id: layoutColumn
        //     anchors.fill: parent
        //     spacing: 10

        //     Repeater {
        //         id: repeater
        //         delegate: Rectangle {
        //             width: modelData.width
        //             height: modelData.height
        //             color: modelData.color
        //         }
        //     }
        // }

        Rectangle{
            id:shapePath
            Rectangle{

            }
        }

        Item {
            id: layoutContainer
            anchors.fill: parent

            Repeater {
                id: repeater
                delegate: Rectangle {
                    width: parseInt(modelData.width)
                    height: parseInt(modelData.height)
                    color: modelData.color || "gray"

                    // Dynamic ID assignment (optional)
                    objectName: modelData.id

                    // Absolute Positioning
                    x: modelData.x !== undefined ? parseInt(modelData.x) : 0
                    y: modelData.y !== undefined ? parseInt(modelData.y) : 0

                    // Anchor support
                    Component.onCompleted: {
                            Utils.applyAnchors(this, modelData, layoutContainer)
                        Utils.applyProperties(this, modelData)
                        }

                }
            }
        }


    /*
    ColumnLayout{
        id:layout
        Rectangle{
          id:zone1
          width:100
          height:150
          color:"red"
        }

        Rectangle{
          id:zone2
          width:100
          height:150
          color:"green"
        }

        Rectangle{
          id:zone3
          width:100
          height:150
          color:"pink"
        }
    }
    */
}
