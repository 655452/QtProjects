import QtQuick 2.15
import QtQuick.Controls 2.15
/*
Column {
    id:addtionalParameters
    CheckBox {
        id: control
        text: modelData
        
        indicator: Item {}
        
        contentItem: Row {
            spacing: 50
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                text: control.text
                color: "white"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }
            
            Rectangle {
                width: 20
                height: 20
                radius: 4
                border.color: "white"
                color: control.checked ? "white" : "transparent"
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    anchors.centerIn: parent
                    text: control.checked ? "\u2713" : ""
                    color: "black"
                    font.pixelSize: 14
                    font.bold: true
                }
            }
        }
        
        background: Rectangle {
            color: "transparent"
        }
    }
    
    Row {
        id:addtionalColumnRow
        spacing: 20
        
        Text {
            text: "Min"
            color: "white"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter
        }
        
        SpinBox {
            id: minSpin
            width: 100
            from: 0
            to: 100
            anchors.verticalCenter: parent.verticalCenter
            
            background: Rectangle {
                color: "transparent"
                border.width: 1
                border.color: "#373737"
            }
            
            up.indicator: null
            down.indicator: null
            
            contentItem: Row {
                spacing: 4
                
                Rectangle {
                    width: 20
                    height: 20
                    color: "#555"
                    radius: 4
                    MouseArea {
                        anchors.fill: parent
                        onClicked: minSpin.value--
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "-"
                        color: "white"
                        font.pixelSize: 14
                    }
                }
                
                Text {
                    text: minSpin.value
                    color: "white"
                    font.pixelSize: 14
                    width: 40
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                Rectangle {
                    width: 20
                    height: 20
                    color: "#555"
                    radius: 4
                    MouseArea {
                        anchors.fill: parent
                        onClicked: minSpin.value++
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "+"
                        color: "white"
                        font.pixelSize: 14
                    }
                }
            }
        }
        
        Text {
            text: "Max"
            color: "white"
            font.pixelSize: 12
            anchors.verticalCenter: parent.verticalCenter
        }
        
        SpinBox {
            id: maxSpin
            width: 100
            from: 0
            to: 100
            anchors.verticalCenter: parent.verticalCenter
            
            background: Rectangle {
                color: "transparent"
                border.width: 1
                border.color: "#373737"
            }
            
            up.indicator: null
            down.indicator: null
            
            contentItem: Row {
                spacing: 4
                
                Rectangle {
                    width: 20
                    height: 20
                    color: "#555"
                    radius: 4
                    MouseArea {
                        anchors.fill: parent
                        onClicked: maxSpin.value--
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "-"
                        color: "white"
                        font.pixelSize: 14
                    }
                }
                
                Text {
                    text: maxSpin.value
                    color: "white"
                    font.pixelSize: 14
                    width: 40
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                Rectangle {
                    width: 20
                    height: 20
                    color: "#555"
                    radius: 4
                    MouseArea {
                        anchors.fill: parent
                        onClicked: maxSpin.value++
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "+"
                        color: "white"
                        font.pixelSize: 14
                    }
                }
            }
        }
    }
}
*/

import QtQuick 2.15
import QtQuick.Controls 2.15
/*
Item{
    width:addtionalParameters.implicitWidth
    height:addtionalParameters.implicitHeight
    Rectangle{
        // Left Side Panel with Dial
        color:"transparent"
        anchors.right:addtionalParameters.left
        width:dialSection.implicitWidth
        height:dialSection.implicitHeight
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
*/
    Row {
        id: addtionalParameters
        spacing: 20


        // Right Side Content
        Column {
            spacing: 10
            CheckBox {
                id: control
                text: modelData
                indicator: Item {}

                contentItem: Row {
                    spacing: 50
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        text: control.text
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14
                    }

                    Rectangle {
                        width: 20
                        height: 20
                        radius: 4
                        border.color: "white"
                        color: control.checked ? "white" : "transparent"
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            anchors.centerIn: parent
                            text: control.checked ? "\u2713" : ""
                            color: "black"
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                }

                background: Rectangle {
                    color: "transparent"
                }
            }

            Row {
                id: addtionalColumnRow
                spacing: 20

                Text {
                    text: "Min"
                    color: "white"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }

                SpinBox {
                    id: minSpin
                    width: 100
                    from: 0
                    to: 100
                    anchors.verticalCenter: parent.verticalCenter

                    background: Rectangle {
                        color: "transparent"
                        border.width: 1
                        border.color: "#373737"
                    }

                    up.indicator: null
                    down.indicator: null

                    contentItem: Row {
                        spacing: 4

                        Rectangle {
                            width: 20
                            height: 20
                            color: "#555"
                            radius: 4
                            MouseArea {
                                anchors.fill: parent
                                onClicked: minSpin.value--
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                color: "white"
                                font.pixelSize: 14
                            }
                        }

                        Text {
                            text: minSpin.value
                            color: "white"
                            font.pixelSize: 14
                            width: 40
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Rectangle {
                            width: 20
                            height: 20
                            color: "#555"
                            radius: 4
                            MouseArea {
                                anchors.fill: parent
                                onClicked: minSpin.value++
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                color: "white"
                                font.pixelSize: 14
                            }
                        }
                    }
                }

                Text {
                    text: "Max"
                    color: "white"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }

                SpinBox {
                    id: maxSpin
                    width: 100
                    from: 0
                    to: 100
                    anchors.verticalCenter: parent.verticalCenter

                    background: Rectangle {
                        color: "transparent"
                        border.width: 1
                        border.color: "#373737"
                    }

                    up.indicator: null
                    down.indicator: null

                    contentItem: Row {
                        spacing: 4

                        Rectangle {
                            width: 20
                            height: 20
                            color: "#555"
                            radius: 4
                            MouseArea {
                                anchors.fill: parent
                                onClicked: maxSpin.value--
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                color: "white"
                                font.pixelSize: 14
                            }
                        }

                        Text {
                            text: maxSpin.value
                            color: "white"
                            font.pixelSize: 14
                            width: 40
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Rectangle {
                            width: 20
                            height: 20
                            color: "#555"
                            radius: 4
                            MouseArea {
                                anchors.fill: parent
                                onClicked: maxSpin.value++
                            }
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                color: "white"
                                font.pixelSize: 14
                            }
                        }
                    }
                }

            }
        }
    }

// }

