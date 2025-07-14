import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    // width: parent ? parent.width : 300
    property string title: "Section"
    property bool expanded: false
    property bool tagChecked:false
    property var comboModel: []

    // Final height depends on header + expanded section
    height: headerCheck.height + (expanded ?expandableContent.height + 10  : 0)
    width: expandableSection.implicitWidth

    Behavior on height {
        NumberAnimation { duration: 200
        }
    }
    Column {
        id:expandableSection
        spacing: 4

        // HEADER SECTION (Clickable CheckBox)
        CheckBox {
            id: headerCheck
            width:expandableColumn.implicitWidth
            // checked: tagChecked || modelData.checked
            // checked :modelData.checked
            // checked:tagChecked
            // checked: root.tagChecked || (typeof modelData !== 'undefined' && modelData.checked)

            onCheckedChanged: {
                    if (checked) {
                        // Check all items
                        for (let i = 0; i < comboModel.count; ++i) {
                            comboModel.setProperty(i, "checked", true)
                            comboModel.setProperty(i, "expanded", true)
                        }
                    }
                }
            onClicked:{

                expanded = checked
            }


            indicator: Item {}
            contentItem: Row {
                spacing: 10
                padding: 10
                height: 40

                Rectangle {
                    width: 20
                    height: 20
                    radius: 4
                    border.color: "black"
                    color: headerCheck.checked ? "white" : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: headerCheck.checked ? "\u2713" : ""
                        color: "black"
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                Text {
                    text: root.title
                    color: "white"
                    font.pixelSize: 16
                }
            }

            background: Rectangle {
                color: "transparent"
                border.width: 1
                border.color: "white"
            }
        }

        // EXPANDABLE SECTION
        Rectangle {
            id: expandableContent
            width:expandableColumn.implicitWidth
            height: expanded ? expandableColumn.height + 12 : 0
            visible: expanded
            opacity: expanded ? 1 : 0
            color: "transparent"

            Behavior on opacity { NumberAnimation { duration: 200 } }

            Column {
                id: expandableColumn
                padding:5

                Repeater {
                    model: comboModel

                    Column {
                        // width: parent.width
                        spacing: 4
                        padding:10

                        CheckBox {
                            id:checkBox
                            width:additionalColumn.implicitWidth
                            checked:model.checked
                            onCheckedChanged: {
                                    comboModel.setProperty(index, "checked", checked)

                                    // update expanded
                                    comboModel.setProperty(index, "expanded", checked)

                                    // If unchecked, parent must be unchecked
                                    if (!checked) {
                                        if (root.tagChecked) root.tagChecked = false
                                    } else {
                                        // Check if all siblings are checked
                                        let allChecked = true
                                        for (let i = 0; i < comboModel.count; ++i) {
                                            if (!comboModel.get(i).checked) {
                                                allChecked = false
                                                break
                                            }
                                        }
                                        if (allChecked && !root.tagChecked)
                                            root.tagChecked = true
                                    }
                                }


                            indicator: Item {}

                            contentItem: Row {
                                spacing: 10
                                height: 30

                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 4
                                    border.color: "black"
                                    color: checkBox.checked ? "white" : "transparent"

                                    Text {
                                        anchors.centerIn: parent
                                        text: checkBox.checked ? "\u2713" : ""
                                        color: "black"
                                        font.pixelSize: 14
                                        font.bold: true
                                    }
                                }

                                Text {
                                    text: model.name
                                    color: "white"
                                }
                            }

                            background: Rectangle {
                                color: "transparent"
                                border.width: 1
                                border.color: "white"
                            }
                        }

                        // EXPANDABLE SECTION
                        Column {
                            spacing: 4
                            visible: model.expanded
                            opacity: model.expanded ? 1 : 0

                            Behavior on opacity { NumberAnimation { duration: 200 } }


                            Item {
                                id: additionalToggleRow
                                width:addtionalRow.implicitWidth
                                height: 40
                                visible: model.hasAdditional
                                opacity: model.hasAdditional ? 1 : 0

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        model.additionalExpanded = !model.additionalExpanded
                                        if (model.additionalExpanded && root.requestAdditionalContent)
                                            root.requestAdditionalContent(root)
                                    }
                                    cursorShape: Qt.PointingHandCursor
                                }

                                Row {
                                    id:addtionalRow
                                    spacing: 10
                                    anchors.fill: parent
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.verticalCenter: parent.verticalCenter

                                    Text {
                                        text: "Additional Parameters"
                                        color: "white"
                                        font.pixelSize: 16
                                    }

                                    Rectangle {
                                        width: 20
                                        height: 20
                                        radius: 4
                                        border.color: "white"
                                        color: "transparent"

                                        Text {
                                            anchors.centerIn: parent
                                            text: model.additionalExpanded ? "\u2212" : "+" // Minus or Plus
                                            color: "white"
                                            font.pixelSize: 16
                                            font.bold: true
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                id: additionalContent
                                width:additionalColumn.implicitWidth
                                height: model.additionalExpanded ? additionalColumn.implicitHeight + 12 : 0
                                opacity: model.additionalExpanded ? 1 : 0
                                color: "#333"
                                // clip: true

                                Behavior on height { NumberAnimation { duration: 200 } }
                                Behavior on opacity { NumberAnimation { duration: 200 } }
/*
                                Rectangle{
                                    // Left Side Panel with Dial
                                    color:"transparent"
                                    anchors.right:additionalColumn.left
                                    width:dialSection.implicitWidth
                                    height:dialSection.implicitHeight
                                    Repeater {
                                        model: parameters

                                    Column {
                                        id:dialSection
                                        width: 120
                                        spacing: 10
                                        Rectangle {
                                            width: 100
                                            height: 100
                                            radius: 50
                                            color: "#444"
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Dial {
                                                id: dial
                                                from: 0
                                                to: 100
                                                value: 50
                                                anchors.fill: parent
                                                anchors.margins: 10
                                            }
                                        }

                                        ComboBox {
                                            id: dialModeSelector
                                            model: ["Set Min", "Set Max"]
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Text {
                                            text: `Dial Value: ${Math.round(dial.value)}`
                                            color: "white"
                                            font.pixelSize: 14
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Button {
                                            text: "Apply"
                                            onClicked: {
                                                console.log("Apply clicked")
                                                if (dialModeSelector.currentText === "Set Min") {
                                                    minSpin.value = Math.min(dial.value, maxSpin.value - 1) // optional guard
                                                } else {
                                                    maxSpin.value = Math.max(dial.value, minSpin.value + 1)
                                                }
                                            }
                                        }
                                    }
}
                                }
*/
                                Column {
                                    id: additionalColumn
                                    spacing: 12
                                    padding: 10

                                    Repeater {
                                        model: parameters

                                        MyAddtionalParameters {
                                            id: addtionalParameters
                                            // spacing: 4
                                            // MouseArea {
                                            //         anchors.fill: parent
                                            //         onClicked: {
                                            //             root.currentAdditional = addtionalParameters  // Register this instance
                                            //         }
                                            //     }
                                        }
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
    }
}
