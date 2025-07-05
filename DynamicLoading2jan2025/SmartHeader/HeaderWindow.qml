import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15


Rectangle {
    id:header
    anchors.fill: parent
    anchors.top: parent.top
    color: "gray"
    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: 6
        RoundButton {

            text: "settings" // Unicode Character 'CHECK MARK'
        }
        Text{
            // implicitWidth: parent.width
            text: "Smart Monitoring  System"
        }
        RoundButton {
            Layout.alignment: Qt.AlignRight
            text: "restrart" // Unicode Character 'CHECK MARK'
            onClicked: textArea.readOnly = true
        }
        RoundButton {
            Layout.alignment: Qt.AlignRight

            text: "shutdown" // Unicode Character 'CHECK MARK'
            onClicked: textArea.readOnly = true
        }


    }



}


