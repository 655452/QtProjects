import QtQuick
import QtCharts
import QtQuick.Controls
import QtQuick.Layouts

// Rectangle {
//     width: 640
//     height: 480
//     visible: true
//     color: "black"
//     id: chartRect

//     property int minYAxisValue: 0
//     property int maxYAxisValue: 240
//     property int minXAxisValue: 0
//     property int maxXAxisValue: 360

//     property int timeStep: 50
//     // Define the different ranges
//     property var ranges: [
//         {min: 0, max: 15},
//         {min: 0, max: 30},
//         {min: 0, max: 60},
//         {min: 0, max: 120},
//         {min: 0, max: 240}
//     ]
//     // Function to format value as hours and minutes
//     function formatToHoursMinutes(value) {
//         var hours = Math.floor(value / 60)
//         var minutes = Math.floor(value % 60)
//         return hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
//     }

//     // Variable to track the current range index
//     property int currentRangeIndex: 0

//     Rectangle {
//         id: btnBar
//         height: 50
//         width: parent.width
//         anchors.top: parent.top
//         color: "black"

//         Row{
//             anchors.fill:parent
//             spacing: 5
//             Button {
//                 id: timeRange
//                 height: btnBar.height - 5
//                 width: 50

//                 Image {
//                     id: resizeImage
//                     width: 35
//                     height: 35
//                     anchors.centerIn: parent
//                     z: 100
//                     source: "qrc:/icons/resize.png"
//                 }

//                 background: Rectangle {
//                     opacity: enabled ? 1 : 0.3
//                     border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                     border.width: 1
//                     radius: 2
//                 }

//                 // Click event
//                 onClicked: {
//                     console.log("Button clicked")
//                     // Cycle through the ranges sequentially
//                     currentRangeIndex = (chartRect.currentRangeIndex + 1) % chartRect.ranges.length
//                     // Update yAxis min and max based on the current range
//                     yAxis.min = ranges[currentRangeIndex].min
//                     yAxis.max = ranges[currentRangeIndex].max
//                 }
//             }
//             Button{
//                 id:courseUp
//                 height: btnBar.height-5

//                 width: 50
//                 Image {
//                     id: courseImage
//                     width: 35
//                     height: 35
//                     anchors.centerIn: parent
//                     z: 100
//                     source: "qrc:/icons/resize.png"
//                 }
//                 background: Rectangle {
//                     opacity: enabled ? 1 : 0.3
//                     border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                     border.width: 1
//                     radius: 2
//                 }
//             }
//             Button{
//                 id:zoom
//                 height: btnBar.height-5

//                 width: 50
//                 Image {
//                     id: zoomImage
//                     width: 35
//                     height: 35
//                     anchors.centerIn: parent
//                     z: 100
//                     source: "qrc:/icons/reset.png"
//                 }
//                 background: Rectangle {
//                     opacity: enabled ? 1 : 0.3
//                     border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                     border.width: 1
//                     radius: 2
//                 }
//                 // Click event
//                 onClicked: {
//                     console.log("Reset Button clicked")
//                     topAxis.min = 0;
//                     topAxis.max= 360;
//                     yAxis.min = 0;
//                     yAxis.max = 240;
//                 }
//             }
//         }
//     }

//     Rectangle{
//         id: rangeSliderRect
//         width: parent.width
//         height: 40
//         anchors.top: btnBar.bottom
//         anchors.right: parent.right
//         anchors.left: parent.left
//         anchors.leftMargin: 50
//         anchors.rightMargin: 20
//         color: "black"

//         RangeSlider {
//             id: rangeSlider
//             from: 0
//             to: 360
//             first.value:0
//             second.value: 360
//             anchors{
//                 fill: parent
//             }

//             background: Rectangle {
//                 id:selectedRangeRect
//                 x: rangeSlider.leftPadding
//                 y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
//                 implicitWidth: 200
//                 implicitHeight: 26
//                 width: rangeSlider.availableWidth
//                 height: implicitHeight
//                 radius: 2
//                 color: "#bdbebf"

