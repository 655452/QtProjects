import QtQuick
import QtCharts
import QtQuick.Controls
import QtQuick.Layouts
import com.example.ChartManager 1.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.3
import QtQuick.Layouts 1.3
/*
Rectangle {
    width: 1000
    height: 850
    visible: true
    color: "black"
    id: chartRect

    // Create an instance of ChartManager
    ChartManager {
        id: chartManager
    }
    property int minXAxisValue: chartManager.minXAxisValue
    property int maxXAxisValue: chartManager.maxXAxisValue

    // Access and modify properties from C++
    property int minYAxisValue: chartManager.minYAxisValue
    property int maxYAxisValue: chartManager.maxYAxisValue
    property var ranges: chartManager.ranges
    property int timeStep: chartManager.timeStep

    // Range of the Top axis
    property int firstValue
    property int secondValue

    // Polar view toggle
    property bool showPolarView: false

    function updateYAxisLabels(currentRangeIndex) {
        // Update the min and max values of the yAxis based on the selected range
        yAxis.min = ranges[currentRangeIndex].min
        yAxis.max = ranges[currentRangeIndex].max

        var preLabels =  yAxis.categoriesLabels

        for(var i=0; i < preLabels.length; i++) { yAxis.remove(preLabels[i])}
        // Add the new labels based on the selected range
        var newLabels = ranges[currentRangeIndex].labels;
        for (var i = 0; i < newLabels.length; i++) {
            if (newLabels[i]) { // Only append non-empty labels
                yAxis.append(newLabels[i], parseInt(newLabels[i]));
            }
        }
        console.log("Updated Labels:", yAxis.categoriesLabels)
    }

    function updateSeriesLabelPosition() {
        // Example series data point (use actual series data)
        let seriesDataX = 100.9;  // X coordinate of the data point
        let seriesDataY = 30.3;   // Y coordinate of the data point

        // Map the data point (seriesDataX, seriesDataY) to pixel coordinates
        let mappedPosition = chartView.mapToPosition(Qt.point(seriesDataX, seriesDataY), lineSeries1);

        // Calculate the label's X position (centered around the mapped position)
        let labelX = Math.max(chartView.plotArea.x, Math.min(mappedPosition.x, chartView.plotArea.x + chartView.plotArea.width - seriesLabel.width)) - seriesLabel.width / 2;
        if (topAxis.min <= seriesDataX && seriesDataX <= topAxis.max ){
            seriesLabel.x = labelX;
            seriesLabel.visible = true;
        }
        else{
            seriesLabel.visible = false;
        }
    }

    function updateSeriesLabelPosition2() {
        // Example series data point (use actual series data)
        let seriesDataX = 180;  // X coordinate of the data point
        let seriesDataY = 0;   // Y coordinate of the data point

        // Map the data point (seriesDataX, seriesDataY) to pixel coordinates
        let mappedPosition = chartView.mapToPosition(Qt.point(seriesDataX, seriesDataY), lineSeries2);

        // Calculate the label's X position (centered around the mapped position)
        let labelX = Math.max(chartView.plotArea.x, Math.min(mappedPosition.x, chartView.plotArea.x + chartView.plotArea.width - seriesLabel2.width)) - seriesLabel2.width / 2;
        if (topAxis.min <= seriesDataX && seriesDataX <= topAxis.max ){
            seriesLabel2.x = labelX;
            seriesLabel2.visible = true;
        }
        else{
            seriesLabel2.visible = false;
        }
    }

    // Function to format value as hours and minutes
    function formatToHoursMinutes(value) {
        var hours = Math.floor(value / 60)
        var minutes = Math.floor(value % 60)
        return hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
    }

    // Variable to track the current range index
    property int currentRangeIndex: 0
    property int currentAngle: 40

    Rectangle{
        id: btnBar
        height: 50
        width: parent.width
        anchors.top: parent.top
        color: "black"

        Row{
            anchors.fill:parent
            spacing: 5
            Button{
                id: timeRange
                height: btnBar.height - 5
                width: 50

                Image {
                    id: resizeImage
                    width: 35
                    height: 35
                    anchors.centerIn: parent
                    z: 100
                    source: "qrc:/icons/resize.png"
                }

                background: Rectangle{
                    opacity: enabled ? 1 : 0.3
                    border.color: timeRange.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }

                // Click event
                onClicked: {
                    minorTickCount: 2
                    console.log("Button clicked")
                    // Cycle through the ranges sequentially
                    currentRangeIndex = (chartRect.currentRangeIndex + 1) % chartRect.ranges.length
                    // Update yAxis min and max based on the current range
                    // Update the labels based on the new range
                    chartRect.updateYAxisLabels(currentRangeIndex);
                }
            }
            Button{
                id:courseUp
                height: btnBar.height-5
                width: 50
                Image {
                    id: courseImage
                    width: 35
                    height: 35
                    anchors.centerIn: parent
                    z: 100
                    source: "qrc:/icons/zoom.png"
                }
                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color: timeRange.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }
            }
            Button{
                id:zoom
                height: btnBar.height-5
                width: 50
                Image {
                    id: zoomImage
                    width: 35
                    height: 35
                    anchors.centerIn: parent
                    z: 100
                    source: "qrc:/icons/reset.png"
                }
                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color: timeRange.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                }
                // Click event
                onClicked: {
                    console.log("Reset Button clicked")
                    topAxis.min = 0;
                    topAxis.max= 360;
                    yAxis.min = -7;
                    yAxis.max = 240;
                }
            }

            // New Polar View Toggle Button
            Button{
                id: polarToggle
                height: btnBar.height - 5
                width: 80
                text: showPolarView ? "Linear" : "Polar"

                background: Rectangle{
                    opacity: enabled ? 1 : 0.3
                    border.color: polarToggle.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    radius: 2
                    color: showPolarView ? "#2d5a2f" : "transparent"
                }

                onClicked: {
                    showPolarView = !showPolarView
                    if (showPolarView) {
                        polarChart.updateDataFromLinearChart()
                    }
                }
            }
        }
    }

    Rectangle{
        id: rangeSliderRect
        width: parent.width
        height: 200
        anchors.top: btnBar.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.rightMargin: 20
        color: "black"

        RangeSliderWaterFall{
            id: rangeSlider
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
            visible: !showPolarView

            Layout.fillWidth: true
            Layout.fillHeight: true
            antialiasing: true
            backgroundColor: "black"
            legend.visible: false
            margins { left: 0; right: 0; top: 0; bottom: 0 }

            Rectangle{
                id: tooltipRect
                width: labelName.width + 10
                height: labelName.height + 10
                border.color: "white"
                radius: 2
                color: "black"

                Text {
                    id: labelName
                    color: "white"
                    text: qsTr("ToolTip")
                    anchors.centerIn: parent
                    anchors.margins: 10
                    font.family: "Ubuntu"
                    font.pointSize: 7
                    font.weight: 500
                }
                visible: false
            }

            ValueAxis {
                id: topAxis
                min: chartRect.firstValue
                max: chartRect.secondValue
                color: "white"
                tickCount: 13
                gridVisible: false
                labelsColor: "white"
                labelFormat: "%d"
                minorTickCount:5
                minorGridVisible: false
            }

            CategoryAxis {
                id: yAxis
                min: -7
                max: 240
                reverse: true
                labelsColor: "white"
                labelsPosition: CategoryAxis.AxisLabelsPositionOnValue
                minorTickCount: 2
                gridVisible:false

                CategoryRange {
                    label: ""
                    endValue: -10
                }
                CategoryRange {
                    label: "000"
                    endValue: 0
                }
                CategoryRange {
                    label: "040"
                    endValue: 40
                }
                CategoryRange {
                    label: "080"
                    endValue: 80
                }
                CategoryRange {
                    label: "120"
                    endValue: 120
                }
                CategoryRange {
                    label: "160"
                    endValue: 160
                }
                CategoryRange {
                    label: "200"
                    endValue: 200
                }
                CategoryRange {
                    label: "240"
                    endValue: 240
                }
            }

            LineSeries {
                id: horizontalSeparation
                name: "horizontalSeparation"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
                XYPoint { x: 0; y: 0 }
                XYPoint { x: 360; y: 0}
            }

            LineSeries {
                id: verticalSeparation
                name: "verticalSeparation"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
                XYPoint { x: 360; y: 0 }
                XYPoint { x: 360; y: -13}
            }

            LineSeries {
                id: lineSeries1
                name: "Own System"
                axisXTop: topAxis
                axisY: yAxis
                color: "blue"
                width:2

                XYPoint { x: 100; y: 0 }
                XYPoint { x: 100.1; y: 20.1 }
                XYPoint { x: 100.9; y: 30.3 }
                XYPoint { x: 100.1; y: 40.1 }
                XYPoint { x: 100.9; y: 40.9 }
                XYPoint { x: 100.4; y: 50.0 }
                XYPoint { x: 100.1; y: 50.3 }

                onClicked: console.log("onClicked: " + lineSeries1.name)
                onDoubleClicked: console.log("onDoubleClicked: " + lineSeries1.name);

                onHovered: function(point, state) {
                    labelName.text = lineSeries1.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                    tooltipRect.visible = state
                    let p = chartView.mapToPosition(point, lineSeries1)
                    tooltipRect.x = p.x
                    tooltipRect.y = p.y - tooltipRect.height
                    tooltip.visible = !state
                }
            }

            LineSeries {
                id: lineSeries2
                name: "Line"
                axisXTop: topAxis
                axisY: yAxis
                color: "green"
                width:2

                XYPoint { x: 180; y: 0 }
                XYPoint { x: 180.1; y: 20.1 }
                XYPoint { x: 180.9; y: 30.3 }
                XYPoint { x: 180.1; y: 40.1 }
                XYPoint { x: 180.9; y: 40.9 }

                onClicked: console.log("onClicked: " + lineSeries2.name)
                onDoubleClicked: console.log("onDoubleClicked: " + lineSeries2.name);
                onHovered: function(point, state) {
                    labelName.text = lineSeries2.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                    tooltipRect.visible = state
                    let p = chartView.mapToPosition(point, lineSeries2)
                    tooltipRect.x = p.x
                    tooltipRect.y = p.y - tooltipRect.height
                    tooltip.visible = !state
                }
            }

            MouseTrackerTooltip{
                id: tooltip
            }

            TrackLabel{
                id: seriesLabel
                labelName: "OWN"
                x: {
                    let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
                    Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
                }
                y: {
                    let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
                    Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
                }
            }

            TrackLabel{
                id: seriesLabel2
                labelName: "MN220"
                x: {
                    let position = chartView.mapToPosition(Qt.point(180, 0), lineSeries2);
                    Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
                }
                y: {
                    let position = chartView.mapToPosition(Qt.point(180, 0), lineSeries2);
                    Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
                }
            }

            MouseArea {
                id: chartMouseArea
                anchors.fill: parent
                hoverEnabled: true

                property real plotLeft: chartView.plotArea.x
                property real plotRight: chartView.plotArea.x + chartView.plotArea.width
                property real plotTop: chartView.plotArea.y
                property real plotBottom: chartView.plotArea.y + chartView.plotArea.height
                property real minY: 0

                onPositionChanged: {
                    if (mouseX > plotLeft && mouseX < plotRight && mouseY > plotTop && mouseY < plotBottom) {
                        var chartX = topAxis.min + ((mouseX - plotLeft) / (plotRight - plotLeft)) * (topAxis.max - topAxis.min)
                        var chartY = yAxis.min + ((mouseY - plotTop) / (plotBottom - plotTop)) * (yAxis.max - yAxis.min)

                        if (chartY > minY) {
                            tooltip.text = "Bearing: " + chartX.toFixed(1) + ", Time: " + chartRect.formatToHoursMinutes(chartY)
                            tooltip.x = mouseX + 10
                            tooltip.y = mouseY - 10
                            tooltip.visible = true
                        } else {
                            tooltip.visible = false
                        }
                    } else {
                        tooltip.visible = false
                    }
                }

                onExited: {
                    tooltip.visible = false
                }
            }
        }

        // POLAR CHART IMPLEMENTATION
        Item {
            id: polarChart
            anchors.fill: parent
            visible: showPolarView

            property real centerX: width / 2
            property real centerY: height / 2
            property real innerRadius: 60
            property real outerRadius: Math.min(width, height) / 2.5
            property real maxTime: 240
            property real maxBearing: 360
            property var series1Data: []
            property var series2Data: []

            // Convert bearing to radians (0° at top, clockwise)
            function bearingToRadians(bearing) {
                return (bearing - 90) * Math.PI / 180;
            }

            // Convert time to radius
            function timeToRadius(time) {
                if (time < 0) return innerRadius;
                return innerRadius + (time / maxTime) * (outerRadius - innerRadius);
            }

            // Convert polar coordinates to cartesian
            function polarToCartesian(bearing, time) {
                var angle = bearingToRadians(bearing);
                var radius = timeToRadius(time);
                return {
                    x: centerX + radius * Math.cos(angle),
                    y: centerY + radius * Math.sin(angle)
                };
            }

            // Convert cartesian to polar coordinates
            function cartesianToPolar(x, y) {
                var dx = x - centerX;
                var dy = y - centerY;
                var distance = Math.sqrt(dx * dx + dy * dy);
                var bearing = (Math.atan2(dy, dx) * 180 / Math.PI + 90 + 360) % 360;
                var time = Math.max(0, (distance - innerRadius) / (outerRadius - innerRadius) * maxTime);
                return { bearing: bearing, time: time, distance: distance };
            }

            // Update data from linear chart
            function updateDataFromLinearChart() {
                series1Data = [];
                series2Data = [];

                // Extract data from LineSeries1
                for (var i = 0; i < lineSeries1.count; i++) {
                    var point = lineSeries1.at(i);
                    series1Data.push({ bearing: point.x, time: point.y });
                }

                // Extract data from LineSeries2
                for (var j = 0; j < lineSeries2.count; j++) {
                    var point = lineSeries2.at(j);
                    series2Data.push({ bearing: point.x, time: point.y });
                }

                polarCanvas.requestPaint();
            }

            Canvas {
                id: polarCanvas
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    // Draw time rings (concentric circles)
                    ctx.strokeStyle = "rgba(255, 255, 255, 0.3)";
                    ctx.lineWidth = 1;
                    ctx.font = "12px Arial";
                    ctx.fillStyle = "white";

                    for (var time = 0; time <= polarChart.maxTime; time += 40) {
                        var radius = timeToRadius(time);
                        ctx.beginPath();
                        ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
                        ctx.stroke();

                        // Time labels
                        if (time > 0) {
                            var timeLabel = formatToHoursMinutes(time);
                            ctx.fillText(timeLabel, centerX + radius + 5, centerY + 5);
                        }
                    }

                    // Draw bearing lines (every 30 degrees)
                    ctx.strokeStyle = "rgba(255, 255, 255, 0.2)";
                    ctx.lineWidth = 1;

                    for (var bearing = 0; bearing < 360; bearing += 30) {
                        var angle = bearingToRadians(bearing);
                        var startRadius = innerRadius;
                        var endRadius = outerRadius;

                        ctx.beginPath();
                        ctx.moveTo(centerX + startRadius * Math.cos(angle),
                                  centerY + startRadius * Math.sin(angle));
                        ctx.lineTo(centerX + endRadius * Math.cos(angle),
                                  centerY + endRadius * Math.sin(angle));
                        ctx.stroke();

                        // Bearing labels
                        var labelRadius = outerRadius + 25;
                        var labelX = centerX + labelRadius * Math.cos(angle);
                        var labelY = centerY + labelRadius * Math.sin(angle);

                        ctx.fillStyle = "white";
                        ctx.textAlign = "center";
                        ctx.textBaseline = "middle";
                        ctx.fillText(bearing + "°", labelX, labelY);
                    }

                    // Draw center point
                    ctx.fillStyle = "white";
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, 3, 0, 2 * Math.PI);
                    ctx.fill();

                    // Draw horizontal reference line (bearing 0)
                    ctx.strokeStyle = "white";
                    ctx.lineWidth = 2;
                    ctx.beginPath();
                    ctx.moveTo(centerX, centerY - innerRadius);
                    ctx.lineTo(centerX, centerY - outerRadius);
                    ctx.stroke();

                    // Draw data series
                    drawPolarSeries(ctx, series1Data, "blue", "OWN", 3);
                    drawPolarSeries(ctx, series2Data, "green", "MN220", 3);
                }

                function drawPolarSeries(ctx, data, color, name, pointSize) {
                    if (!data || data.length === 0) return;

                    ctx.strokeStyle = color;
                    ctx.fillStyle = color;
                    ctx.lineWidth = 2;

                    // Draw connecting lines
                    ctx.beginPath();
                    for (var i = 0; i < data.length; i++) {
                        var point = polarToCartesian(data[i].bearing, data[i].time);
                        if (i === 0) {
                            ctx.moveTo(point.x, point.y);
                        } else {
                            ctx.lineTo(point.x, point.y);
                        }
                    }
                    ctx.stroke();

                    // Draw data points
                    for (var j = 0; j < data.length; j++) {
                        var point = polarToCartesian(data[j].bearing, data[j].time);
                        ctx.beginPath();
                        ctx.arc(point.x, point.y, pointSize, 0, 2 * Math.PI);
                        ctx.fill();

                        // Draw point outline
                        ctx.strokeStyle = "white";
                        ctx.lineWidth = 1;
                        ctx.stroke();
                        ctx.strokeStyle = color;
                        ctx.lineWidth = 2;
                    }

                    // Draw track labels at the first point
                    if (data.length > 0) {
                        var firstPoint = polarToCartesian(data[0].bearing, data[0].time);
                        ctx.fillStyle = color;
                        ctx.font = "bold 12px Arial";
                        ctx.textAlign = "center";
                        ctx.fillText(name, firstPoint.x, firstPoint.y - 15);
                    }
                }

                function formatToHoursMinutes(value) {
                    var hours = Math.floor(value / 60);
                    var minutes = Math.floor(value % 60);
                    return hours + ":" + (minutes < 10 ? "0" + minutes : minutes);
                }
            }

            // Mouse interaction for polar chart
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPositionChanged: {
                    var polar = polarChart.cartesianToPolar(mouseX, mouseY);

                    if (polar.distance >= polarChart.innerRadius && polar.distance <= polarChart.outerRadius) {
                        polarTooltip.text = "Bearing: " + polar.bearing.toFixed(1) + "°\nTime: " +
                                           formatToHoursMinutes(polar.time);
                        polarTooltip.x = Math.min(mouseX + 15, parent.width - polarTooltip.width);
                        polarTooltip.y = Math.max(mouseY - polarTooltip.height - 10, 0);
                        polarTooltip.visible = true;
                    } else {
                        polarTooltip.visible = false;
                    }
                }

                onExited: {
                    polarTooltip.visible = false;
                }

                function formatToHoursMinutes(value) {
                    var hours = Math.floor(value / 60);
                    var minutes = Math.floor(value % 60);
                    return hours + ":" + (minutes < 10 ? "0" + minutes : minutes);
                }
            }

            // Polar tooltip
            Rectangle {
                id: polarTooltip
                width: polarTooltipText.width + 20
                height: polarTooltipText.height + 16
                color: "black"
                border.color: "white"
                border.width: 1
                radius: 5
                visible: false
                z: 1000

                Text {
                    id: polarTooltipText
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 11
                    font.family: "Ubuntu"
                }

                property alias text: polarTooltipText.text
            }

            // Legend for polar view
            Rectangle {
                id: polarLegend
                width: 120
                height: 80
                color: "red"
                border.color: "white"
                border.width: 1
                radius: 5
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 20

                Column {
                    anchors.centerIn: parent
                    spacing: 8

                    Row {
                        spacing: 8
                        Rectangle {
                            width: 20
                            height: 3
                            color: "blue"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "Own System"
                            color: "white"
                            font.pixelSize: 10
                        }
                    }

                    Row {
                        spacing: 8
                        Rectangle {
                            width: 20
                            height: 3
                            color: "green"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "MN220"
                            color: "white"
                            font.pixelSize: 10
                        }
                    }
                }
            }
        }

        // Timer to update the values in lineseries
        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                chartRect.timeStep += 1;
                var x = 100
                var y = chartRect.timeStep
                lineSeries1.append(x, y);

                // Update polar chart if it's visible
                if (showPolarView) {
                    polarChart.updateDataFromLinearChart();
                }
            }
        }
    }
}
*/

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

    // Circle properties for time scale
    property real centerX: 180  // Center of circular chart
    property real centerY: 120  // Center of circular chart
    property real innerRadius: 30   // Inner circle radius
    property real outerRadius: 100  // Outer circle radius

    // Animation for transformation
    PropertyAnimation {
        id: transformAnimation
        target: chartRect
        property: "transformProgress"
        duration: 3000  // Slower animation to match website
        easing.type: Easing.InOutQuart
    }

    // Listen for transform progress changes
    onTransformProgressChanged: {
        updateCircularTransform()
    }

    // Function to convert bearing/time to coordinates with proper circular transformation
    function transformCoordinates(bearing, time, progress) {
        var linearX = bearing
        var linearY = time

        if (progress === 0) {
            return { x: linearX, y: linearY }
        }

        // Normalize time into [0..1]
        var timeNormalized = time / chartRect.maxYAxisValue

        // Compute circular coordinates
        var radius = innerRadius + (outerRadius - innerRadius) * timeNormalized
        var angle = (bearing / 360) * 2 * Math.PI - Math.PI/2
        var circularX = centerX + radius * Math.cos(angle)
        var circularY = centerY + radius * Math.sin(angle)

        // Stage 1 (progress 0–0.5): bend X into an arc
        if (progress < 0.5) {
            var bendFactor = progress * 2  // 0→1
            var bendX = linearX
            var bendY = linearY + Math.sin((bearing/360) * Math.PI * 2) * 30 * bendFactor
            return { x: bendX, y: bendY }
        }

        // Stage 2 (progress 0.5–1): morph into circular
        var circularFactor = (progress - 0.5) * 2  // 0→1
        var x = linearX * (1 - circularFactor) + circularX * circularFactor
        var y = linearY * (1 - circularFactor) + circularY * circularFactor
        return { x: x, y: y }
    }

    // Function to update all series for circular transform
    function updateCircularTransform() {
        // Clear existing points
        lineSeries1.clear()
        lineSeries2.clear()
        gridSeries.clear()
        innerCircle.clear()
        outerCircle.clear()
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
            var point1 = transformCoordinates(series1Data[i].bearing, series1Data[i].time, transformProgress)
            lineSeries1.append(point1.x, point1.y)
        }

        // Transform and add points for series 2
        for (var j = 0; j < series2Data.length; j++) {
            var point2 = transformCoordinates(series2Data[j].bearing, series2Data[j].time, transformProgress)
            lineSeries2.append(point2.x, point2.y)
        }

        // Add circular elements when in circular mode
        if (transformProgress > 0.3) {
            addCircularElements()
        }

        // Add horizontal line at time=0 (transforms into inner circle)
        addTimeZeroLine()
    }

    // Function to add inner circle, outer circle, and radial lines
    function addCircularElements() {
        // Create inner circle
        for (var angle = 0; angle <= 360; angle += 2) {
            var angleRad = (angle - 90) * Math.PI / 180
            var innerX = centerX + innerRadius * Math.cos(angleRad)
            var innerY = centerY + innerRadius * Math.sin(angleRad)
            innerCircle.append(innerX, innerY)
        }

        // Create outer circle
        for (var angle2 = 0; angle2 <= 360; angle2 += 2) {
            var angleRad2 = (angle2 - 90) * Math.PI / 180
            var outerX = centerX + outerRadius * Math.cos(angleRad2)
            var outerY = centerY + outerRadius * Math.sin(angleRad2)
            outerCircle.append(outerX, outerY)
        }

        // Create radial bearing lines (every 30 degrees)
        // for (var bearing = 0; bearing < 360; bearing += 30) {
        //     var bearingRad = (bearing - 90) * Math.PI / 180
        //     var startX = centerX + innerRadius * Math.cos(bearingRad)
        //     var startY = centerY + innerRadius * Math.sin(bearingRad)
        //     var endX = centerX + outerRadius * Math.cos(bearingRad)
        //     var endY = centerY + outerRadius * Math.sin(bearingRad)

        //     bearingLines.append(startX, startY)
        //     bearingLines.append(endX, endY)
        // }

        // Add intermediate time circles
        for (var timeCircle = 60; timeCircle <= 180; timeCircle += 60) {
            var timeRadius = innerRadius + (outerRadius - innerRadius) * (timeCircle / 240)
            for (var a = 0; a <= 360; a += 5) {
                var aRad = (a - 90) * Math.PI / 180
                var timeX = centerX + timeRadius * Math.cos(aRad)
                var timeY = centerY + timeRadius * Math.sin(aRad)
                gridSeries.append(timeX, timeY)
            }
        }
    }

    // Function to add the time=0 line that transforms into inner circle
    function addTimeZeroLine() {
        if (transformProgress < 0.3) {
            // Linear horizontal line at time=0
            for (var bearing = 0; bearing <= 360; bearing += 5) {
                var point = transformCoordinates(bearing, 0, transformProgress)
                innerCircle.append(point.x, point.y)
            }
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
        color: "black"

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

                    // Hide axes in circular mode for cleaner look
                    if (chartRect.isCircularMode) {
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
                reverse: true   // ✅ Now time grows downward
                labelsColor: "white"
                gridVisible: false
                color: "white"
            }
            // Outer circle (time=0, present moment - waterfall starts here)
            LineSeries {
                id: outerCircle
                name: "OuterCircle"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 2
            }

            // Inner circle (time=240, future - waterfall ends here)
            LineSeries {
                id: innerCircle
                name: "InnerCircle"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
            }

            // Grid series for intermediate time circles
            ScatterSeries {
                id: gridSeries
                name: "Grid"
                axisXTop: topAxis
                axisY: yAxis
                color: "gray"
                markerSize: 1
                borderColor: "gray"
                borderWidth: 0
            }

            // Bearing lines (radial lines in circular mode)
            LineSeries {
                id: bearingLines
                name: "BearingLines"
                axisXTop: topAxis
                axisY: yAxis
                color: "gray"
                width: 1
            }

            LineSeries {
                id: lineSeries1
                name: "System"
                axisXTop: topAxis
                axisY: yAxis
                color: "#ff6b6b"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        tooltipText.text = lineSeries1.name +
                            "\nBearing: " + point.x.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(point.y)
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
                color: "#4ecdc4"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        tooltipText.text = lineSeries2.name +
                            "\nBearing: " + point.x.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                        tooltipRect.visible = true
                        let p = chartView.mapToPosition(point, lineSeries2)
                        tooltipRect.x = p.x
                        tooltipRect.y = p.y - tooltipRect.height
                    } else {
                        tooltipRect.visible = false
                    }
                }
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

            // Mouse area for tracking
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPositionChanged: {
                    if (chartRect.transformProgress < 0.5) {
                        // Linear mode tooltip
                        var plotLeft = chartView.plotArea.x
                        var plotRight = chartView.plotArea.x + chartView.plotArea.width
                        var plotTop = chartView.plotArea.y
                        var plotBottom = chartView.plotArea.y + chartView.plotArea.height

                        if (mouseX > plotLeft && mouseX < plotRight && mouseY > plotTop && mouseY < plotBottom) {
                            var chartX = topAxis.min + ((mouseX - plotLeft) / (plotRight - plotLeft)) * (topAxis.max - topAxis.min)
                            var chartY = yAxis.min + ((mouseY - plotTop) / (plotBottom - plotTop)) * (yAxis.max - yAxis.min)

                            globalTooltip.text = "Bearing: " + chartX.toFixed(1) + "°, Time: " + chartRect.formatToHoursMinutes(chartY)
                            globalTooltip.x = mouseX + 10
                            globalTooltip.y = mouseY - 10
                            globalTooltip.visible = true
                        }
                    }
                }

                onExited: globalTooltip.visible = false
            }

            Text {
                id: globalTooltip
                visible: false
                color: "white"
                font.pixelSize: 12
                z: 100
            }
        }

        // Initialize with linear data
        Component.onCompleted: {
            updateCircularTransform()
        }
    }
}

