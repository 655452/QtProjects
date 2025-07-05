import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
Rectangle {
    id:popup
    anchors.fill: parent
    // color: "blue"
    radius: 20

    Column {
        anchors.fill: parent
        spacing: 10


        TabBar {
            id: bar
            width: parent.width
            TabButton {
                text: qsTr("Home")
            }
            TabButton {
                text: qsTr("Discover")
            }
            TabButton {
                text: qsTr("Activity")
            }
        }

        StackLayout {
                   id: stackView
                   width:200
                   height:70// Space for slider
         currentIndex: bar.currentIndex
                   Rectangle {
                       color: "lightblue"
                       radius: 20
                       // anchors.fill: parent
                       height:50
                        width:100
                       Text {
                           anchors.centerIn: parent
                           text: "This is Tab 1"
                           font.pixelSize: 18
                       }
                   }

                   Rectangle {
                       color: "lightgreen"
                       radius: 20
                       anchors.fill: parent
                       Text {
                           anchors.centerIn: parent
                           text: "This is Tab 2"
                           font.pixelSize: 18
                       }
                   }

                   Rectangle {
                       color: "lightcoral"
                       radius: 20
                       anchors.fill: parent
                       Text {
                           anchors.centerIn: parent
                           text: "This is Tab 3"
                           font.pixelSize: 18
                       }
                   }
               }

        // Slider
        // Slider {
        //     id: slider
        //     width: parent.width * 0.8
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     from: 0
        //     to: 100
        //     value: 50

        //     onValueChanged: console.log("Slider value:", value)
        // }
    }
}