//                 Rectangle {
//                     x: rangeSlider.first.visualPosition * parent.width
//                     width: rangeSlider.second.visualPosition * parent.width - x
//                     height: parent.height
//                     color: "#21be2b"
//                     radius: 2

//                     // Trying to slider the selected Range ###NOT WORKING###
//                     MouseArea {
//                         anchors.fill: parent
//                         property real dx: 0
//                         onPressed: dx = mouseX
//                         onPositionChanged: {
//                             var d = ((mouseX - dx) / rangeSlider.width) * Math.abs(rangeSlider.to - rangeSlider.from)
//                             if ((d + rangeSlider.first.value) < rangeSlider.from) d = rangeSlider.from - rangeSlider.first.value
//                             if ((d + rangeSlider.second.value) > rangeSlider.to) d = rangeSlider.to - rangeSlider.second.value
//                             rangeSlider.first.value += d
//                             rangeSlider.second.value += d
//                             dx = mouseX
//                         }
//                     }

//                 }
//             }

//             first.handle: Rectangle {
//                 x: rangeSlider.leftPadding + rangeSlider.first.visualPosition * (rangeSlider.availableWidth - width)
//                 y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
//                 implicitWidth: 15
//                 implicitHeight: 28
//                 radius: 3
//                 color: rangeSlider.first.pressed ? "#f0f0f0" : "#f6f6f6"
//                 border.color: "#bdbebf"
//             }

//             second.handle: Rectangle {
//                 x: rangeSlider.leftPadding + rangeSlider.second.visualPosition * (rangeSlider.availableWidth - width)
//                 y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
//                 implicitWidth: 15
//                 implicitHeight: 28
//                 radius: 3
//                 color: rangeSlider.second.pressed ? "#f0f0f0" : "#f6f6f6"
//                 border.color: "#bdbebf"
//             }

//             first.onMoved:{ topAxis.min= first.value}
//             second.onMoved:{ topAxis.max= second.value}
//         }
//     }

//     Item {
//         id: waterfall
//         anchors.top: rangeSliderRect.bottom // Position Item just below the btnBar
//         anchors.left: parent.left
//         anchors.right: parent.right
//         anchors.bottom: parent.bottom // Extend Item to bottom of parent

//         ChartView {
//             id: chartView
//             anchors.fill: parent


//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             antialiasing: true
//             backgroundColor: "black"
//             legend.visible: false
//             margins { left: 0; right: 0; top: 0; bottom: 0 } // Example margins

//             ToolTip {
//                 id: toolTip
//                 visible: false
//             }

//             Rectangle{
//                 id: tooltipRect
//                 width: labelName.width + 10
//                 height: labelName.height + 10
//                 border.color: "white"
//                 radius: 5
//                 color: "black"

//                 Text {
//                     id: labelName
//                     color: "white"
//                     text: qsTr("ToolTip")
//                     anchors.centerIn: parent
//                     anchors.margins: 10 // Adds padding around the text
//                     font.pointSize: 5
//                 }
//                 visible: false
//             }

//             ValueAxis {
//                 id: topAxis
//                 min: chartRect.minXAxisValue
//                 max: chartRect.maxXAxisValue
//                 color: "white"
//                 tickCount: 13
//                 gridVisible: false
//                 labelsColor: "white"
//                 labelFormat: "%d"
//                 minorTickCount:5
//                 minorGridVisible: false
//                 // visible:false
//             }
//             CategoryAxis {
//                 id: yAxis
//                 min: -10
//                 max: 240
//                 reverse: true
//                 labelsColor: "white"
//                 labelsPosition: CategoryAxis.AxisLabelsPositionOnValue
//                 gridVisible:false
//                 // Adding categories at specific points
//                 CategoryRange {
//                     label: ""
//                     endValue: -10
//                 }
//                 CategoryRange {
//                     label: "000"
//                     endValue: 0
//                 }
//                 CategoryRange {
//                     label: "040"
//                     endValue: 40
//                 }
//                 CategoryRange {
//                     label: "080"
//                     endValue: 80
//                 }
//                 CategoryRange {
//                     label: "120"
//                     endValue: 120
//                 }
//                 CategoryRange {
//                     label: "160"
//                     endValue: 160
//                 }
//                 CategoryRange {
//                     label: "200"
//                     endValue: 200
//                 }
//                 CategoryRange {
//                     label: "240"
//                     endValue: 240
//                 }
//             }

