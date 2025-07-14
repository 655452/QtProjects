// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Effects
// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 200
//     color:"transparent"

//     /* glass effect
//     Item{
//         id:target
//         width:400
//         height:400
//         Rectangle {
//             width: 200
//             height: 100
//             color:"whitesmoke"
//             border.width:1
//             border.color:"white"
//             MouseArea{
//                 anchors.fill:parent
//                 drag.target:parent
//             }
//         }
//         Text{
//             anchors.centerIn:parent
//             text:"kjfsdkjfsdkfsdkmkmlfd"
//         }
//     }


//     ShaderEffectSource {
//         id:effectSource
//                anchors.fill:target
//                 sourceItem: target
//                 sourceRect:Qt.rect(target.x,target.y,target.width,target.height)
//             }

//     MultiEffect {
//         source: effectSource
//         anchors.fill: effectSource
//         brightness: 0.0
//         saturation: 0.0
//         blurEnabled: true
//         blurMax: 64
//         blur: blurSlider.value
//     }
//         // gradient: Gradient {
//         //     GradientStop { position: 0; color: "white" }
//         //     GradientStop { position: 1; color: "black" }
//         // }
//       Column{
//             anchors.right:parent.right

//                 Slider {
//                     id: blurSlider
//                     from: 0
//                     to: 1
//                     value: 0.0
//                     width: 300
//                 }



//             Slider {
//                 id: saturationSlider
//                 from: -1.0
//                 to: 1.0
//                 value: 0.0
//                 width: 300
//             }
//         }
// */


//     ListModel {
//         id: comboModel

//         ListElement {
//             name: "Combo1"
//             expanded: false
//             additionalExpanded: false
//             checked:false
//             hasAdditional: true
//             parameters:[
//                 ListElement { name: "Parameter A"},
//                 ListElement { name: "Parameter B" }
//             ]
//         }

//         ListElement {
//             name: "Combo2"
//             expanded: false
//             additionalExpanded: false
//             checked:false
//             hasAdditional: true
//             parameters:[
//                 ListElement { name: "Parameter A" },
//                 ListElement { name: "Parameter B" }
//             ]
//         }

//         ListElement {
//             name: "Combo3"
//             expanded: false
//             additionalExpanded: false
//             checked:false
//             hasAdditional: false
//             parameters: [
//                 ListElement { name: "nothing" }
//             ]
//         }
//     }
//     ListModel {
//         id: comboModel2

//         ListElement {
//             name: "Combo12"
//             expanded: false
//             checked:false
//             additionalExpanded: false
//             hasAdditional: false
//             parameters:[
//                 ListElement { name: "nothing" }
//             ]
//         }

//         ListElement {
//             name: "Combo22"
//             expanded: false
//             checked:false
//             additionalExpanded: false
//             hasAdditional: false
//             parameters:[
//                 ListElement { name: "nothing" }
//             ]
//         }

//         ListElement {
//             name: "Combo3"
//             expanded: false
//             checked:false
//             additionalExpanded: false
//             hasAdditional: false
//             parameters: [
//                 ListElement { name: "nothing" }
//             ]
//         }
//     }

//     ListModel {
//         id: comboModel3

//         ListElement {
//             name: "Combo13"
//             expanded: false
//             additionalExpanded: false
//             hasAdditional: false
//             checked:false
//             parameters:[
//                 ListElement { name: "Parameter A3" },
//                 ListElement { name: "Parameter B3" }
//             ]
//         }

//         ListElement {
//             name: "Combo23"
//             expanded: false
//             additionalExpanded: false
//             hasAdditional: false
//             checked:false
//             parameters:[
//                 ListElement { name: "Parameter A33" },
//                 ListElement { name: "Parameter B33" }
//             ]
//         }

