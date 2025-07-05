import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
Rectangle {

    anchors.fill: parent

    Rectangle{
        anchors.fill: parent
        Text {
            id: datamodel
            text: qsTr("Data")
        }
        RowLayout{
            spacing: 10
            anchors.fill: parent
            ColumnLayout{
                spacing: 2

                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    color: "red"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                }

                Rectangle {
                    Layout.alignment: Qt.AlignRight
                    color: "green"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 70
                }

                Rectangle {
                    Layout.alignment: Qt.AlignBottom
                    Layout.fillHeight: true
                    color: "blue"
                    Layout.preferredWidth: 70
                    Layout.preferredHeight: 40
                }
            }

            ColumnLayout{
                spacing: 2
                RoundButton {
                    Layout.alignment: Qt.AlignCenter
                    text: "" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
                RoundButton {
                    text: "\u2713" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
                RoundButton {
                    text: "\u2713" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
                RoundButton {
                    text: "\u2713" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
                RoundButton {
                    text: "\u2713" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
                RoundButton {
                    text: "\u2713" // Unicode Character 'CHECK MARK'
                    onClicked: textArea.readOnly = true
                }
            }


        }

        //     Rectangle{

        //         implicitWidth: parent.width/4
        //         implicitHeight: parent.height/2

        //         ListView {
        //             id: listView
        //             anchors.fill: parent
        //             width: parent.width/2
        //             model: sharedDataModel2

        //             delegate: Rectangle {
        //                 width: parent.width
        //                 height: 40
        //                 color: "white"
        //                 border.color: "black"
        //                 border.width: 1
        //                 Text {
        //                     anchors.centerIn: parent
        //                     text: model.name + ": " + model.value
        //                 }
        //             }
        //         }

        //     }


    }


}
