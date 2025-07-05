import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15


Rectangle {
    id:header
    anchors.fill: parent
    anchors.top: parent.top
    color: "gray"

    signal updateValue(string newValue)  // Signal to send data change

       RowLayout {
           anchors.fill: parent
           spacing: 6
           RoundButton {
               anchors.centerIn: parent
               text: "Update Footer"
               onClicked: {
                   updateValue("Updated from Header");  // Send signal
               }
           }
       }

    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: 6
        RoundButton {
            text: "settings" // Unicode Character 'CHECK MARK'
        }
        Text{
            // implicitWidth: parent.width
            text: "Smart   System"
        }
        RoundButton {
            Layout.alignment: Qt.AlignRight
            text: "restrart" // Unicode Character 'CHECK MARK'
            onClicked:{
            }
        }
        RoundButton {
            Layout.alignment: Qt.AlignRight
            text: "shutdown" // Unicode Character 'CHECK MARK'
            onClicked:{

            }
        }
    }

}


