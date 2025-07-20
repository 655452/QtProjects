// // MyStackArea.qml - Updated to work with C++ models
// import QtQuick 2.15
// import QtQuick.Controls 2.15

// Rectangle {
//     id: stackArea

//     property var notificationModel: null
//     property bool notificationExpandedX: false
//     property bool expanded: notificationExpandedX
//     property int visibleCount: expanded ? Math.min(notificationModel ? notificationModel.count : 0, 3) : 1
//     property string stackTitle: "NOTIFICATIONS"
//     property string stackColor: "#4CAF50"

//     // Dynamic height - this will cause upward expansion because stackArea is bottom-anchored
//     height: visibleCount > 0 ? (80 * visibleCount + 10 * Math.max(0, visibleCount - 1) + 40) : 120

//     color: "transparent"
//     border.width: 1
//     border.color: stackColor
//     radius: 10

//     // Smooth height animation
//     Behavior on height {
//         NumberAnimation {
//             duration: 300
//             easing.type: Easing.OutQuad
//         }
//     }

//     // Stack title
//     Rectangle {
//         id: titleBar
//         width: parent.width
//         height: 30
//         color: stackColor
//         radius: 10
//         anchors.top: parent.top

//         Text {
//             anchors.centerIn: parent
//             text: stackTitle + " (" + (notificationModel ? notificationModel.count : 0) + ")"
//             color: "white"
//             font.pixelSize: 12
//             font.bold: true
//         }
//     }

//     // Notification count bubble
//     Rectangle {
//         id: noOfNotifications
//         width: 30
//         height: 30
//         radius: width / 2
//         color: "#f00"
//         border.width: 2
//         border.color: "white"
//         anchors.top: stackArea.top
//         anchors.right: stackArea.right
//         anchors.topMargin: -15
//         anchors.rightMargin: -15
//         z: 1000
//         visible: notificationModel ? notificationModel.count > 0 : false

//         Text {
//             anchors.centerIn: parent
//             text: notificationModel ? notificationModel.count : 0
//             color: "white"
//             font.pixelSize: 12
//             font.bold: true
//         }
//     }

//     // Notifications container
//     Item {
//         id: notificationContainer
//         anchors.top: titleBar.bottom
//         anchors.left: parent.left
//         anchors.right: parent.right
//         anchors.bottom: parent.bottom
//         anchors.margins: 10

//         Repeater {
//             model: notificationModel

//             Rectangle {
//                 property int myIndex: index
//                 property int totalCount: notificationModel ? notificationModel.count : 0
//                 property int displayIndex: Math.min(visibleCount - 1, totalCount - 1 - myIndex)

//                 visible: myIndex >= Math.max(0, totalCount - visibleCount)

//                 width: notificationContainer.width
//                 height: 80
//                 color: "#444"
//                 radius: 10
//                 border.color: "#888"

//                 // Position from bottom of container
//                 anchors.bottom: notificationContainer.bottom
//                 anchors.bottomMargin: displayIndex * 90

//                 // Smooth position animation
//                 Behavior on anchors.bottomMargin {
//                     NumberAnimation {
//                         duration: 300
//                         easing.type: Easing.OutQuad
//                     }
//                 }

//                 // Ghost stack effect
//                 Item {
//                     anchors.bottom: parent.top
//                     anchors.bottomMargin: -5
//                     visible: myIndex === (totalCount - 1) && visibleCount === 1 && totalCount > 1
//                     width: parent.width
//                     height: 25

//                     Repeater {
//                         model: Math.min(3, totalCount - 1)
//                         Rectangle {
//                             width: parent.width - (index * 8)
//                             height: 8
//                             radius: 4
//                             color: "#88888844"
//                             anchors.horizontalCenter: parent.horizontalCenter
//                             anchors.bottom: parent.bottom
//                             anchors.bottomMargin: index * 5
//                             z: -index - 1
//                             border.color: "#66666666"
//                         }
//                     }
//                 }

//                 Column {
//                     anchors.fill: parent
//                     anchors.margins: 10
//                     spacing: 5

//                     Row {
//                         spacing: 10
//                         width: parent.width

//                         Text {
//                             id: noticeTitle
//                             text: model.title // This comes from C++ model
//                             font.pixelSize: 16
//                             font.bold: true
//                             color: "#fff"
//                             width: parent.width - 30
//                             wrapMode: Text.WordWrap
//                         }

