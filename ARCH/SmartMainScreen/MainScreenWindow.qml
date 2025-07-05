import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    property int receivedCount: 0
    property var part1Btns: ["btn1", "btn2", "btn3", "btn4", "btn5", "btn6", "btn7", "btn8", "btn9"]
    property var part2Btns: ["btn1", "btn2", "btn3", "btn4", "btn5", "btn6", "btn7", "btn8", "btn9"]
    property var activePart1Btns: []
    property var activePart2Btns: []

    // Header Section
    RowLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        // Notification Icon
        Rectangle {
            width: 40
            height: 40
            color: receivedCount > 0 ? "red" : "#d3d3d3"
            radius: 20
            border.color: "black"
            border.width: 1
            Text {
                anchors.centerIn: parent
                text: receivedCount
                font.pixelSize: 24
                font.bold: true
            }
        }

        Text {
            text: "Multicast Messages"
            font.pixelSize: 24
            font.bold: true
        }
    }

    // Part 1 Buttons
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
            text: "Part 1"
            font.pixelSize: 20
            font.bold: true
        }

        RowLayout {
            spacing: 10
            Repeater {
                model: part1Btns
                Rectangle {
                    width: 40
                    height: 40
                    color: activePart1Btns[index] ? "green" : "#d3d3d3"
                    radius: 20
                    border.color: "black"
                    border.width: 1
                }
            }
        }
    }

    // Part 2 Buttons
    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 16

        Text {
            text: "Part 2"
            font.pixelSize: 20
            font.bold: true
        }

        RowLayout {
            spacing: 10
            Repeater {
                model: part2Btns
                Rectangle {
                    width: 40
                    height: 40
                    color: activePart2Btns[index] ? "blue" : "#d3d3d3"
                    radius: 20
                    border.color: "black"
                    border.width: 1
                }
            }
        }
    }

    // Connections to Multicast Receiver
    Connections {
        target: multicastReceiver

        // Handle Part 1 Data
        onPart1DataReceived: {
            activePart1Btns = data;
            console.log("Received Part 1 array:", data);
            receivedCount++;
        }

        // Handle Part 2 Data
        onPart2DataReceived: {
            activePart2Btns = data;
            console.log("Received Part 2 array:", data);
            receivedCount++;
        }
    }
}