/*3
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

    // Circle properties for time scale
    property real centerX: 180  // Center of circular chart
    property real centerY: 120  // Center of circular chart
    property real innerRadius: 30   // Inner circle radius
    property real outerRadius: 100  // Outer circle radius

    // Animation for transformation
    PropertyAnimation {
        id: transformAnimation
        target: chartRect
        property: "transformProgress"
        duration: 3000  // Slower animation to match website
        easing.type: Easing.InOutQuart
    }

    // Listen for transform progress changes
    onTransformProgressChanged: {
        updateCircularTransform()
    }

    // Function to convert bearing/time to coordinates with proper circular transformation
    function transformCoordinates(bearing, time, progress) {
        // Linear coordinates
        var linearX = bearing
        var linearY = time

        if (progress === 0) {
            return { x: linearX, y: linearY }
        }

        // Calculate the curved X position (bending the bearing axis)
        // This creates the smooth curving effect like in the website
        var normalizedBearing = bearing / 360  // 0 to 1
        var curveAmount = progress * Math.PI * 2  // How much to curve (0 to 2π)

        // Create intermediate curved positions
        var curvedX = linearX
        var curvedY = linearY

        if (progress > 0) {
            // Calculate radius based on time (between inner and outer radius)
            var timeNormalized = time / 240  // 0 to 1
            var radius = innerRadius + (outerRadius - innerRadius) * timeNormalized

            // Calculate angle (0° at top, clockwise)
            var angle = (bearing / 360) * 2 * Math.PI - Math.PI/2

            // Final circular position
            var circularX = centerX + radius * Math.cos(angle) * progress
            var circularY = centerY + radius * Math.sin(angle) * progress

            // Intermediate curved position (X-axis bending)
            var bendRadius = 50 + (radius - innerRadius) * (1 - progress)
            var bendX = centerX + bendRadius * Math.cos(angle) * progress
            var bendY = linearY * (1 - progress) + circularY * progress

            // Blend all transformations
            curvedX = linearX * (1 - progress) + circularX
            curvedY = linearY * (1 - progress) + circularY
        }

        return { x: curvedX, y: curvedY }
    }

    // Function to update all series for circular transform
    function updateCircularTransform() {
        // Clear existing points
        lineSeries1.clear()
        lineSeries2.clear()
        gridSeries.clear()
        innerCircle.clear()
        outerCircle.clear()
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
            var point1 = transformCoordinates(series1Data[i].bearing, series1Data[i].time, transformProgress)
            lineSeries1.append(point1.x, point1.y)
        }

        // Transform and add points for series 2
        for (var j = 0; j < series2Data.length; j++) {
            var point2 = transformCoordinates(series2Data[j].bearing, series2Data[j].time, transformProgress)
            lineSeries2.append(point2.x, point2.y)
        }

        // Add circular elements when in circular mode
        if (transformProgress > 0.3) {
            addCircularElements()
        }

        // Add horizontal line at time=0 (transforms into inner circle)
        addTimeZeroLine()
    }

    // Function to add inner circle, outer circle, and radial lines
    function addCircularElements() {
        // Create inner circle
        for (var angle = 0; angle <= 360; angle += 2) {
            var angleRad = (angle - 90) * Math.PI / 180
            var innerX = centerX + innerRadius * Math.cos(angleRad)
            var innerY = centerY + innerRadius * Math.sin(angleRad)
            innerCircle.append(innerX, innerY)
        }

        // Create outer circle
        for (var angle2 = 0; angle2 <= 360; angle2 += 2) {
            var angleRad2 = (angle2 - 90) * Math.PI / 180
            var outerX = centerX + outerRadius * Math.cos(angleRad2)
            var outerY = centerY + outerRadius * Math.sin(angleRad2)
            outerCircle.append(outerX, outerY)
        }

        // Create radial bearing lines (every 30 degrees)
        for (var bearing = 0; bearing < 360; bearing += 30) {
            var bearingRad = (bearing - 90) * Math.PI / 180
            var startX = centerX + innerRadius * Math.cos(bearingRad)
            var startY = centerY + innerRadius * Math.sin(bearingRad)
            var endX = centerX + outerRadius * Math.cos(bearingRad)
            var endY = centerY + outerRadius * Math.sin(bearingRad)

            bearingLines.append(startX, startY)
            bearingLines.append(endX, endY)
        }

        // Add intermediate time circles
        for (var timeCircle = 60; timeCircle <= 180; timeCircle += 60) {
            var timeRadius = innerRadius + (outerRadius - innerRadius) * (timeCircle / 240)
            for (var a = 0; a <= 360; a += 5) {
                var aRad = (a - 90) * Math.PI / 180
                var timeX = centerX + timeRadius * Math.cos(aRad)
                var timeY = centerY + timeRadius * Math.sin(aRad)
                gridSeries.append(timeX, timeY)
            }
        }
    }

    // Function to add the time=0 line that transforms into inner circle
    function addTimeZeroLine() {
        if (transformProgress < 0.3) {
            // Linear horizontal line at time=0
            for (var bearing = 0; bearing <= 360; bearing += 5) {
                var point = transformCoordinates(bearing, 0, transformProgress)
                innerCircle.append(point.x, point.y)
            }
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
        color: "black"

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

                    // Hide axes in circular mode for cleaner look
                    if (chartRect.isCircularMode) {
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
                reverse: false
                labelsColor: "white"
                gridVisible: false
                color: "white"
            }

            // Inner circle (time=0 line becomes this)
            LineSeries {
                id: innerCircle
                name: "InnerCircle"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
            }

            // Outer circle (time=240 boundary)
            LineSeries {
                id: outerCircle
                name: "OuterCircle"
                axisXTop: topAxis
                axisY: yAxis
                color: "white"
                width: 1
            }

            // Grid series for intermediate time circles
            ScatterSeries {
                id: gridSeries
                name: "Grid"
                axisXTop: topAxis
                axisY: yAxis
                color: "gray"
                markerSize: 1
                borderColor: "gray"
                borderWidth: 0
            }

            // Bearing lines (radial lines in circular mode)
            LineSeries {
                id: bearingLines
                name: "BearingLines"
                axisXTop: topAxis
                axisY: yAxis
                color: "gray"
                width: 1
            }

            LineSeries {
                id: lineSeries1
                name: "System"
                axisXTop: topAxis
                axisY: yAxis
                color: "#ff6b6b"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        tooltipText.text = lineSeries1.name +
                            "\nBearing: " + point.x.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(point.y)
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
                color: "#4ecdc4"
                width: 3

                onHovered: function(point, state) {
                    if (state) {
                        tooltipText.text = lineSeries2.name +
                            "\nBearing: " + point.x.toFixed(1) + "°" +
                            "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                        tooltipRect.visible = true
                        let p = chartView.mapToPosition(point, lineSeries2)
                        tooltipRect.x = p.x
                        tooltipRect.y = p.y - tooltipRect.height
                    } else {
                        tooltipRect.visible = false
                    }
                }
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

            // Mouse area for tracking
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPositionChanged: {
                    if (chartRect.transformProgress < 0.5) {
                        // Linear mode tooltip
                        var plotLeft = chartView.plotArea.x
                        var plotRight = chartView.plotArea.x + chartView.plotArea.width
                        var plotTop = chartView.plotArea.y
                        var plotBottom = chartView.plotArea.y + chartView.plotArea.height

                        if (mouseX > plotLeft && mouseX < plotRight && mouseY > plotTop && mouseY < plotBottom) {
                            var chartX = topAxis.min + ((mouseX - plotLeft) / (plotRight - plotLeft)) * (topAxis.max - topAxis.min)
                            var chartY = yAxis.min + ((mouseY - plotTop) / (plotBottom - plotTop)) * (yAxis.max - yAxis.min)

                            globalTooltip.text = "Bearing: " + chartX.toFixed(1) + "°, Time: " + chartRect.formatToHoursMinutes(chartY)
                            globalTooltip.x = mouseX + 10
                            globalTooltip.y = mouseY - 10
                            globalTooltip.visible = true
                        }
                    }
                }

                onExited: globalTooltip.visible = false
            }

            Text {
                id: globalTooltip
                visible: false
                color: "white"
                font.pixelSize: 12
                z: 100
            }
        }

        // Initialize with linear data
        Component.onCompleted: {
            updateCircularTransform()
        }
    }
}
*/