//                         Rectangle {
//                             id: crossIcon
//                             width: 20
//                             height: 20
//                             radius: width / 2
//                             color: "#555"
//                             anchors.verticalCenter: parent.verticalCenter

//                             Text {
//                                 anchors.centerIn: parent
//                                 text: "×"
//                                 font.pixelSize: 14
//                                 color: "white"
//                             }

//                             MouseArea {
//                                 anchors.fill: parent
//                                 preventStealing: true
//                                 propagateComposedEvents: false
//                                 onClicked: {
//                                     mouse.accepted = true
//                                     console.log("Deleting index", myIndex)
//                                     // Use C++ method to remove notification
//                                     notificationModel.removeNotification(myIndex)
//                                 }
//                             }
//                         }
//                     }

//                     Row {
//                         spacing: 10

//                         Text {
//                             text: model.time // This comes from C++ model
//                             font.pixelSize: 12
//                             color: "#bbb"
//                         }

//                         Text {
//                             text: "Type: " + model.type // This comes from C++ model
//                             font.pixelSize: 10
//                             color: "#999"
//                         }
//                     }
//                 }

//                 MouseArea {
//                     anchors.fill: parent
//                     z: -1
//                     onClicked: {
//                         expanded = !expanded
//                         console.log("Expanded:", expanded)
//                     }
//                 }
//             }
//         }
//     }

//     // Empty state
//     Rectangle {
//         visible: notificationModel ? notificationModel.count === 0 : true
//         anchors.centerIn: notificationContainer
//         width: 200
//         height: 60
//         color: "#333"
//         radius: 10
//         border:
//     }
//     }

import QtQuick 2.15
import QtQuick.Controls 2.15


import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: stackArea

    property var notificationModel: []
    property bool notificationExpandedX: false
    property bool expanded: notificationExpandedX
    property int notificationCount:notificationModel.unseenCount
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
            notificationCount=notificationModel.unseenCount
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

                                notificationModel.sourceModel.markAsSeen(index)
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
                    expanded = !expanded
                    notificationModel.markSourceAsSeen(index)
                    console.log("Expanded:", expanded)
                    // notificationModel.markAsSeen(index)
                }
            }
        }
    }
}


/*
Rectangle {
    id: stackArea

    property var notificationModel
    property bool notificationExpandedX: false
    property bool expanded: notificationExpandedX
    property int visibleCount: expanded ? Math.min(notificationCount, 3) : 1

    onNotificationModelChanged:{
        console.log(" -_________ "+noOfNotifications.rowCount())
    }

    height: 80 * visibleCount + 10 * Math.max(0, visibleCount - 1)
    color: "grey"
    border.width: 1
    border.color: "white"

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

        delegate: Rectangle {
            width: stackArea.width - 20
            height: 80
            color: "#444"
            radius: 10
            border.color: "#888"

            property int myIndex: index
            property int displayIndex: Math.min(visibleCount - 1, notificationCount - 1 - index)

            visible: index >= Math.max(0, notificationCount - visibleCount)

            anchors.bottom: stackArea.bottom
            anchors.bottomMargin: 10 + displayIndex * 90
            anchors.horizontalCenter: stackArea.horizontalCenter

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                Row {
                    spacing: 10
                    width: parent.width

                    Text {
                        text: title  // ← use role directly
                        font.pixelSize: 16
                        font.bold: true
                        color: "#fff"
                        width: parent.width - 30
                        wrapMode: Text.WordWrap
                    }

                    Rectangle {
                        width: 20
                        height: 20
                        radius: 10
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
                            onClicked: {
                                notificationModel.removeNotification(myIndex)
                            }
                        }
                    }
                }

                Text {
                    text: time  // ← use role directly
                    font.pixelSize: 12
                    color: "#bbb"
                }
            }
        }
    }
}

*/


/*
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: stackArea

    property var notificationModel: []
    property bool notificationExpandedX: false
    property bool expanded: notificationExpandedX
    property int visibleCount: expanded ? Math.min(notificationModel.count, 3) : 1

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
            color: "#444"
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
                                notificationModel.remove(myIndex)
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
                onClicked: {
                    expanded = !expanded
                    console.log("Expanded:", expanded)
                }
            }
        }
    }
}
*/