//             LineSeries {
//                 id: horizontalSeparation
//                 name: "horizontalSeparation"
//                 axisXTop: topAxis
//                 axisY: yAxis
//                 color: "white"
//                 width: 1
//                 XYPoint { x: 0; y: 0 }
//                 XYPoint { x: 360; y: 0}

//             }
//             LineSeries {
//                 id: verticalSeparation
//                 name: "verticalSeparation"
//                 axisXTop: topAxis
//                 axisY: yAxis
//                 color: "white"
//                 width: 1
//                 XYPoint { x: 360; y: 0 }
//                 XYPoint { x: 360; y: -25}
//             }
//             LineSeries {
//                 id: lineSeries1
//                 name: " System"
//                 axisXTop: topAxis
//                 axisY: yAxis
//                 color: "blue"
//                 width:2
//                 // Applying style to the line
//                 style: {
//                     lineWidth: 3   // Set the width of the line
//                     // dashOffset: 5      // Set the dash offset for dashed lines
//                 }
//                 XYPoint { x: 100; y: 0 }
//                 XYPoint { x: 100.1; y: 20.1 }
//                 XYPoint { x: 100.9; y: 30.3 }
//                 XYPoint { x: 100.1; y: 40.1 }
//                 XYPoint { x: 100.9; y: 40.9 }
//                 XYPoint { x: 100.4; y: 50.0 }
//                 XYPoint { x: 100.1; y: 50.3 }
//                 onClicked: console.log("onClicked: " + lineSeries1.name)
//                 onDoubleClicked: console.log("onDoubleClicked: " + lineSeries1.name);

//                 onHovered: function(point, state) {
//                     labelName.text = lineSeries1.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
//                     tooltipRect.visible = state
//                     let p = chartView.mapToPosition(point, lineSeries1)
//                     tooltipRect.x = p.x
//                     tooltipRect.y = p.y - tooltipRect.height
//                     tooltip.visible = !state
//                 }
//             }

//             LineSeries {
//                 id: lineSeries2
//                 name: "Line"
//                 axisXTop: topAxis
//                 axisY: yAxis
//                 color: "green"
//                 width:2
//                 style: {
//                     lineWidth: 3   // Set the width of the line
//                 }
//                 XYPoint { x: 180; y: 0 }
//                 XYPoint { x: 180.1; y: 20.1 }
//                 XYPoint { x: 180.9; y: 30.3 }
//                 XYPoint { x: 180.1; y: 40.1 }
//                 XYPoint { x: 180.9; y: 40.9 }
//                 XYPoint { x: 180.4; y: 50.0 }
//                 XYPoint { x: 180.1; y: 50.3 }
//                 XYPoint { x: 180; y: 60 }
//                 XYPoint { x: 180.1; y: 70.1 }
//                 XYPoint { x: 180.9; y: 80.3 }
//                 XYPoint { x: 180.1; y: 90.1 }
//                 XYPoint { x: 180.9; y: 140.9 }
//                 XYPoint { x: 180.4; y: 150.0 }
//                 XYPoint { x: 180.1; y: 150.3 }

//                 onClicked: console.log("onClicked: " + lineSeries2.name)
//                 onDoubleClicked: console.log("onDoubleClicked: " + lineSeries2.name);

//                 onHovered: function(point, state) {
//                     labelName.text = lineSeries2.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
//                     tooltipRect.visible = state
//                     let p = chartView.mapToPosition(point, lineSeries2)

//                     tooltipRect.x = p.x
//                     tooltipRect.y = p.y - tooltipRect.height
//                     tooltip.visible = !state
//                 }
//             }

