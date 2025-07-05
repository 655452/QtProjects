// import QtQuick

// Window {
//     width: 640
//     height: 480
//     visible: true
//     title: qsTr("Hello World")
//     Repeater{
//         model:["F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12"]
//         Rectangle{
//             Text{
//                 text:modeData
//             }
//             Text{
//                 text:activeKeyData[modelData]
//             }
//             MouseArea{
//                 anchors.fill:parent
//                 onClicked:{

//                 }
//             }
//         }
//     }
// }
// main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import "ActionMap.js" as ActionMap

ApplicationWindow {
    id:root
    visible: true
    width: 400
    height: 600
    title: "Function Key Navigator"
    function callByStringPath(pathString, scope) {
        let parts = pathString.split(".")
        let context = scope || QtObject.root  // ✅ OR pass `this` explicitly from your component

        for (let i = 0; i < parts.length; i++) {
            if (!context[parts[i]]) {
                console.warn("Property not found:", parts[i])
                return
            }
            context = context[parts[i]]
        }

        if (typeof context === "function") {
            context()
        } else {
            console.warn("Resolved value is not a function:", pathString)
        }
    }




    MouseArea {
        id:mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton)
                contextMenu.popup()
        }
        onPressAndHold: {
            if (mouse.source === Qt.MouseEventNotSynthesized)
                contextMenu.popup()
        }

        Menu {
            id: contextMenu
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
    }
    Column {
        anchors.centerIn: parent
        spacing: 20

        Row{
            spacing:2
            Repeater{
                model:["DASHBOARD","TMA","C3","C4"]
                Rectangle{
                    width:50
                    height:50
                    color:"gray"
                    Text {
                        id: name
                        anchors.centerIn:parent
                        text: modelData
                    }
                    MouseArea{
                        anchors.fill:parent
                        onClicked:{
                            navigator.setComponent(modelData)
                        }
                    }
                }
            }
        }

        Text {
            text: "Current Node Action: " + navigator.currentAction
            font.pixelSize: 16
            wrapMode: Text.WordWrap
        }



        Repeater {
            model: navigator.currentChildren
            delegate: Rectangle {
                width: parent.width * 0.8
                height: 60
                color:navigator.currentKey===modelData?"gray":"lightgray"
                radius: 5
                border.color: "gray"
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 5

                    Text {
                        text: modelData
                        font.bold: true
                    }

                    Text {
                        text: navigator.activeKeyData[modelData] || "--"
                        wrapMode: Text.WordWrap
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    function evaluate(str){eval(str)}
                    onClicked:{
                        if(modelData==="F9"){
                            navigator.traverseBackward()
                        }else{

                            // callByStringPath("actionEventManager.activeFunct1")
                            // eval("actionEventManager.activeFunct1", this)

                            evaluate(navigator.activeKeyData[modelData])

                            // let functionName = "activeFunct1"
                            // let target = actionEventManager

                            // if (typeof target[functionName] === "function") {
                            //     target[functionName]()  // ✅ calls dynamically
                            // } else {
                            //     console.warn("Function not found:", functionName)
                            // }
                            // eval("actionEventManager.activeFunct1()")
                            // actionEventManager.activeFunct1()
                            // navigator.activeKeyData[modelData]
                            navigator.traverseForward(index)
                            // ActionMap.dispatch(navigator.currentAction)

                            // actionEventManager.triggerAction(navigator.activeKeyData[modelData])

                        }
                    }
                }
            }
        }
        // Action
        Button {
            text: "Back"
            onClicked: navigator.traverseBackward()
        }
    }
}

// -------------------------------------------------------------------------------
// import QtQuick
// import QtQuick.Controls 2.15

// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 300
//     title: "Copy Action Demo"

//     property string lastCopied: ""

//     // ✅ Shared Copy Action
//     Action {
//         id: copyAction
//         text: "Copy"
//         shortcut: StandardKey.Copy
//         enabled: textInput.activeFocus && textInput.selectionLength > 0
//         onTriggered: {
//             textInput.copy()
//             lastCopied = textInput.selectedText
//             console.log("Copied:", lastCopied)
//         }
//     }

//     menuBar: MenuBar {
//         Menu {
//             title: "Edit"
//             MenuItem {
//                 action: copyAction
//             }
//         }
//     }

//     Column {
//         anchors.centerIn: parent
//         spacing: 10

//         TextArea {
//             id: textInput
//             width: parent.width * 0.9
//             height: 150
//             wrapMode: Text.Wrap
//             placeholderText: "Type something and select text..."
//         }

//         Button {
//             action: copyAction
//         }

//         Text {
//             text: lastCopied.length > 0 ? "Copied: " + lastCopied : ""
//             font.pixelSize: 14
//             color: "green"
//         }
//     }
// }