/*2
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
    }

    // Listen for transform progress changes
    onTransformProgressChanged: {
        updateCircularTransform()
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

        // // Add radial bearing lines
        // for (var bearing = 0; bearing < 360; bearing += 30) {
        //     var startPoint = polarToCartesian(bearing, 0, transformProgress)
        //     var endPoint = polarToCartesian(bearing, 240, transformProgress)

        //     bearingLines.append(startPoint.x, startPoint.y)
        //     bearingLines.append(endPoint.x, endPoint.y)
        // }
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
        color: "black"

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
                    color: "black"
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
                    color: "black"
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
                    color: "black"
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
*/
// 1)
// Rectangle {
//     width: 1000
//     height: 850
//     visible: true
//     color: "black"
//     id: chartRect

//     // Create an instance of ChartManager
//     ChartManager {
//         id: chartManager
//     }
//     property int minXAxisValue: chartManager.minXAxisValue
//     property int maxXAxisValue: chartManager.maxXAxisValue

//     // Access and modify properties from C++
//     property int minYAxisValue: chartManager.minYAxisValue
//     property int maxYAxisValue: chartManager.maxYAxisValue
//     property var ranges: chartManager.ranges
//     property int timeStep: chartManager.timeStep


//     // Range of the Top axis
//     property int firstValue
//     property int secondValue