//             // Tooltip Text for showing data near the cursor
//             Text {
//                 id: tooltip
//                 visible: false
//                 color: "white"
//                 font.pixelSize: 12
//                 anchors.horizontalCenterOffset: 10
//                 anchors.verticalCenterOffset: -10
//                 font.pointSize: 10 // Change this value to the desired pixel size
//             }

//             Rectangle {
//                 id: seriesLabel
//                 width: seriesLabelName.width + 10
//                 height: seriesLabelName.height + 10
//                 border.color: "white"
//                 radius: 5
//                 color: "black"
//                 z: parent.z + 1
//                 visible: true

//                 // Dynamically position based on mapToPosition
//                 x: {
//                     let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
//                 }
//                 y: {
//                     let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 17;
//                 }

//                 Text {
//                     id: seriesLabelName
//                     color: "white"
//                     text: qsTr("M001")
//                     anchors.centerIn: parent
//                     font.pointSize: 12 // Change this value to the desired pixel size
//                     font.family: "Ubuntu"
//                     font.weight: 500
//                 }
//                 MouseArea{
//                     anchors.fill: parent
//                     onClicked: {
//                         console.log("clicked on the label")
//                     }
//                 }
//                 Component.onCompleted: {
//                     let mappedPosition = chartView.mapToPosition(Qt.point(100.9, 30.3), lineSeries1);
//                     console.log("Mapped Position:", mappedPosition);
//                 }
//             }

//             /* tracking mouse tooltip */
//             MouseArea {
//                 id: chartMouseArea
//                 anchors.fill: parent
//                 hoverEnabled: true

//                 property real plotLeft: chartView.plotArea.x
//                 property real plotRight: chartView.plotArea.x + chartView.plotArea.width
//                 property real plotTop: chartView.plotArea.y
//                 property real plotBottom: chartView.plotArea.y + chartView.plotArea.height

//                 // Minimum Y position to trigger the tooltip (below horizontalSeparation line)
//                 property real minY: 0  // This is the Y value for horizontalSeparation line (set to 0)

//                 onPositionChanged: {
//                     console.log("Mouse position: " + mouseX + ", " + mouseY)

//                     // Check if mouse is within plotArea and below horizontalSeparation
//                     if (mouseX > plotLeft && mouseX < plotRight && mouseY > plotTop && mouseY < plotBottom) {
//                         var chartX = topAxis.min + ((mouseX - plotLeft) / (plotRight - plotLeft)) * (topAxis.max - topAxis.min)
//                         var chartY = yAxis.min + ((mouseY - plotTop) / (plotBottom - plotTop)) * (yAxis.max - yAxis.min)

//                         // Only show the tooltip below the horizontalSeparation series (i.e., chartY > 0)
//                         if (chartY > minY) {
//                             tooltip.text = "Bearing: " + chartX.toFixed(1) + ", Time: " + chartRect.formatToHoursMinutes(chartY)
//                             tooltip.x = mouseX + 10
//                             tooltip.y = mouseY - 10
//                             tooltip.visible = true
//                         } else {
//                             tooltip.visible = false
//                         }
//                     } else {
//                         tooltip.visible = false
//                     }
//                 }

//                 onExited: {
//                     tooltip.visible = false
//                 }
//             }


//         }
//         // Dummy Timer to update the values in lineseries
//         Timer {
//             interval: 1000
//             repeat: true
//             running: true
//             onTriggered: {
//                 chartRect.timeStep += 1;
//                 var x =  100
//                 var y = chartRect.timeStep
//                 lineSeries1.append(x, y );
//             }
//         }
//     }
// }



