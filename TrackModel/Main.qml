import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Effects
import MyApp.Models 1.0
import QtQuick.Shapes


ApplicationWindow {
    width: 800
    height: 600
    visible: true
    property bool nominatedItemVisible:false
    function updateTreeModelForClassification(classification) {
        TreeModel.clearAll()  // You must implement this in your TreeModel C++ class

        for (let i = 0; i < centralData.Items.length; ++i) {
            let item = centralData.Items[i]
            if (item.classification === classification) {
                TreeModel.addtreeCategoryData(item)
            }
        }
    }

    function updateItemField(index, fieldName, fieldValue) {
        // Step 1: Copy full centralData
        // Step 1: Deep copy centralData
        let newData = JSON.parse(JSON.stringify(centralData));

        // Step 2: Update the specific field of the item
        if (newData.Items && index >= 0 && index < newData.Items.length) {
            newData.Items[index][fieldName] = fieldValue;
        } else {
            console.warn("Invalid index or Items missing");
            return;
        }

        // Step 3: Replace the full centralData to trigger update
        centralData = newData;

        // Step 4: Update the TreeModel (optional, if using TreeModel)
        // TreeModel.setAllItems(centralData.Items);
    }

    Item {
        id: trackEditor
        width: 280
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 8

        Rectangle {
            anchors.fill: parent
            color: "#f0f0f0"
            radius: 6
            border.color: "#999"
            border.width: 1
            z: 999

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 6

                Label {
                    text: "Item State Editor"
                    font.bold: true
                    font.pointSize: 14
                }

                ListView {
                    id: itemList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: centralData.Items
                    delegate: Rectangle {
                        width: parent.width
                        height: 80
                        color: "#ffffff"
                        radius: 4
                        border.color: "#ccc"
                        border.width: 1
                        anchors.margins: 4

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 8

                            Text {
                                text: modelData.name
                                font.bold: true
                            }

                            RowLayout {
                                spacing: 8

                                Button {
                                    text:centralData.Items[index].nominate? "Un-Nominate" : "Nominate"
                                    onClicked: {
                                        updateItemField(index, "nominate", !modelData.nominate)
                                        console.log(JSON.stringify(modelData))
                                        // centralData.Items[index].nominate=!centralData.Items[index].nominate
                                    }
                                }

                                Button {
                                    text: centralData.Items[index].promote?"Un-Promote" : "Promote"
                                    onClicked: {
                                        console.log(JSON.stringify(modelData))
                                        updateItemField(index, "promote", !modelData.nominate)
                                    }
                                }

                                Button {
                                    text:centralData.Items[index].adopt? "Un-Adopt" : "Adopt"
                                    onClicked: {

                                        updateItemField(index, "adopt", !modelData.nominate)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        color:"gray"
        height:drawer.implicitHeight
        width:drawer.implicitWidth

        Column {
            id: drawer
            // width: parent.width
            spacing: 20

            // Top-level tab bar
            TabBar {
                id: mainTabBar
                spacing: 8
                width:mainStack.implicitWidth
                Repeater {
                    // model:centralData.tabs
                    model: centralData.treeCategoryData
                    TabButton {
                        id: tabBtn
                        text: modelData.name
                        height: 50
                        checkable: true
                        font.bold: checked  // Optional: make text bold if selected

                        background: Item {
                            anchors.fill: parent

                            // Main background rectangle with gradient
                            Rectangle {
                                anchors.fill: parent
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#109175" }
                                    GradientStop { position: 1.0; color: "#1fcfa1" }
                                }
                                radius: 6
                            }

                            // Bottom border when selected
                            Rectangle {
                                width: parent.width
                                height: 4
                                color: "white" // change as needed
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                visible: tabBtn.checked  // Only show when selected
                                opacity: 0.9

                                Behavior on visible {
                                    PropertyAnimation { duration: 150 }
                                }
                            }
                        }
                    }
                }
            }

            StackLayout {
                id: mainStack
                currentIndex: mainTabBar.currentIndex
                property int maxInnerTabBarWidth: 0
                property string currentCategory: ""

                Repeater {
                    model: centralData.treeCategoryData[mainTabBar.currentIndex].category

                    Column {
                        id: expandContainer
                        property int lastExpandedIndex: -1

                        TabBar {
                            id: innerTabBar
                            height: 50
                            spacing: 4
                            width: mainStack.maxInnerTabBarWidth > 0 ? mainStack.maxInnerTabBarWidth : implicitWidth
                            property var currentcategory: centralData.treeCategoryData[mainTabBar.currentIndex].category || []

                            Component.onCompleted: {
                                // Delay to let implicitWidth calculate
                                Qt.callLater(() => {
                                                 const w = innerTabBar.implicitWidth;
                                                 if (w > mainStack.maxInnerTabBarWidth) {
                                                     mainStack.maxInnerTabBarWidth = w;
                                                 }
                                             });
                            }
                            Repeater {
                                model: innerTabBar.currentcategory
                                TabButton {
                                    text: modelData
                                    height: 40
                                    checked: modelData === innerTabBar.currentcategory
                                    // MouseArea{
                                    //     anchors.fill: parent
                                    //     onClicked: {
                                    //         mainStack.currentCategory = modelData
                                    //     }
                                    // }
                                    onCheckedChanged:{
                                        if(checked){
                                            mainStack.currentCategory = modelData
                                        }
                                    }

                                    background: Rectangle {
                                        anchors.fill: parent
                                        gradient: RadialGradient {
                                            centerX: 0.5; centerY: 0.5; centerRadius: 0.9
                                            GradientStop { position: 0.0; color: "#ffffff" }
                                            GradientStop { position: 1.0; color: checked?"lightblue":"#dddddd" }
                                        }
                                    }
                                }
                            }
                        }

                        Button{
                            text:"nominate"
                            background:Rectangle{
                                color:nominatedItemVisible?"lightgreen":"white"
                                // color:"black"
                            }

                            onClicked:{
                                console.log("nominated")
                                nominatedItemVisible=!nominatedItemVisible
                            }
                        }

                        Repeater {
                            model: centralData.treeCategoryData[mainTabBar.currentIndex].classification
                            ExpandableSection {
                                width: parent.width
                                title: modelData
                                tabColor: "lightsteelblue"

                                // Properties to store local context
                                property string classification: modelData
                                property string treeCategory: centralData.treeCategoryData[mainTabBar.currentIndex].name
                                property string category: mainStack.currentCategory
                                property bool nominateVisible:nominatedItemVisible
                                property var centralDataItems:centralData

                                TreeModel {
                                    id: localModel
                                }

                                treeModel: localModel
                                expanded: index === expandContainer.lastExpandedIndex

                                onCentralDataItemsChanged:{
                                    localModel.setAllItems(centralData.Items)
                                    localModel.resetWithFilter(classification, treeCategory, category,nominatedItemVisible)
                                }

                                onCategoryChanged:
                                {

                                    noOfItems=localModel.resetWithFilter(classification, treeCategory, category,nominatedItemVisible)
                                }
                                onNominateVisibleChanged:{
                                    noOfItems=localModel.resetWithFilter(classification, treeCategory, category,nominatedItemVisible)

                                }

                                Component.onCompleted: {
                                    // Populate the model right away
                                    Qt.callLater(() => {
                                                     localModel.setAllItems(centralData.Items)
                                                     localModel.resetWithFilter(classification, treeCategory, category,nominatedItemVisible)
                                                     noOfItems=localModel.getVisibleItemCount()
                                                     console.log(" noOfItem ---> "+noOfItems)
                                                 })
                                    // noOfItems = localModel.getVisibleItemCount()

                                }
                                onExpandedChanged: {
                                    if (expanded) {
                                        localModel.resetWithFilter(classification, treeCategory, category,nominatedItemVisible)
                                        noOfItems=localModel.getVisibleItemCount()
                                        expandContainer.lastExpandedIndex = index
                                    }
                                    // noOfItems = localModel.getVisibleItemCount()
                                }

                            }
                        }
                    }
                }
            }
        }
    }
}