//     function updateYAxisLabels(currentRangeIndex) {
//         // Update the min and max values of the yAxis based on the selected range
//         yAxis.min = ranges[currentRangeIndex].min
//         yAxis.max = ranges[currentRangeIndex].max

//         var preLabels =  yAxis.categoriesLabels
//         // prevLable = yAxis.categoriesLabels

//         for(var i=0; i < preLabels.length; i++) { yAxis.remove(preLabels[i])}
//         // Add the new labels based on the selected range
//         var newLabels = ranges[currentRangeIndex].labels;
//         for (var i = 0; i < newLabels.length; i++) {
//             if (newLabels[i]) { // Only append non-empty labels
//                 yAxis.append(newLabels[i], parseInt(newLabels[i]));
//             }
//         }
//         console.log("Updated Labels:", yAxis.categoriesLabels)
//     }

//     function updateSeriesLabelPosition() {
//         // Example series data point (use actual series data)
//         let seriesDataX = 100.9;  // X coordinate of the data point
//         let seriesDataY = 30.3;   // Y coordinate of the data point

//         // Map the data point (seriesDataX, seriesDataY) to pixel coordinates
//         let mappedPosition = chartView.mapToPosition(Qt.point(seriesDataX, seriesDataY), lineSeries1);

//         // Calculate the label's X position (centered around the mapped position)
//         let labelX = Math.max(chartView.plotArea.x, Math.min(mappedPosition.x, chartView.plotArea.x + chartView.plotArea.width - seriesLabel.width)) - seriesLabel.width / 2;
//         if (topAxis.min <= seriesDataX && seriesDataX <= topAxis.max ){
//             seriesLabel.x = labelX;
//             seriesLabel.visible = true;
//         }
//         else{
//             seriesLabel.visible = false;
//         }
//     }

