import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    anchors.fill: parent
    color: "whitesmoke"
    Text {
        anchors.centerIn: parent
        text: "@copyright"
        font.pixelSize: 10
    }


    // ListView {
    //     id: listView
    //     anchors.fill: parent
    //     model: sharedDataModel

    //     delegate: Rectangle {
    //         width: parent.width
    //         height: 40
    //         color: "white"
    //         border.color: "black"
    //         border.width: 1

    //         Text {
    //             anchors.centerIn: parent
    //             text: model.name + ": " + model.value
    //         }
    //     }
    // }
}
