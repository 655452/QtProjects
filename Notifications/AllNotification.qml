import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: stackArea

    property var notificationModel: []
    property bool notificationExpandedX: false
    property bool expanded: notificationExpandedX
    property int notificationCount:notificationModel.rowCount()
    property int visibleCount: expanded ? Math.min(notificationCount, 3) : 1

    // Dynamic height based on visible notifications
    height: 80 * visibleCount + 10 * Math.max(0, visibleCount - 1) // 10px spacing between notifications

    color: "grey"
    border.width: 1
    border.color: "white"

    Connections {
        target: notificationExpandedX
        onNotificationExpandedXChanged: {
            expanded = notificationExpandedX
        }
    }
    Connections{
        target:notificationModel
        onNotificationChanged:{
            notificationCount=notificationModel.rowCount()
        }

    }

    Rectangle {
        id: noOfNotifications
        width: 30
        height: 30
        radius: width / 2
        color: "#f00"
        border.width: 2
        border.color: "white"
        anchors.top: stackArea.top
        anchors.right: stackArea.right
        anchors.topMargin: -15
        anchors.rightMargin: -15
        z: 1000

        Text {
            anchors.centerIn: parent
            text: notificationCount
            color: "white"
            font.pixelSize: 12
            font.bold: true
        }
    }

    Repeater {
        model: notificationModel

        Rectangle {
            property int myIndex: index
            // Calculate reverse index for proper stacking (most recent at bottom)
            property int displayIndex: Math.min(visibleCount - 1, notificationCount - 1 - myIndex)

            visible: myIndex >= Math.max(0, notificationCount - visibleCount)

            width: stackArea.width - 20 // 10px margin on each side
            height: 80
            color: seen?"#555":"#444"
            radius: 10
            border.color: "#888"

            // Position from bottom upward
            anchors.bottom: stackArea.bottom
            anchors.bottomMargin: 10 + displayIndex * 90 // 10px base margin + stacking
            anchors.horizontalCenter: stackArea.horizontalCenter

            // Ghost stack effect - only show on the bottom-most visible notification
            Item {
                anchors.bottom: parent.top
                anchors.bottomMargin: -5
                visible: myIndex === (notificationCount - 1) && visibleCount === 1 && notificationCount > 1
                width: parent.width
                height: 25

                Repeater {
                    model: Math.min(3, notificationCount - 1)
                    Rectangle {
                        width: parent.width - (index * 8)
                        height: 8
                        radius: 4
                        color: "#88888844"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: index * 5
                        z: -index - 1
                        border.color: "#66666666"
                    }
                }
            }

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                Row {
                    spacing: 10
                    width: parent.width

                    Text {
                        id: noticeTitle
                        text: title
                        font.pixelSize: 16
                        font.bold: true
                        color: "#fff"
                        width: parent.width - 30 // Leave space for close button
                        wrapMode: Text.WordWrap
                    }

                    Rectangle {
                        id: crossIcon
                        width: 20
                        height: 20
                        radius: width / 2
                        color: "#555"
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            anchors.centerIn: parent
                            text: "×"
                            font.pixelSize: 14
                            color: "white"
                        }

                        MouseArea {
                            anchors.fill: parent
                            preventStealing: true
                            propagateComposedEvents: false
                            onClicked: {
                                mouse.accepted = true
                                console.log("Deleting index", myIndex)
                                // notificationModel.removeNotification(myIndex)

                                // notificationModel.sourceModel.markAsSeen(index)
                            }
                        }
                    }
                }

                Text {
                    text: time
                    font.pixelSize: 12
                    color: "#bbb"
                }
            }


            MouseArea {
                anchors.fill: parent
                z: -1
                // drag.target:parent
                onClicked: {
                    // notificationModel.markSourceAsSeen(index)
                    expanded = !expanded
                    console.log("Expanded:", expanded)
                    // notificationModel.markAsSeen(index)
                }
            }
        }
    }
}