//     function updateSeriesLabelPosition2() {
//         // Example series data point (use actual series data)
//         let seriesDataX = 180;  // X coordinate of the data point
//         let seriesDataY = 0;   // Y coordinate of the data point

//         // Map the data point (seriesDataX, seriesDataY) to pixel coordinates
//         let mappedPosition = chartView.mapToPosition(Qt.point(seriesDataX, seriesDataY), lineSeries2);

//         // Calculate the label's X position (centered around the mapped position)
//         let labelX = Math.max(chartView.plotArea.x, Math.min(mappedPosition.x, chartView.plotArea.x + chartView.plotArea.width - seriesLabel2.width)) - seriesLabel2.width / 2;
//         if (topAxis.min <= seriesDataX && seriesDataX <= topAxis.max ){
//             seriesLabel2.x = labelX;
//             seriesLabel2.visible = true;
//         }
//         else{
//             seriesLabel2.visible = false;
//         }
//     }

//     // Function to format value as hours and minutes
//     function formatToHoursMinutes(value) {
//         var hours = Math.floor(value / 60)
//         var minutes = Math.floor(value % 60)
//         return hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
//     }

//     // Variable to track the current range index
//     property int currentRangeIndex: 0
//     property int currentAngle: 40
//     Rectangle{
//         id: btnBar
//         height: 50
//         width: parent.width
//         anchors.top: parent.top
//         color: "black"


