import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

/*
Rectangle {
    id: parentRect
    width: 720
    height: 480
    color: "transparent"

    // Zone 1
    Rectangle {
        id: zone1
        objectName: "zone1"
        property alias zone1Item: zone1 // Added alias
        width: parentRect.width
        height: parentRect.height * 0.2
        anchors.top: parentRect.top
        color: "lightgray"
    }

    // Zone 2
    Rectangle {
        id: zone2
        objectName: "zone2"
        property alias zone2Item: zone2 // Added alias
        width: parentRect.width
        height: parentRect.height * 0.6
        anchors.top: zone1.bottom
        color: "lightblue"
    }

    // Zone 3
    Rectangle {
        id: zone3
        objectName: "zone3"
        property alias zone3Item: zone3 // Added alias
        width: parentRect.width
        height: parentRect.height * 0.2
        anchors.top: zone2.bottom
        color: "lightgreen"
    }
}
*/


Rectangle {
    id: parentRect
    width: parent.width
    height: parent.height
    color: "transparent"
    border.color: "darkblue"
    border.width: 2

    // ------------------------------------------------------Just Function Key Handling Part ----------------------------------------------------------------------
    focus: true  // Ensures key events are captured
    Keys.enabled: true // Enable key events
    property var loadFunctionKeyMapping:smartMainLibrary.loadFunctionKeyMapping("/home/asit/Documents/AsitEmpire/ARCH/SmartMainLibrary/FunctionKeyPanel.xml");
    property var activeComponent:""

    property var lastLoadedPopup: ""

    Keys.onPressed: (event) => {
                        console.log("Key Pressed:", event.key, "Active Component:", activeComponent);
                        KeyManager.triggerKeyPressKeyEvents(event.key);
                        if (activeComponent !== "") {
                            if (event.key === Qt.Key_U) {
                                if (lastLoadedPopup !== "") {
                                    console.log("Unloading:", lastLoadedPopup);
                                    smartMainLibrary.unloadComponentFromZone(qmlEngine, lastLoadedPopup, "zone5");
                                    lastLoadedPopup = ""; // Reset after unloading
                                } else {
                                    console.log("No popup to unload.");
                                }
                            } else {
                                let popupName = smartMainLibrary.getPopupForKey(activeComponent, event.key);
                                let popupLibpath = smartMainLibrary.getPopupLibPath(popupName);

                                console.log("Popup Name:", popupName, "Popup Path:", popupLibpath);

                                if (popupName !== "") {
                                    console.log("Loading popup:", popupName);
                                    smartMainLibrary.loadComponentInZone(qmlEngine, popupLibpath, popupName, "zone5");
                                    lastLoadedPopup = popupName; // Store last loaded popup
                                }
                            }
                        }
                    };

    // --------------------------------------------------------------------------------------------------------------------------------------------------------------
    Text {
        anchors.top: parent.top
        text: " Main Lib"
        font.pixelSize: 20
    }

    // Unload Button
    // Button {
    //     id:unloadComponent
    //     z:45
    //     text: "Unload PopUp in mainscreen"
    //     anchors.verticalCenter:parent.verticalCenter
    //     onClicked: {
    //         // smartMainLibrary.unloadComponentFromZone(qmlEngine, "popup", "zone4")
    //         smartMainLibrary.unloadComponentFromZone(qmlEngine, "popup", "zone5")
    //         smartMainLibrary.unloadComponentFromZone(qmlEngine, "popup", "zone6")
    //     }
    // }
    // Button {
    //     id:loadComponent
    //     z:45
    //     text: "Load PopUp in mainscreen"
    //     anchors.top:unloadComponent.bottom
    //     onClicked: {
    //         // smartMainLibrary.loadComponentInZone(qmlEngine,"/home/asit/PopUp/lib/libPopUp.so", "popup", "zone4");
    //         smartMainLibrary.loadComponentInZone(qmlEngine,"/home/asit/PopUp/lib/libPopUp.so", "popup", "zone5");
    //         smartMainLibrary.loadComponentInZone(qmlEngine,"/home/asit/PopUp/lib/libPopUp.so", "popup", "zone6");
    //     }
    // }
    // ----------------------sidebar For laoding Components --------------------------------------------------------------------

    // -----------on mouse Events--------------------------
    Connections {
        target: KeyManager
        onKeyPressedMouseEvents: (key, popupName) => {
        console.log("Loading Popup:", popupName);
        let popupLibpath = smartMainLibrary.getPopupLibPath(popupName);
        console.log("Popup Name:", popupName, "Popup Path:", popupLibpath);
        if (popupName !== "") {
            console.log("Loading popup:", popupName);
            smartMainLibrary.loadComponentInZone(qmlEngine, popupLibpath, popupName, "zone5");
            lastLoadedPopup = popupName; // Store last loaded popup
        }
      }
    }
    ColumnLayout {
        id: sidebar
        spacing: 10
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Layout.alignment: Qt.AlignVCenter
        z: parent.z + 10

        Repeater {
            model: ["c1", "c2", "c3", "c4"]
            RoundButton {
                z: 45
                text: modelData
                background:Rectangle{
                    border.width:2
                }

                onClicked: {
                    activeComponent = modelData
                    console.log("Active component --- > " + activeComponent)
                    KeyManager.activeComponent = modelData;
                }
            }
        }
    }

    ColumnLayout {
        id: rightPanel
        spacing: 10
        anchors.left: sidebar.right
        anchors.leftMargin: 20
        anchors.verticalCenter: sidebar.verticalCenter
        Layout.alignment: Qt.AlignVCenter
        z:parent.z+10
        Rectangle {
            objectName: "zone4"
            width: 200
            height: 100
            color: "gray"
        }
        Rectangle {
            objectName: "zone5"
            width: 200
            height: 100
            color: "red"
        }

        Rectangle {
            objectName: "zone6"
            width: 200
            height: 100
            color: "green"
        }

        Rectangle {
            objectName: "zone7"
            width: 200
            height: 100
            color: "blue"
        }
    }


    // ----------------------------------------------------------------------------------------------------
    RoundButton {
        z:45
        text: "\u2713" // Unicode Character 'CHECK MARK'
        onClicked:{
            if(columnlayout.visible===true){
                columnlayout.visible=false
                rowlayout.visible=true

                childMainScreen.parent=rowmain
                childHeader.parent=rowfooter
            }
            else{
                columnlayout.visible=true
                rowlayout.visible=false

                childMainScreen.parent=colmain
                childHeader.parent=colheader
            }
        }
    }

    RowLayout {
        id: rowlayout
        anchors.fill: parent
        spacing: 6
        Rectangle {
            id:rowfooter
            // objectName: "zone5"
            color: 'teal'
            Layout.fillWidth: true
            // Layout.minimumWidth: 100
            Layout.preferredWidth: parent.width*0.5
            Layout.preferredHeight: parent.height
            Text {
                anchors.centerIn: parent
                text: parent.width + 'x' + parent.height
            }
        }
        Rectangle {
            id:rowmain
            color: 'plum'
            // objectName: "zone6"
            Layout.fillWidth: true
            // Layout.minimumWidth: 100
            Layout.preferredWidth: parent.width*0.5
            Layout.preferredHeight: parent.height
            Text {
                anchors.centerIn: parent
                text: parent.width + 'x' + parent.height
            }
        }
    }

    ColumnLayout{
        id:columnlayout
        anchors.fill: parent
        spacing: 2
        Rectangle {
            id: zone1
            objectName: "zone1"
            property alias zone1Item: zone1 // Added alias
            Layout.alignment: Qt.AlignCenter
            color: "lightgreen"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.1
        }
        Rectangle {
            id: zone2
            objectName: "zone2"
            property alias zone2Item: zone2 // Added alias
            Layout.alignment: Qt.AlignRight
            color: "lightblue"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.8
        }
        Rectangle {
            id: zone3
            objectName: "zone3"
            property alias zone3Item: zone3 // Added alias
            Layout.alignment: Qt.AlignBottom
            color: "whitesmoke"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.1
        }
        // Rectangle {
        //     id: zone4
        //     objectName: "zone4"
        //     property alias zone4Item: zone4 // Added alias
        //     Layout.alignment: Qt.AlignBottom
        //     // anchors.top:parent.top
        //     z:45
        //     color: "whitesmoke"
        //     Layout.preferredWidth: parent.width
        //     Layout.preferredHeight: parent.height*0.3
        // }

    }

    /*
    Component.onCompleted: {
        console.log("child components alingin begins")
        // console.log(header)
        // console.log(mainscreen)
        // footer.parent=zone3
        // console.log(footer)

        for(var i = 0 ; i <= components.length; i++){
            if(components[i] === "header"){
                header.parent= zone1
                console.log("Header implemented ", components[i])
            }
            if(components[i] === "mainscreen"){
                mainscreen.parent= zone2
                console.log("mainscreen implemented ", components[i])
            }
            if(components[i] === "footer"){
                footer.parent= zone3
                console.log("Footer implemented ", components[i])
            }
        }

        // console.log(footer)
        // header.parent=colheader
        // mainscreen.parent=colmain
        rowlayout.visible=false
        // footer.parent=colfooter
    }
*/
}
