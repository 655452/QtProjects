
/*
import QtQuick
import QtQuick.Controls
RangeSlider {
    id: rangeSlider
    from: 0
    to: 360
    first.value:0
    second.value: 360
    orientation:Qt.Horizontal
    anchors{
        fill: parent
    }

    signal firstValueChanged(int value)
    signal secondValueChanged(int value)
    background: Rectangle {
        id:selectedRangeRect
        x: rangeSlider.leftPadding
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 26
        width: rangeSlider.availableWidth
        height: implicitHeight
        radius: 2
        color: "#bdbebf"

        Rectangle {
            x: rangeSlider.first.visualPosition * parent.width
            width: rangeSlider.second.visualPosition * parent.width - x
            height: parent.height
            color: "#21be2b"
            radius: 2

            // Trying to slider the selected Range ###NOT WORKING###
            MouseArea {
                anchors.fill: parent
                property real dx: 0
                onPressed: dx = mouseX
                // onPositionChanged: {
                //     var d = ((mouseX - dx) / rangeSlider.width) * Math.abs(rangeSlider.to - rangeSlider.from)
                //     if ((d + rangeSlider.first.value) < rangeSlider.from) d = rangeSlider.from - rangeSlider.first.value
                //     if ((d + rangeSlider.second.value) > rangeSlider.to) d = rangeSlider.to - rangeSlider.second.value
                //     rangeSlider.first.value += d
                //     rangeSlider.second.value += d
                //     dx = mouseX
                // }
                onPositionChanged: {
                    var valueDelta = ((mouseX - dx) / rangeSlider.availableWidth) * (rangeSlider.to - rangeSlider.from);

                    var newFirst = rangeSlider.first.value + valueDelta;
                    var newSecond = rangeSlider.second.value + valueDelta;

                    // Clamp within bounds
                    if (newFirst < rangeSlider.from) {
                        newSecond += (rangeSlider.from - newFirst);
                        newFirst = rangeSlider.from;
                    }
                    if (newSecond > rangeSlider.to) {
                        newFirst -= (newSecond - rangeSlider.to);
                        newSecond = rangeSlider.to;
                    }

                    rangeSlider.first.value = newFirst;
                    rangeSlider.second.value = newSecond;

                    dx = mouseX;
                }

            }

        }
    }

    first.handle: Rectangle {
        x: rangeSlider.leftPadding + rangeSlider.first.visualPosition * (rangeSlider.availableWidth - width)
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 15
        implicitHeight: 28
        radius: 3
        color: rangeSlider.first.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    second.handle: Rectangle {
        x: rangeSlider.leftPadding + rangeSlider.second.visualPosition * (rangeSlider.availableWidth - width)
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 15
        implicitHeight: 28
        radius: 3
        color: rangeSlider.second.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    first.onMoved:{
         rangeSlider.firstValueChanged(first.value)
        firstValue = first.value
        updateSeriesLabelPosition()
        updateSeriesLabelPosition2()
    }
    second.onMoved:{
        rangeSlider.secondValueChanged(second.value)
         secondValue = second.value
        updateSeriesLabelPosition()
        updateSeriesLabelPosition2()
    }
}
*/

// ------------------------------------------------------

import QtQuick
import QtQuick.Controls