//             Row{
//                 anchors.fill:parent
//                 spacing: 5
//                 Button{
//                     id: timeRange
//                     height: btnBar.height - 5
//                     width: 50

//                     Image {
//                         id: resizeImage
//                         width: 35
//                         height: 35
//                         anchors.centerIn: parent
//                         z: 100
//                         source: "qrc:/icons/resize.png"
//                     }

//                     background: Rectangle{
//                         opacity: enabled ? 1 : 0.3
//                         border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                         border.width: 1
//                         radius: 2
//                     }

//                     // Click event
//                     onClicked: {
//                         minorTickCount: 2
//                         console.log("Button clicked")
//                         // Cycle through the ranges sequentially
//                         currentRangeIndex = (chartRect.currentRangeIndex + 1) % chartRect.ranges.length
//                         // Update yAxis min and max based on the current range
//                         // Update the labels based on the new range
//                         chartRect.updateYAxisLabels(currentRangeIndex);
//                     }
//                 }
//                 Button{
//                     id:courseUp
//                     height: btnBar.height-5

//                     width: 50
//                     Image {
//                         id: courseImage
//                         width: 35
//                         height: 35
//                         anchors.centerIn: parent
//                         z: 100
//                         source: "qrc:/icons/zoom.png"
//                     }
//                     background: Rectangle {
//                         opacity: enabled ? 1 : 0.3
//                         border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                         border.width: 1
//                         radius: 2
//                     }
//                 }
//                 Button{
//                     id:zoom
//                     height: btnBar.height-5

