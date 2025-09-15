import QtQuick

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
            // MouseArea {
            //     anchors.fill: parent
            //     property real dx: 0
            //     onPressed: dx = mouseX
            //     // onPositionChanged: {
            //     //     var d = ((mouseX - dx) / rangeSlider.width) * Math.abs(rangeSlider.to - rangeSlider.from)
            //     //     if ((d + rangeSlider.first.value) < rangeSlider.from) d = rangeSlider.from - rangeSlider.first.value
            //     //     if ((d + rangeSlider.second.value) > rangeSlider.to) d = rangeSlider.to - rangeSlider.second.value
            //     //     rangeSlider.first.value += d
            //     //     rangeSlider.second.value += d
            //     //     dx = mouseX
            //     // }
            //     onPositionChanged: {
            //         var valueDelta = ((mouseX - dx) / rangeSlider.availableWidth) * (rangeSlider.to - rangeSlider.from);

            //         var newFirst = rangeSlider.first.value + valueDelta;
            //         var newSecond = rangeSlider.second.value + valueDelta;

            //         // Clamp within bounds
            //         if (newFirst < rangeSlider.from) {
            //             newSecond += (rangeSlider.from - newFirst);
            //             newFirst = rangeSlider.from;
            //         }
            //         if (newSecond > rangeSlider.to) {
            //             newFirst -= (newSecond - rangeSlider.to);
            //             newSecond = rangeSlider.to;
            //         }

            //         rangeSlider.first.value = newFirst;
            //         rangeSlider.second.value = newSecond;

            //         dx = mouseX;
            //     }

            // }

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