Rectangle {
    width: 640
    height: 480
    visible: true
    color: "black"
    id: chartRect

    property int minYAxisValue: 0
    property int maxYAxisValue: 240
    property int minXAxisValue: 0
    property int maxXAxisValue: 360

    property int timeStep: 50
    property bool isCircularMode: false
    property real transformProgress: 0.0 // 0 = linear, 1 = circular

    // Animation for transformation
    PropertyAnimation {
        id: transformAnimation
        target: chartRect
        property: "transformProgress"
        duration: 2000
        easing.type: Easing.InOutCubic
        onProgressChanged: {
            // Update all series during animation
            updateCircularTransform()
        }
    }

    // Function to convert bearing/time to circular coordinates
    function polarToCartesian(bearing, time, progress) {
        if (progress === 0) {
            // Linear mode: direct mapping
            return {
                x: bearing,
                y: time
            }
        } else {
            // Circular mode: convert to polar coordinates
            var centerX = 180  // Center bearing
            var centerY = 120  // Center time
            var maxRadius = 120 // Maximum radius for time scale

            // Calculate radius based on time (0-240 minutes)
            var radius = (time / 240) * maxRadius * progress

            // Calculate angle in radians (bearing 0° = top, clockwise)
            var angleRad = (bearing - 90) * Math.PI / 180

            // Convert polar to cartesian, centered in chart space
            var circularX = centerX + radius * Math.cos(angleRad)
            var circularY = centerY + radius * Math.sin(angleRad)

            // Blend between linear and circular based on progress
            return {
                x: bearing * (1 - progress) + circularX * progress,
                y: time * (1 - progress) + circularY * progress
            }
        }
    }

    // Function to update all series for circular transform
    function updateCircularTransform() {
        // Clear existing points
        lineSeries1.clear()
        lineSeries2.clear()
        gridSeries.clear()
        bearingLines.clear()

        // Original data for series 1
        var series1Data = [
            {bearing: 100, time: 0}, {bearing: 100.1, time: 20.1},
            {bearing: 100.9, time: 30.3}, {bearing: 100.1, time: 40.1},
            {bearing: 100.9, time: 40.9}, {bearing: 100.4, time: 50.0},
            {bearing: 100.1, time: 50.3}
        ]

        // Original data for series 2
        var series2Data = [
            {bearing: 180, time: 0}, {bearing: 180.1, time: 20.1},
            {bearing: 180.9, time: 30.3}, {bearing: 180.1, time: 40.1},
            {bearing: 180.9, time: 40.9}, {bearing: 180.4, time: 50.0},
            {bearing: 180.1, time: 50.3}, {bearing: 180, time: 60},
            {bearing: 180.1, time: 70.1}, {bearing: 180.9, time: 80.3},
            {bearing: 180.1, time: 90.1}, {bearing: 180.9, time: 140.9},
            {bearing: 180.4, time: 150.0}, {bearing: 180.1, time: 150.3}
        ]

        // Transform and add points for series 1
        for (var i = 0; i < series1Data.length; i++) {
            var point1 = polarToCartesian(series1Data[i].bearing, series1Data[i].time, transformProgress)
            lineSeries1.append(point1.x, point1.y)
        }

        // Transform and add points for series 2
        for (var j = 0; j < series2Data.length; j++) {
            var point2 = polarToCartesian(series2Data[j].bearing, series2Data[j].time, transformProgress)
            lineSeries2.append(point2.x, point2.y)
        }

        // Add circular grid lines when in circular mode
        if (transformProgress > 0) {
            addCircularGrid()
        }
    }

    // Function to add circular grid (concentric circles and radial lines)
    function addCircularGrid() {
        var centerX = 180
        var centerY = 120

        // Add concentric circles for time ranges
        var timeRanges = [60, 120, 180, 240]
        for (var i = 0; i < timeRanges.length; i++) {
            var radius = (timeRanges[i] / 240) * 120 * transformProgress

            // Create circle points
            for (var angle = 0; angle <= 360; angle += 5) {
                var angleRad = (angle - 90) * Math.PI / 180
                var circleX = centerX + radius * Math.cos(angleRad)
                var circleY = centerY + radius * Math.sin(angleRad)

                var linearPoint = polarToCartesian(angle, timeRanges[i], 0)
                var finalPoint = {
                    x: linearPoint.x * (1 - transformProgress) + circleX * transformProgress,
                    y: linearPoint.y * (1 - transformProgress) + circleY * transformProgress
                }

                gridSeries.append(finalPoint.x, finalPoint.y)
            }
        }

        // Add radial bearing lines
        for (var bearing = 0; bearing < 360; bearing += 30) {
            var startPoint = polarToCartesian(bearing, 0, transformProgress)
            var endPoint = polarToCartesian(bearing, 240, transformProgress)

            bearingLines.append(startPoint.x, startPoint.y)
            bearingLines.append(endPoint.x, endPoint.y)
        }
    }

    // Define the different ranges
    property var ranges: [
        {min: 0, max: 15},
        {min: 0, max: 30},
        {min: 0, max: 60},
        {min: 0, max: 120},
        {min: 0, max: 240}
    ]

    // Function to format value as hours and minutes
    function formatToHoursMinutes(value) {
        var hours = Math.floor(value / 60)
        var minutes = Math.floor(value % 60)
        return hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
    }

    // Variable to track the current range index
    property int currentRangeIndex: 0

    Rectangle {
        id: btnBar
        height: 50
        width: parent.width
        anchors.top: parent.top
        color: "red"

        Row{
            anchors.fill:parent
            spacing: 5

            Button {
                id: timeRange
                height: btnBar.height - 5
                width: 50

                Text {
                    anchors.centerIn: parent
                    text: "Range"
                    color: "white"
                    font.pointSize: 8
                }

                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color: timeRange.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }

                onClicked: {
                    console.log("Button clicked")
                    currentRangeIndex = (chartRect.currentRangeIndex + 1) % chartRect.ranges.length
                    yAxis.min = ranges[currentRangeIndex].min
                    yAxis.max = ranges[currentRangeIndex].max
                }
            }

            // Transform button
            Button{
                id: transformButton
                height: btnBar.height-5
                width: 80

                Text {
                    anchors.centerIn: parent
                    text: chartRect.isCircularMode ? "Linear" : "Circular"
                    color: "white"
                    font.pointSize: 10
                }

                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color: transformButton.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }

                onClicked: {
                    chartRect.isCircularMode = !chartRect.isCircularMode
                    transformAnimation.to = chartRect.isCircularMode ? 1.0 : 0.0
                    transformAnimation.start()

                    // Adjust chart view for circular mode
                    if (chartRect.isCircularMode) {
                        topAxis.min = 0
                        topAxis.max = 360
                        yAxis.min = 0
                        yAxis.max = 240
                        topAxis.visible = false
                        yAxis.visible = false
                    } else {
                        topAxis.visible = true
                        yAxis.visible = true
                    }
                }
            }

            Button{
                id:zoom
                height: btnBar.height-5
                width: 50

                Text {
                    anchors.centerIn: parent
                    text: "Reset"
                    color: "white"
                    font.pointSize: 8
                }

                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color: zoom.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }

                onClicked: {
                    console.log("Reset Button clicked")
                    topAxis.min = 0;
                    topAxis.max= 360;
                    yAxis.min = 0;
                    yAxis.max = 240;

                    // Reset to linear mode
                    chartRect.isCircularMode = false
                    transformAnimation.to = 0.0
                    transformAnimation.start()
                    topAxis.visible = true
                    yAxis.visible = true
                }
            }
        }
    }

    Rectangle{
        id: rangeSliderRect
        width: parent.width
        height: 40
        anchors.top: btnBar.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.rightMargin: 20
        color: "black"

        opacity: chartRect.isCircularMode ? 0.3 : 1.0

        RangeSlider {
            id: rangeSlider
            from: 0
            to: 360
            first.value:0
            second.value: 360
            enabled: !chartRect.isCircularMode
            anchors{
                fill: parent
            }

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

            first.onMoved:{ if (!chartRect.isCircularMode) topAxis.min = first.value}
            second.onMoved:{ if (!chartRect.isCircularMode) topAxis.max = second.value}
        }
    }

    Item {
        id: waterfall
        anchors.top: rangeSliderRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ChartView {
            id: chartView
            anchors.fill: parent

            Layout.fillWidth: true
            Layout.fillHeight: true
            antialiasing: true
            backgroundColor: "black"
            legend.visible: false
            margins { left: 0; right: 0; top: 0; bottom: 0 }

            ValueAxis {
                id: topAxis
                min: chartRect.minXAxisValue
                max: chartRect.maxXAxisValue
                color: "white"
                tickCount: 13
                gridVisible: false
                labelsColor: "white"
                labelFormat: "%d"
                minorTickCount:5
                minorGridVisible: false
            }

            ValueAxis {
                id: yAxis
                min: chartRect.minYAxisValue
                max: chartRect.maxYAxisValue
                reverse: !chartRect.isCircularMode // Don't reverse in circular mode
                labelsColor: "white"
                gridVisible: false
                color: "white"
            }

            // Grid series for circular mode
            ScatterSeries {
                id: gridSeries
                name: "Grid"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                markerSize: 1
                borderColor: "white"
                borderWidth: 0
            }

            // Bearing lines for circular mode
            LineSeries {
                id: bearingLines
                name: "BearingLines"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
            }

            LineSeries {
                id: lineSeries1
                name: "System"
                axisXTop: topAxis
                axisY: yAxis
                color: "blue"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        // Calculate original bearing and time for tooltip
                        var originalBearing = chartRect.isCircularMode ?
                            calculateOriginalBearing(point.x, point.y) : point.x
                        var originalTime = chartRect.isCircularMode ?
                            calculateOriginalTime(point.x, point.y) : point.y

                        tooltipText.text = lineSeries1.name +
                            "\nBearing: " + originalBearing.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(originalTime)
                        tooltipRect.visible = true
                        let p = chartView.mapToPosition(point, lineSeries1)
                        tooltipRect.x = p.x
                        tooltipRect.y = p.y - tooltipRect.height
                    } else {
                        tooltipRect.visible = false
                    }
                }
            }

            LineSeries {
                id: lineSeries2
                name: "Target"
                axisXTop: topAxis
                axisY: yAxis
                color: "green"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        var originalBearing = chartRect.isCircularMode ?
                            calculateOriginalBearing(point.x, point.y) : point.x
                        var originalTime = chartRect.isCircularMode ?
                            calculateOriginalTime(point.x, point.y) : point.y

                        tooltipText.text = lineSeries2.name +
                            "\nBearing: " + originalBearing.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(originalTime)
                        tooltipRect.visible = true
                        let p = chartView.mapToPosition(point, lineSeries2)
                        tooltipRect.x = p.x
                        tooltipRect.y = p.y - tooltipRect.height
                    } else {
                        tooltipRect.visible = false
                    }
                }
            }

            // Functions to calculate original values from circular coordinates
            function calculateOriginalBearing(x, y) {
                if (!chartRect.isCircularMode) return x

                var centerX = 180
                var centerY = 120
                var dx = x - centerX
                var dy = y - centerY
                var bearing = (Math.atan2(dy, dx) * 180 / Math.PI + 90 + 360) % 360
                return bearing
            }

            function calculateOriginalTime(x, y) {
                if (!chartRect.isCircularMode) return y

                var centerX = 180
                var centerY = 120
                var dx = x - centerX
                var dy = y - centerY
                var radius = Math.sqrt(dx * dx + dy * dy)
                var time = (radius / 120) * 240
                return Math.max(0, Math.min(240, time))
            }

            Rectangle{
                id: tooltipRect
                width: tooltipText.width + 10
                height: tooltipText.height + 10
                border.color: "white"
                radius: 5
                color: "black"
                visible: false

                Text {
                    id: tooltipText
                    color: "white"
                    text: "Tooltip"
                    anchors.centerIn: parent
                    font.pointSize: 10
                }
            }
        }

        // Initialize with linear data
        Component.onCompleted: {
            updateCircularTransform()
        }
    }
}
