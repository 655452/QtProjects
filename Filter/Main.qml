import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects
ApplicationWindow {
    visible: true
    width: 400
    height: 200
    color:"transparent"

    ListModel {
        id: comboModel

        ListElement {
            name: "Combo1"
            expanded: false
            additionalExpanded: false
            checked:false
            hasAdditional: true
            parameters:[
                ListElement { name: "Parameter A"},
                ListElement { name: "Parameter B" }
            ]
        }

        ListElement {
            name: "Combo2"
            expanded: false
            additionalExpanded: false
            checked:false
            hasAdditional: true
            parameters:[
                ListElement { name: "Parameter A" },
                ListElement { name: "Parameter B" }
            ]
        }

        ListElement {
            name: "Combo3"
            expanded: false
            additionalExpanded: false
            checked:false
            hasAdditional: false
            parameters: [
                ListElement { name: "nothing" }
            ]
        }
    }
    ListModel {
        id: comboModel2

        ListElement {
            name: "Combo12"
            expanded: false
            checked:false
            additionalExpanded: false
            hasAdditional: false
            parameters:[
                ListElement { name: "nothing" }
            ]
        }

        ListElement {
            name: "Combo22"
            expanded: false
            checked:false
            additionalExpanded: false
            hasAdditional: false
            parameters:[
                ListElement { name: "nothing" }
            ]
        }

        ListElement {
            name: "Combo3"
            expanded: false
            checked:false
            additionalExpanded: false
            hasAdditional: false
            parameters: [
                ListElement { name: "nothing" }
            ]
        }
    }

    ListModel {
        id: comboModel3

        ListElement {
            name: "Combo13"
            expanded: false
            additionalExpanded: false
            hasAdditional: false
            checked:false
            parameters:[
                ListElement { name: "Parameter A3" },
                ListElement { name: "Parameter B3" }
            ]
        }

        ListElement {
            name: "Combo23"
            expanded: false
            additionalExpanded: false
            hasAdditional: false
            checked:false
            parameters:[
                ListElement { name: "Parameter A33" },
                ListElement { name: "Parameter B33" }
            ]
        }

        ListElement {
            name: "Combo3"
            expanded: false
            additionalExpanded: false
            hasAdditional: false
            checked:false
            parameters: [
                ListElement { name: "nothing" }
            ]
        }
    }
    property var filterData:{
        "AllTags":"All Tags",
        "TagsData":[
                    { title: "Tag 1", model: comboModel,checked:false },
                    { title: "Tag 2", model: comboModel2,checked:false },
                    { title: "Tag 3", model: comboModel3,checked:false }
                ]
    }


    // This property holds reference to currently selected section
    property var selectedSection: null
    property real widestSectionWidth: 0  // <-- added


    Item{
        id:target
        // width:columnExpandable.implicitWidth
        // height:parent.height
        width:400
        height:400

        Text{
            text:"dfssssssssssssssssss"
            anchors.centerIn:parent
        }
        Rectangle{
            width:200
            height:200
            color:"transparent"
            MouseArea{
                anchors.fill:parent
                drag.target:parent
            }
        }

        Rectangle{
            // width:400
            width:columnExpandable.implicitWidth
            height:parent.height
            color:"transparent"
            // anchors.right:parent.right
            border.width:1


            Column{
                id:columnExpandable
                // anchors.fill:parent
                spacing:10

                // for Tags Find for better Approach Always
                CheckBox {
                    id: headerCheck
                    // width:expandableColumn.implicitWidth
                    width: columnExpandable.widestSectionWidth
                    // checked: tagChecked

                    onCheckedChanged: {
                        let updatedTagsData = [];
                        for (let i = 0; i < filterData.TagsData.length; ++i) {
                            const tag = filterData.TagsData[i];
                            updatedTagsData.push({
                                                     title: tag.title,
                                                     model: tag.model,
                                                     checked: checked,
                                                 });
                        }

                        filterData = {
                            AllTags: filterData.AllTags,
                            TagsData: updatedTagsData
                        };
                    }
                    indicator: Item {}
                    contentItem: Row {
                        spacing: 10
                        padding: 10
                        height: 40

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 4
                            border.color: "black"
                            color: headerCheck.checked ? "whitesmoke" : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: headerCheck.checked ? "\u2713" : ""
                                color: "black"
                                font.pixelSize: 16
                                font.bold: true
                            }
                        }

                        Text {
                            text: filterData.AllTags
                            color: "white"
                            font.pixelSize: 16
                        }
                    }

                    background: Rectangle {
                        color: "transparent"
                        border.width: 1
                        border.color: "white"
                    }
                }

                Repeater {
                    model: filterData.TagsData
                    // model:tagsDataModel
                    delegate: Component {
                        MyExpandableSection {
                            id: section
                            title: modelData.title
                            comboModel: modelData.model

                            Component.onCompleted: {
                                // Update widest width after section is completed
                                if (implicitWidth > columnExpandable.widestSectionWidth) {
                                    columnExpandable.widestSectionWidth = implicitWidth
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