//         ListElement {
//             name: "Combo3"
//             expanded: false
//             additionalExpanded: false
//             hasAdditional: false
//             checked:false
//             parameters: [
//                 ListElement { name: "nothing" }
//             ]
//         }
//     }
//     property var filterData:{
//         "AllTags":"All Tags",
//         "TagsData":[
//                     { title: "Tag 1", model: comboModel,checked:false },
//                     { title: "Tag 2", model: comboModel2,checked:false },
//                     { title: "Tag 3", model: comboModel3,checked:false }
//                 ]
//     }


//     // This property holds reference to currently selected section
//     property var selectedSection: null
//     property real widestSectionWidth: 0  // <-- added


//     Item{
//         id:target
//         // width:columnExpandable.implicitWidth
//         // height:parent.height
//         width:400
//         height:400
//         ShaderEffectSource {
//             id:effectSource
//                    anchors.fill:target
//                     sourceItem: target
//                     sourceRect:Qt.rect(target.x,target.y,target.width,target.height)
//                 }

//         MultiEffect {
//             source: effectSource
//             anchors.fill: effectSource
//             brightness: 0.0
//             saturation: 0.0
//             blurEnabled: true
//             blurMax: 64
//             // blur: blurSlider.value
//             blur:1.0
//         }

//         Text{
//             text:"dfssssssssssssssssss"
//             anchors.centerIn:parent
//         }
//         Rectangle{
//             width:200
//             height:200
//             color:"transparent"
//             MouseArea{
//                 anchors.fill:parent
//                 drag.target:parent
//             }
//         }


// /*
//     Rectangle{
//         // width:400
//         width:columnExpandable.implicitWidth
//         height:parent.height
//         color:"transparent"
//         // anchors.right:parent.right
//         border.width:1


//         Column{
//             id:columnExpandable
//             // anchors.fill:parent
//             spacing:10

//             // for Tags Find for better Approach Always
//             CheckBox {
//                 id: headerCheck
//                 // width:expandableColumn.implicitWidth
//                 width: columnExpandable.widestSectionWidth
//                 // checked: tagChecked

//                 onCheckedChanged: {
//                     let updatedTagsData = [];
//                     for (let i = 0; i < filterData.TagsData.length; ++i) {
//                         const tag = filterData.TagsData[i];
//                         updatedTagsData.push({
//                                                  title: tag.title,
//                                                  model: tag.model,
//                                                  checked: checked,
//                                              });
//                     }

//                     filterData = {
//                         AllTags: filterData.AllTags,
//                         TagsData: updatedTagsData
//                     };
//                 }
//                 indicator: Item {}
//                 contentItem: Row {
//                     spacing: 10
//                     padding: 10
//                     height: 40

//                     Rectangle {
//                         width: 20
//                         height: 20
//                         radius: 4
//                         border.color: "black"
//                         color: headerCheck.checked ? "whitesmoke" : "transparent"

//                         Text {
//                             anchors.centerIn: parent
//                             text: headerCheck.checked ? "\u2713" : ""
//                             color: "black"
//                             font.pixelSize: 16
//                             font.bold: true
//                         }
//                     }

//                     Text {
//                         text: filterData.AllTags
//                         color: "white"
//                         font.pixelSize: 16
//                     }
//                 }

//                 background: Rectangle {
//                     color: "transparent"
//                     border.width: 1
//                     border.color: "white"
//                 }
//             }

//             Repeater {
//                 model: filterData.TagsData
//                 // model:tagsDataModel
//                 delegate: Component {
//                     MyExpandableSection {
//                         id: section
//                         title: modelData.title
//                         comboModel: modelData.model

//                         Component.onCompleted: {
//                             // Update widest width after section is completed
//                             if (implicitWidth > columnExpandable.widestSectionWidth) {
//                                 columnExpandable.widestSectionWidth = implicitWidth
//                             }
//                         }
//                     }
//                 }

//             }

//         }
//     }
// */
//     }
// }

// ------------------------notifications-------------------------

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
        // }

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


