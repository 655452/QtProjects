import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
Rectangle {
    id: parentRect
    width: parent.width
    height: parent.height
    color: "transparent"
    border.color: "darkblue"
    border.width: 2
    Text {
        anchors.top: parent.top
        text: " Main Lib"
        font.pixelSize: 20
    }

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
            Layout.alignment: Qt.AlignCenter
            color: "lightgreen"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.1
        }
        Rectangle {
            id: zone2
            Layout.alignment: Qt.AlignRight
            color: "lightblue"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.8
        }
        Rectangle {
            id: zone3
            Layout.alignment: Qt.AlignBottom
            color: "whitesmoke"
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.1
        }
    }

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
}