//                     width: 50
//                     Image {
//                         id: zoomImage
//                         width: 35
//                         height: 35
//                         anchors.centerIn: parent
//                         z: 100
//                         source: "qrc:/icons/reset.png"
//                     }
//                     background: Rectangle {
//                         opacity: enabled ? 1 : 0.3
//                         border.color: timeRange.down ? "#17a81a" : "#21be2b"
//                         border.width: 1
//                         radius: 2
//                     }
//                     // Click event
//                     onClicked: {
//                         console.log("Reset Button clicked")
//                         topAxis.min = 0;
//                         topAxis.max= 360;
//                         yAxis.min = -7;
//                         yAxis.max = 240;
//                     }
//                 }
//             }

//     }

//     Rectangle{
//         id: rangeSliderRect
//         width: parent.width
//         height: 200
//         anchors.top: btnBar.bottom
//         anchors.right: parent.right
//         anchors.left: parent.left
//         anchors.leftMargin: 50
//         anchors.rightMargin: 20
//         color: "black"

//         RangeSliderWaterFall{
//             id: rangeSlider
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

//             Rectangle{
//                 id: tooltipRect
//                 width: labelName.width + 10
//                 height: labelName.height + 10
//                 border.color: "white"
//                 radius: 2
//                 color: "black"

