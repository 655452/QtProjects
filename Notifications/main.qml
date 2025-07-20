
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: "Notification Stack"
    color: "#222"



    // ListModel {
    //     id: noticeModel
    //     ListElement { title: "System notice"; time: "10:00 AM" }
    //     ListElement { title: "New notice"; time: "10:05 AM" }
    //     ListElement { title: "Battery notice"; time: "10:15 AM" }
    //     ListElement { title: "Download notice"; time: "10:20 AM" }
    //     ListElement { title: "Meeting notice"; time: "10:30 AM" }
    //     ListElement { title: "Weather notice"; time: "10:35 AM" }
    //     ListElement { title: "Flight notice"; time: "10:45 AM" }
    //     ListElement { title: "New update"; time: "11:00 AM" }
    // }


    // property var notifications: {
    //     "notice":noticeModel,
    //     "warnings":warningModel,
    //     "alert":aleartModel
    // }


    // ListModel {
    //     id: warningModel
    //     ListElement{ title: "System warnings"; time: "10:00 AM" }
    //     ListElement{ title: "New warnings"; time: "10:05 AM" }
    //     ListElement{ title: "Battery warnings"; time: "10:15 AM" }
    //     ListElement{ title: "Download warnings"; time: "10:20 AM" }
    //     ListElement{ title: "Meeting warnings"; time: "10:30 AM" }
    //     ListElement{ title: "Weather warnings"; time: "10:35 AM" }
    //     ListElement{ title: "Flight warnings"; time: "10:45 AM" }
    //     ListElement{ title: "New warnings"; time: "11:00 AM" }
    //     ListElement{ title: "Missed warnings"; time: "11:10 AM" }

    // }

    // ListModel {
    //     id: aleartModel
    //     ListElement{ title: "System Update"; time: "10:00 AM" }
    //     ListElement{ title: "New Message"; time: "10:05 AM" }
    //     ListElement{ title: "Battery Low"; time: "10:15 AM" }
    //     ListElement{ title: "Download Complete"; time: "10:20 AM" }
    //     ListElement{ title: "Meeting Reminder"; time: "10:30 AM" }
    //     ListElement{ title: "Weather Alert"; time: "10:35 AM" }
    //     ListElement{ title: "Flight Delay"; time: "10:45 AM" }
    //     ListElement{ title: "New Offer"; time: "11:00 AM" }
    //     ListElement{ title: "Missed Call"; time: "11:10 AM" }

    // }
    property var notifications: ({
        "notice": noticeModel,
        "warnings": warningModel,
        "alert": alertModel
    })

    property bool notificationExpanded :false
    Connections{
        target:noticeModel
        onExpandedChanged:{
            notificationExpanded=!notificationExpanded
        }
    }

    Grid{
     // spacing:20
        columns:2
        columnSpacing:20
        rowSpacing:20
        Row {
            id: topButtons

            Rectangle {
                width: 70
                height: 28
                radius: 14
                color: "#555"
                border.color: "#888"
                Text {
                    anchors.centerIn: parent
                    text: notificationExpanded ? "Collapse" : "View All"
                    font.pixelSize: 12
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        notificationExpanded = !notificationExpanded
                    }
                }
            }

            Button {
                text: "Add Notice"
                onClicked: {

                    notificationMod.notice.addNotification("new "," notice "+Math.random())
                    // notifications.notice.addNotification("Newly Added", "12:30 PM"+Math.random())
                }
            }


            Rectangle {
                width: 70
                height: 28
                radius: 14
                color: "#c00"
                border.color: "#888"
                Text {
                    anchors.centerIn: parent
                    text: "Clear All"
                    font.pixelSize: 12
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // notifications.notice.clear()
                        // notifications.warnings.clear()
                        notificationMod.notice.clear()
                    }
                }
            }
        }

        // MyStackArea {
        //     id: notice
        //     // height: 320
        //     width: 300
        //     // anchors.bottom: parent.bottom          // ← Anchor from bottom
        //     // anchors.bottomMargin: 160
        //     notificationModel:notificationMod.notice
        //     // notificationModel:notificationMod.unseenNotice

        //     // notificationModel:noticeModel
        //     notificationExpandedX:notificationExpanded
        // }j
        AllNotification{

                id: notice
                // height: 320
                width: 300
                // anchors.bottom: parent.bottom          // ← Anchor from bottom
                // anchors.bottomMargin: 160
                notificationModel:notificationMod.notice
                // notificationModel:notificationMod.unseenNotice

                // notificationModel:noticeModel
                notificationExpandedX:notificationExpanded
        }

        MyStackArea {
            id: unseenNotice
            // height: 320
            width: 300
            // anchors.bottom: parent.bottom          // ← Anchor from bottom
            // anchors.bottomMargin: 160
            // notificationModel:notificationMod.notice
            notificationModel:notificationMod.unseenNotice

            // notificationModel:noticeModel
            notificationExpandedX:notificationExpanded

        }

        // MyStackArea {
        //     // id: stackArea
        //     id:warnings
        //     // height: 320
        //     width: 300
        //     // anchors.bottom: parent.bottom          // ← Anchor from bottom
        //     // anchors.bottomMargin: 20
        //     notificationModel:notificationMod.warning
        //     // notificationModel:warningModel
        //     notificationExpandedX:notificationExpanded
        // }
    }
    Component.onCompleted:{
        console.log("---------------------"+JSON.stringify(noticeModel)+noticeModel.rowCount())
    }
}

