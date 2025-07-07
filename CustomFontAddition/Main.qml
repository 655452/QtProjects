import QtQuick

import QtQuick.Controls
import QtQuick.Shapes

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // Font  Family
    FontLoader{
        id:myFont
        source:"qrc:/ManufacturingConsent-Regular.ttf"
    }

    Label{
        text:"Asit"
        font.family:myFont.name
        font.pixelSize:50
        padding:12
        background:Rectangle{
            color:"red"
        }
    }
    Shape{
        ShapePath {
        //         strokeWidth: 4
        //         strokeColor: "black"
        //         // strokeStyle: ShapePath.DashLine
        //         dashPattern: [ 1, 4 ]
        //         startX: 20; startY: 20
        strokeWidth:2
        strokeColor:"black"
        fillColor:"transparent"
        startX:20
        startY:20
                PathLine { x: 20; y: 130 }
                PathLine { x: 130; y:130 }
                // PathLine { x: 20; y: 20 }
            }
    }
}