RangeSlider {
    id: rangeSlider
    from: 0
    to: 360
    first.value: 0
    second.value: 360
    orientation: Qt.Horizontal
    anchors.fill: parent

    signal firstValueChanged(int value)
    signal secondValueChanged(int value)

    background: Rectangle {
        id:selectedRangeRect
        x: rangeSlider.leftPadding
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 26
        width: rangeSlider.availableWidth
        height: implicitHeight
        radius: 2
        color: "#bdbebf"
        Rectangle {
            x: rangeSlider.first.visualPosition * parent.width
            width: rangeSlider.second.visualPosition * parent.width - x
            height: parent.height
            color: "#21be2b"
            radius: 2
}
        // Circular Selection Visual
        // Rectangle {
        //     id: green1
        //     height: parent.height
        //     color: "#21be2b"
        //     radius: 2
        //     y: 0

        //     x: {
        //         if (rangeSlider.first.value <= rangeSlider.second.value) {
        //             return rangeSlider.first.visualPosition * parent.width;
        //         } else {
        //             return rangeSlider.first.visualPosition * parent.width;
        //         }
        //     }

        //     width: {
        //         if (rangeSlider.first.value <= rangeSlider.second.value) {
        //             return (rangeSlider.second.visualPosition - rangeSlider.first.visualPosition) * parent.width;
        //         } else {
        //             return (1.0 - rangeSlider.first.visualPosition) * parent.width;
        //         }
        //     }

        //     visible: rangeSlider.first.value !== rangeSlider.second.value
        // }

        // Rectangle {
        //     id: green2
        //     height: parent.height
        //     color: "#21be2b"
        //     radius: 2
        //     y: 0

        //     x: 0
        //     width: {
        //         if (rangeSlider.first.value > rangeSlider.second.value) {
        //             return rangeSlider.second.visualPosition * parent.width;
        //         } else {
        //             return 0;
        //         }
        //     }

        //     visible: rangeSlider.first.value > rangeSlider.second.value
        // }

        // Drag entire selection
        // MouseArea {
        //     anchors.fill: parent
        //     property real dx: 0

        //     onPressed: dx = mouseX

        //     onPositionChanged: {
        //         var valueDelta = ((mouseX - dx) / rangeSlider.availableWidth) * 360;
        //         dx = mouseX;

        //         var newFirst = (rangeSlider.first.value + valueDelta) % 360;
        //         var newSecond = (rangeSlider.second.value + valueDelta) % 360;

        //         if (newFirst < 0) newFirst += 360;
        //         if (newSecond < 0) newSecond += 360;

        //         rangeSlider.first.value = newFirst;
        //         rangeSlider.second.value = newSecond;
        //     }
        // }
    }

    first.handle: Rectangle {
        x: rangeSlider.leftPadding + rangeSlider.first.visualPosition * (rangeSlider.availableWidth - width)
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 15
        implicitHeight: 28
        radius: 3
        color: rangeSlider.first.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    second.handle: Rectangle {
        x: rangeSlider.leftPadding + rangeSlider.second.visualPosition * (rangeSlider.availableWidth - width)
        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
        implicitWidth: 15
        implicitHeight: 28
        radius: 3
        color: rangeSlider.second.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }
    first.onMoved: {
        first.value = (first.value + 360) % 360

          firstValue = first.value
        rangeSlider.firstValueChanged(first.value)
                updateSeriesLabelPosition()
                updateSeriesLabelPosition2()
    }
    second.onMoved: {
        second.value = (second.value + 360) % 360
           secondValue = second.value
        rangeSlider.secondValueChanged(second.value)
            rangeSlider.secondValueChanged(normalized)
        updateSeriesLabelPosition()
        updateSeriesLabelPosition2()
    }
}


// // ----------------------------------------------------------------old ones
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// // import QtQuick.Canvas 1.15

// Item {
//     id: rangeSlider
//     width: 300
//     height: 300

//     property real from: 0
//     property real to: 360
//     property real firstValue: 0
//     property real secondValue: 90

//     // signal firstValueChanged(int value)
//     // signal secondValueChanged(int value)

//     property real radius: Math.min(width, height) / 2 - 20
//     property real centerX: width / 2
//     property real centerY: height / 2

//     Canvas {
//         id: dialCanvas
//         anchors.fill: parent

//         onPaint: {
//             var ctx = getContext("2d");
//             ctx.clearRect(0, 0, width, height);

//             const startAngle = (rangeSlider.firstValue - 90) * Math.PI / 180;
//             const endAngle = (rangeSlider.secondValue - 90) * Math.PI / 180;

//             // Draw outer circle
//             ctx.beginPath();
//             ctx.strokeStyle = "#bdbebf";
//             ctx.lineWidth = 10;
//             ctx.arc(rangeSlider.centerX, rangeSlider.centerY, rangeSlider.radius, 0, 2 * Math.PI);
//             ctx.stroke();

//             // Draw selection arc
//             ctx.beginPath();
//             ctx.strokeStyle = "#21be2b";
//             ctx.lineWidth = 10;
//             ctx.arc(rangeSlider.centerX, rangeSlider.centerY, rangeSlider.radius,
//                     startAngle, endAngle, false);
//             ctx.stroke();
//         }

//         Connections {
//             target: rangeSlider
//             onFirstValueChanged: dialCanvas.requestPaint()
//             onSecondValueChanged: dialCanvas.requestPaint()
//         }
//     }

//     // First Handle
//     Rectangle {
//         id: firstHandle
//         width: 20
//         height: 20
//         radius: 10
//         color: "#f6f6f6"
//         border.color: "#bdbebf"
//         x: rangeSlider.centerX + rangeSlider.radius * Math.cos((rangeSlider.firstValue - 90) * Math.PI / 180) - width / 2
//         y: rangeSlider.centerY + rangeSlider.radius * Math.sin((rangeSlider.firstValue - 90) * Math.PI / 180) - height / 2

//         MouseArea {
//             anchors.fill: parent
//             drag.target: parent
//             onPositionChanged: {
//                 var dx = mouseX + firstHandle.x + firstHandle.width / 2 - rangeSlider.centerX;
//                 var dy = mouseY + firstHandle.y + firstHandle.height / 2 - rangeSlider.centerY;
//                 var angle = Math.atan2(dy, dx) * 180 / Math.PI + 90;
//                 if (angle < 0) angle += 360;
//                 rangeSlider.firstValue = angle;
//                 rangeSlider.firstValueChanged(Math.round(angle));
//             }
//         }
//     }

//     // Second Handle
//     Rectangle {
//         id: secondHandle
//         width: 20
//         height: 20
//         radius: 10
//         color: "#f6f6f6"
//         border.color: "#bdbebf"
//         x: rangeSlider.centerX + rangeSlider.radius * Math.cos((rangeSlider.secondValue - 90) * Math.PI / 180) - width / 2
//         y: rangeSlider.centerY + rangeSlider.radius * Math.sin((rangeSlider.secondValue - 90) * Math.PI / 180) - height / 2

//         MouseArea {
//             anchors.fill: parent
//             drag.target: parent
//             onPositionChanged: {
//                 var dx = mouseX + secondHandle.x + secondHandle.width / 2 - rangeSlider.centerX;
//                 var dy = mouseY + secondHandle.y + secondHandle.height / 2 - rangeSlider.centerY;
//                 var angle = Math.atan2(dy, dx) * 180 / Math.PI + 90;
//                 if (angle < 0) angle += 360;
//                 rangeSlider.secondValue = angle;
//                 rangeSlider.secondValueChanged(Math.round(angle));
//             }
//         }
//     }

//     onFirstValueChanged: {
//         updateSeriesLabelPosition()
//         updateSeriesLabelPosition2()
//     }

//     onSecondValueChanged: {
//         updateSeriesLabelPosition()
//         updateSeriesLabelPosition2()
//     }
// }