//                 Text {
//                     id: labelName
//                     color: "white"
//                     text: qsTr("ToolTip")
//                     anchors.centerIn: parent
//                     anchors.margins: 10 // Adds padding around the text
//                     font.family: "Ubuntu"
//                     font.pointSize: 7
//                     font.weight: 500
//                 }
//                 visible: false
//             }

//             ValueAxis {
//                 id: topAxis
//                 // min: chartRect.minXAxisValue
//                 // max: chartRect.maxXAxisValue
//                 min: chartRect.firstValue
//                 max: chartRect.secondValue
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
//                 min: -7
//                 max: 240
//                 reverse: true
//                 labelsColor: "white"
//                 labelsPosition: CategoryAxis.AxisLabelsPositionOnValue
//                 minorTickCount: 2
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
//                 XYPoint { x: 360; y: -13}
//             }

//             LineSeries {
//                 id: lineSeries1
//                 name: "Own System"
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
//             MouseTrackerTooltip{
//                 id: tooltip
//             }

//             TrackLabel{
//                 id: seriesLabel
//                 labelName: "OWN"
//                 x: {
//                     let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
//                 }
//                 y: {
//                     let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
//                 }
//             }
//             TrackLabel{
//                 id: seriesLabel2
//                 labelName: "MN220"
//                 x: {
//                     let position = chartView.mapToPosition(Qt.point(180, 0), lineSeries2);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
//                 }
//                 y: {
//                     let position = chartView.mapToPosition(Qt.point(180, 0), lineSeries2);
//                     // Ensure it stays within the chart's plot area
//                     Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
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
//                     // console.log("Mouse position: " + mouseX + ", " + mouseY)

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
