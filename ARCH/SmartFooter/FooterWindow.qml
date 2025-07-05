import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    anchors.fill: parent
    color: "whitesmoke"

    property int activeKey: -1  // Store the active function key

    Text {
        anchors.centerIn: parent
        text: "@copyright"
        font.pixelSize: 10
    }

    Connections {
        target: KeyManager
        onKeyPressedKeyEvents: (key) => {
            console.log("Received Key event in footer: " + key);
            activeKey = key;  // Update the active key
        }
    }

    Row {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Repeater {
            model: ["F1", "F2", "F3", "F4"]
            delegate: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                border.color: "black"
                border.width: 1
                color: (activeKey === (modelData.charCodeAt(1) - 49 + Qt.Key_F1)) ? "green" : "white"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text: modelData
                    font.bold: true
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    text: "data"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Footer Function Key Clicked:", modelData);
                        let keyCode = modelData.charCodeAt(1) - 49 + Qt.Key_F1; // Convert F1, F2, F3, F4 to key codes
                        console.log("Footer Function Key keyCode: ", keyCode);
                        KeyManager.triggerKeyPress(keyCode);
                    }
                }
            }
        }
    }
}
