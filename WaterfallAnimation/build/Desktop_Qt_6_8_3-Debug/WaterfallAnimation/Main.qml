import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.9
import QtQuick.Layouts

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

                Image {
                    id: resizeImage
                    width: 35
                    height: 35
                    anchors.centerIn: parent
                    z: 100
                    source: "qrc:/icons/resize.png"
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

            // New button for chart transformation
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
                    source: "qrc:/icons/resize.png"
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

                onClicked: {
                    console.log("Reset Button clicked")
                    topAxis.min = 0;
                    topAxis.max= 360;
                    yAxis.min = 0;
                    yAxis.max = 240;
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

        RangeSlider {
            id: rangeSlider
            from: 0
            to: 360
            first.value:0
            second.value: 360
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

                    MouseArea {
                        anchors.fill: parent
                        property real dx: 0
                        onPressed: dx = mouseX
                        onPositionChanged: {
                            var d = ((mouseX - dx) / rangeSlider.width) * Math.abs(rangeSlider.to - rangeSlider.from)
                            if ((d + rangeSlider.first.value) < rangeSlider.from) d = rangeSlider.from - rangeSlider.first.value
                            if ((d + rangeSlider.second.value) > rangeSlider.to) d = rangeSlider.to - rangeSlider.second.value
                            rangeSlider.first.value += d
                            rangeSlider.second.value += d
                            dx = mouseX
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

            first.onMoved:{ topAxis.min= first.value}
            second.onMoved:{ topAxis.max= second.value}
        }
    }

    Item {
        id: waterfall
        anchors.top: rangeSliderRect.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        // Linear Chart View
        ChartView {
            id: chartView
            anchors.fill: parent
            opacity: 1.0 - chartRect.transformProgress
            visible: opacity > 0

            Layout.fillWidth: true
            Layout.fillHeight: true
            antialiasing: true
            backgroundColor: "black"
            legend.visible: false
            margins { left: 0; right: 0; top: 0; bottom: 0 }

            ToolTip {
                id: toolTip
                visible: false
            }

            Rectangle{
                id: tooltipRect
                width: labelName.width + 10
                height: labelName.height + 10
                border.color: "white"
                radius: 5
                color: "black"

                Text {
                    id: labelName
                    color: "white"
                    text: qsTr("ToolTip")
                    anchors.centerIn: parent
                    anchors.margins: 10
                    font.pointSize: 5
                }
                visible: false
            }

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

            CategoryAxis {
                id: yAxis
                min: -10
                max: 240
                reverse: true
                labelsColor: "white"
                labelsPosition: CategoryAxis.AxisLabelsPositionOnValue
                gridVisible:false

                CategoryRange { label: ""; endValue: -10 }
                CategoryRange { label: "000"; endValue: 0 }
                CategoryRange { label: "040"; endValue: 40 }
                CategoryRange { label: "080"; endValue: 80 }
                CategoryRange { label: "120"; endValue: 120 }
                CategoryRange { label: "160"; endValue: 160 }
                CategoryRange { label: "200"; endValue: 200 }
                CategoryRange { label: "240"; endValue: 240 }
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
                XYPoint { x: 360; y: -25}
            }

            LineSeries {
                id: lineSeries1
                name: "System"
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

                onHovered: function(point, state) {
                    labelName.text = lineSeries1.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                    tooltipRect.visible = state
                    let p = chartView.mapToPosition(point, lineSeries1)
                    tooltipRect.x = p.x
                    tooltipRect.y = p.y - tooltipRect.height
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
                XYPoint { x: 180.4; y: 50.0 }
                XYPoint { x: 180.1; y: 50.3 }
                XYPoint { x: 180; y: 60 }
                XYPoint { x: 180.1; y: 70.1 }
                XYPoint { x: 180.9; y: 80.3 }
                XYPoint { x: 180.1; y: 90.1 }
                XYPoint { x: 180.9; y: 140.9 }
                XYPoint { x: 180.4; y: 150.0 }
                XYPoint { x: 180.1; y: 150.3 }

                onHovered: function(point, state) {
                    labelName.text = lineSeries2.name+ "\nBearing: "+point.x.toFixed(2) + "\nTime: " + chartRect.formatToHoursMinutes(point.y)
                    tooltipRect.visible = state
                    let p = chartView.mapToPosition(point, lineSeries2)
                    tooltipRect.x = p.x
                    tooltipRect.y = p.y - tooltipRect.height
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

                onExited: tooltip.visible = false
            }

            Text {
                id: tooltip
                visible: false
                color: "white"
                font.pixelSize: 12
                anchors.horizontalCenterOffset: 10
                anchors.verticalCenterOffset: -10
                font.pointSize: 10
            }
        }

        // Circular/Radar Chart Canvas
        Canvas {
            id: circularCanvas
            anchors.fill: parent
            opacity: chartRect.transformProgress
            visible: opacity > 0

            property real centerX: width / 2
            property real centerY: height / 2
            property real maxRadius: Math.min(width, height) * 0.4

            // Data points for circular representation
            property var circularData1: []
            property var circularData2: []

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.fillStyle = "black";
                ctx.fillRect(0, 0, width, height);

                drawRadarGrid(ctx);
                drawCircularData(ctx);
            }

            function drawRadarGrid(ctx) {
                ctx.strokeStyle = "white";
                ctx.lineWidth = 1;

                // Draw concentric circles for time ranges
                var timeRanges = [60, 120, 180, 240]; // minutes
                for (var i = 0; i < timeRanges.length; i++) {
                    var radius = (timeRanges[i] / 240) * maxRadius;
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
                    ctx.stroke();

                    // Add time labels
                    ctx.fillStyle = "white";
                    ctx.font = "12px Arial";
                    ctx.fillText(formatToHoursMinutes(timeRanges[i]),
                               centerX + radius + 5, centerY + 5);
                }

                // Draw bearing lines (every 30 degrees)
                for (var bearing = 0; bearing < 360; bearing += 30) {
                    var angle = (bearing - 90) * Math.PI / 180; // -90 to start from top
                    ctx.beginPath();
                    ctx.moveTo(centerX, centerY);
                    ctx.lineTo(centerX + maxRadius * Math.cos(angle),
                              centerY + maxRadius * Math.sin(angle));
                    ctx.stroke();

                    // Add bearing labels
                    var labelRadius = maxRadius + 15;
                    ctx.fillStyle = "white";
                    ctx.font = "12px Arial";
                    ctx.textAlign = "center";
                    ctx.fillText(bearing.toString(),
                               centerX + labelRadius * Math.cos(angle),
                               centerY + labelRadius * Math.sin(angle) + 5);
                }
            }

            function drawCircularData(ctx) {
                // Convert linear data to circular coordinates
                convertLinearToCircular();

                // Draw data series 1 (blue)
                if (circularData1.length > 0) {
                    ctx.strokeStyle = "blue";
                    ctx.lineWidth = 2;
                    ctx.beginPath();
                    ctx.moveTo(circularData1[0].x, circularData1[0].y);
                    for (var i = 1; i < circularData1.length; i++) {
                        ctx.lineTo(circularData1[i].x, circularData1[i].y);
                    }
                    ctx.stroke();

                    // Draw points
                    ctx.fillStyle = "blue";
                    for (var j = 0; j < circularData1.length; j++) {
                        ctx.beginPath();
                        ctx.arc(circularData1[j].x, circularData1[j].y, 3, 0, 2 * Math.PI);
                        ctx.fill();
                    }
                }

                // Draw data series 2 (green)
                if (circularData2.length > 0) {
                    ctx.strokeStyle = "green";
                    ctx.lineWidth = 2;
                    ctx.beginPath();
                    ctx.moveTo(circularData2[0].x, circularData2[0].y);
                    for (var k = 1; k < circularData2.length; k++) {
                        ctx.lineTo(circularData2[k].x, circularData2[k].y);
                    }
                    ctx.stroke();

                    // Draw points
                    ctx.fillStyle = "green";
                    for (var l = 0; l < circularData2.length; l++) {
                        ctx.beginPath();
                        ctx.arc(circularData2[l].x, circularData2[l].y, 3, 0, 2 * Math.PI);
                        ctx.fill();
                    }
                }
            }

            function convertLinearToCircular() {
                circularData1 = [];
                circularData2 = [];

                // Convert Series 1 data
                var series1Points = [
                    {bearing: 100, time: 0}, {bearing: 100.1, time: 20.1},
                    {bearing: 100.9, time: 30.3}, {bearing: 100.1, time: 40.1},
                    {bearing: 100.9, time: 40.9}, {bearing: 100.4, time: 50.0},
                    {bearing: 100.1, time: 50.3}
                ];

                for (var i = 0; i < series1Points.length; i++) {
                    var point = series1Points[i];
                    var radius = (point.time / 240) * maxRadius;
                    var angle = (point.bearing - 90) * Math.PI / 180;
                    circularData1.push({
                        x: centerX + radius * Math.cos(angle),
                        y: centerY + radius * Math.sin(angle)
                    });
                }

                // Convert Series 2 data
                var series2Points = [
                    {bearing: 180, time: 0}, {bearing: 180.1, time: 20.1},
                    {bearing: 180.9, time: 30.3}, {bearing: 180.1, time: 40.1},
                    {bearing: 180.9, time: 40.9}, {bearing: 180.4, time: 50.0},
                    {bearing: 180.1, time: 50.3}, {bearing: 180, time: 60},
                    {bearing: 180.1, time: 70.1}, {bearing: 180.9, time: 80.3},
                    {bearing: 180.1, time: 90.1}, {bearing: 180.9, time: 140.9},
                    {bearing: 180.4, time: 150.0}, {bearing: 180.1, time: 150.3}
                ];

                for (var j = 0; j < series2Points.length; j++) {
                    var point2 = series2Points[j];
                    var radius2 = (point2.time / 240) * maxRadius;
                    var angle2 = (point2.bearing - 90) * Math.PI / 180;
                    circularData2.push({
                        x: centerX + radius2 * Math.cos(angle2),
                        y: centerY + radius2 * Math.sin(angle2)
                    });
                }
            }

            // Trigger repaint when transform progress changes
            Connections {
                target: chartRect
                function onTransformProgressChanged() {
                    circularCanvas.requestPaint();
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onPositionChanged: {
                    // Calculate bearing and time from mouse position in circular mode
                    var dx = mouseX - circularCanvas.centerX;
                    var dy = mouseY - circularCanvas.centerY;
                    var distance = Math.sqrt(dx * dx + dy * dy);
                    var bearing = (Math.atan2(dy, dx) * 180 / Math.PI + 90 + 360) % 360;
                    var time = (distance / circularCanvas.maxRadius) * 240;

                    if (distance <= circularCanvas.maxRadius && time > 0) {
                        circularTooltip.text = "Bearing: " + bearing.toFixed(1) +
                                             ", Time: " + chartRect.formatToHoursMinutes(time);
                        circularTooltip.x = mouseX + 10;
                        circularTooltip.y = mouseY - 10;
                        circularTooltip.visible = true;
                    } else {
                        circularTooltip.visible = false;
                    }
                }

                onExited: circularTooltip.visible = false
            }

            Text {
                id: circularTooltip
                visible: false
                color: "white"
                font.pixelSize: 12
                z: 100
            }
        }

        // Timer for updating data
        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                chartRect.timeStep += 1;
                var x = 100;
                var y = chartRect.timeStep;
                lineSeries1.append(x, y);

                // Trigger canvas repaint for circular mode
                if (chartRect.isCircularMode) {
                    circularCanvas.requestPaint();
                }
            }
        }
    }
}


// intermediate version can be used for later used
/*
ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Dynamic Polar-to-BRG Coordinate System"
    color: "#1a1a1a"

    // Animation progress (0 = polar, 1 = BRG)
    property real animationProgress: 0.0

    // Time progression (0 = now, 1 = 4 hours ago)
    property real timeProgress: 0.0

    // Dynamic sizing properties
    property real minDimension: Math.min(animationArea.width, animationArea.height)
    property real maxRadius: minDimension * 0.35  // 35% of available space
    property real plotWidth: animationArea.width * 0.7   // 70% of area width
    property real plotHeight: animationArea.height * 0.7  // 70% of area height

    // Coordinate system properties
    property real centerX: animationArea.width / 2
    property real centerY: animationArea.height / 2

    // Time axis properties (240 minutes = 4 hours with 7 ticks)
    property real totalTimeMinutes: 240
    property int timeTickCount: 7
    property real timeAxisWidth: 60  // Space for time labels

    // Bearing data - representing targets over 240 minutes
    property var bearingData: [
        // Target 1: Moving from 45° to 90° over 240 minutes
        {bearing: 45, timeMinutes: 240, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 52, timeMinutes: 192, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 61, timeMinutes: 144, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 72, timeMinutes: 96, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 85, timeMinutes: 48, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 90, timeMinutes: 0, color: "#ff6b6b", label: "Target A", id: 1},

        // Target 2: Moving from 270° to 225° over 240 minutes
        {bearing: 270, timeMinutes: 240, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 260, timeMinutes: 192, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 248, timeMinutes: 144, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 240, timeMinutes: 96, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 232, timeMinutes: 48, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 225, timeMinutes: 0, color: "#4ecdc4", label: "Target B", id: 2},

        // Target 3: Steady bearing (collision course)
        {bearing: 180, timeMinutes: 240, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, timeMinutes: 192, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, timeMinutes: 144, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, timeMinutes: 96, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, timeMinutes: 48, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, timeMinutes: 0, color: "#f39c12", label: "Target C", id: 3}
    ]

    // Bearing tick marks (every 45 degrees)
    property var bearingTicks: [
        {angle: 0, label: "0°"}, {angle: 45, label: "45°"}, {angle: 90, label: "90°"},
        {angle: 135, label: "135°"}, {angle: 180, label: "180°"}, {angle: 225, label: "225°"},
        {angle: 270, label: "270°"}, {angle: 315, label: "315°"}
    ]

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "#2a2a2a"
        border.width: 1
        border.color: "#444444"

        Column {
            anchors.centerIn: parent
            spacing: 15

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Dynamic Polar-to-BRG Coordinate System"
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                Button {
                    text: "▶ Unwrap to BRG"
                    onClicked: toLineAnimation.start()
                }

                Button {
                    text: "◀ Wrap to Polar"
                    onClicked: toCircleAnimation.start()
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toLineAnimation.stop()
                        toCircleAnimation.stop()
                        timeAnimation.stop()
                        animationProgress = 0
                        timeProgress = 0
                    }
                }

                Button {
                    text: timeAnimation.running ? "⏸️ Pause Time" : "⏯️ Play Time"
                    onClicked: timeAnimation.running ? timeAnimation.stop() : timeAnimation.start()
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Row {
                    spacing: 10
                    Text {
                        text: "Transform:"
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Slider {
                        from: 0; to: 1; value: animationProgress
                        width: 120
                        onValueChanged: if (!toLineAnimation.running && !toCircleAnimation.running) animationProgress = value
                    }
                    Text {
                        text: Math.round(animationProgress * 100) + "%"
                        color: "#4fc3f7"
                        width: 40
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    spacing: 10
                    Text {
                        text: "Time:"
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Slider {
                        from: 0; to: 1; value: timeProgress
                        width: 120
                        onValueChanged: if (!timeAnimation.running) timeProgress = value
                    }
                    Text {
                        text: Math.round((1 - timeProgress) * totalTimeMinutes) + "m ago"
                        color: "#a6e3a1"
                        width: 60
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    // Main animation area
    Rectangle {
        id: animationArea
        anchors.top: controlPanel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        color: "transparent"
        border.width: 1
        border.color: "#444444"

        Canvas {
            id: plotCanvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Set up coordinate system
                ctx.save()
                ctx.translate(centerX, centerY)

                // Draw grid and axes
                drawCoordinateSystem(ctx)

                // Draw bearing points and trails
                drawBearingData(ctx)

                ctx.restore()
            }

            function drawCoordinateSystem(ctx) {
                ctx.strokeStyle = "#666666"
                ctx.fillStyle = "white"
                ctx.lineWidth = 1
                ctx.font = "12px Arial"

                if (animationProgress < 0.5) {
                    // Polar coordinate system
                    drawPolarSystem(ctx)
                } else {
                    // Mixed/BRG coordinate system
                    drawBRGSystem(ctx)
                }
            }

            function drawPolarSystem(ctx) {
                // Draw concentric circles for time
                var timeRings = 4
                for (var i = 1; i <= timeRings; i++) {
                    var radius = (maxRadius / timeRings) * i
                    ctx.beginPath()
                    ctx.arc(0, 0, radius, 0, 2 * Math.PI)
                    ctx.stroke()

                    // Time labels
                    var timeLabel = Math.round((totalTimeMinutes / timeRings) * i) + "m"
                    ctx.fillStyle = "#aaaaaa"
                    ctx.textAlign = "center"
                    ctx.fillText(timeLabel, 0, -radius - 5)
                }

                // Draw bearing lines
                for (var i = 0; i < bearingTicks.length; i++) {
                    var tick = bearingTicks[i]
                    var angleRad = (tick.angle - 90) * Math.PI / 180 // -90 to make 0° point up

                    ctx.beginPath()
                    ctx.moveTo(0, 0)
                    ctx.lineTo(maxRadius * Math.cos(angleRad), maxRadius * Math.sin(angleRad))
                    ctx.stroke()

                    // Bearing labels
                    ctx.fillStyle = "white"
                    ctx.textAlign = "center"
                    var labelRadius = maxRadius + 20
                    var labelX = labelRadius * Math.cos(angleRad)
                    var labelY = labelRadius * Math.sin(angleRad)
                    ctx.fillText(tick.label, labelX, labelY + 4)
                }
            }

            function drawBRGSystem(ctx) {
                var progress = (animationProgress - 0.5) * 2 // 0 to 1 for second half

                // Calculate plot dimensions
                var plotLeft = -plotWidth / 2
                var plotRight = plotWidth / 2
                var plotTop = -plotHeight / 2
                var plotBottom = plotHeight / 2

                // Draw bearing axis (X-axis)
                ctx.beginPath()
                ctx.moveTo(plotLeft, plotBottom)
                ctx.lineTo(plotRight, plotBottom)
                ctx.stroke()

                // Draw time axis (Y-axis)
                ctx.beginPath()
                ctx.moveTo(plotLeft, plotTop)
                ctx.lineTo(plotLeft, plotBottom)
                ctx.stroke()

                // Draw bearing tick marks
                for (var i = 0; i < bearingTicks.length; i++) {
                    var tick = bearingTicks[i]
                    var x = bearingToX(tick.angle)

                    if (x >= plotLeft && x <= plotRight) {
                        // Tick mark
                        ctx.beginPath()
                        ctx.moveTo(x, plotBottom)
                        ctx.lineTo(x, plotBottom + 10)
                        ctx.stroke()

                        // Label
                        ctx.fillStyle = "white"
                        ctx.textAlign = "center"
                        ctx.fillText(tick.label, x, plotBottom + 25)
                    }
                }

                // Draw time tick marks
                for (var i = 0; i <= timeTickCount - 1; i++) {
                    var timeMinutes = (totalTimeMinutes / (timeTickCount - 1)) * i
                    var y = timeToY(timeMinutes)

                    if (y >= plotTop && y <= plotBottom) {
                        // Tick mark
                        ctx.beginPath()
                        ctx.moveTo(plotLeft - 10, y)
                        ctx.lineTo(plotLeft, y)
                        ctx.stroke()

                        // Label
                        ctx.fillStyle = "white"
                        ctx.textAlign = "end"
                        var label = i === 0 ? "Now" : Math.round(timeMinutes) + "m"
                        ctx.fillText(label, plotLeft - 15, y + 4)
                    }
                }
            }

            function drawBearingData(ctx) {
                // Group by target for trail drawing
                var targetGroups = {}
                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]
                    if (!targetGroups[point.id]) targetGroups[point.id] = []
                    targetGroups[point.id].push(point)
                }

                // Draw trails
                for (var targetId in targetGroups) {
                    drawTargetTrail(ctx, targetGroups[targetId])
                }

                // Draw points
                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]
                    var normalizedTime = point.timeMinutes / totalTimeMinutes
                    if (normalizedTime >= (1 - timeProgress)) {
                        drawBearingPoint(ctx, point)
                    }
                }
            }

            function drawTargetTrail(ctx, points) {
                if (points.length < 2) return

                ctx.strokeStyle = points[0].color
                ctx.lineWidth = 2
                ctx.globalAlpha = 0.6

                ctx.beginPath()
                var first = true

                for (var i = 0; i < points.length; i++) {
                    var point = points[i]
                    var normalizedTime = point.timeMinutes / totalTimeMinutes

                    if (normalizedTime >= (1 - timeProgress)) {
                        var pos = getPointPosition(point.bearing, point.timeMinutes)
                        if (first) {
                            ctx.moveTo(pos.x, pos.y)
                            first = false
                        } else {
                            ctx.lineTo(pos.x, pos.y)
                        }
                    }
                }

                ctx.stroke()
                ctx.globalAlpha = 1.0
            }

            function drawBearingPoint(ctx, point) {
                var pos = getPointPosition(point.bearing, point.timeMinutes)
                var normalizedTime = point.timeMinutes / totalTimeMinutes
                var opacity = 0.4 + 0.6 * (1 - normalizedTime)

                ctx.globalAlpha = opacity
                ctx.fillStyle = point.color
                ctx.strokeStyle = point.color
                ctx.lineWidth = 2

                // Draw point
                ctx.beginPath()
                ctx.arc(pos.x, pos.y, 5, 0, 2 * Math.PI)
                ctx.fill()
                ctx.stroke()

                // Label for current points
                if (point.timeMinutes < totalTimeMinutes * 0.05) {
                    ctx.fillStyle = "white"
                    ctx.font = "11px Arial"
                    ctx.textAlign = "center"
                    ctx.fillText(point.label, pos.x, pos.y - 12)
                }

                ctx.globalAlpha = 1.0
            }

            function getPointPosition(bearing, timeMinutes) {
                var normalizedTime = timeMinutes / totalTimeMinutes

                if (animationProgress < 0.5) {
                    // Polar coordinates
                    var angleRad = (bearing - 90) * Math.PI / 180
                    var radius = maxRadius * (1 - normalizedTime)
                    return {
                        x: radius * Math.cos(angleRad),
                        y: radius * Math.sin(angleRad)
                    }
                } else {
                    // Transform to BRG coordinates
                    var progress = (animationProgress - 0.5) * 2

                    // Polar position
                    var angleRad = (bearing - 90) * Math.PI / 180
                    var polarRadius = maxRadius * (1 - normalizedTime)
                    var polarX = polarRadius * Math.cos(angleRad)
                    var polarY = polarRadius * Math.sin(angleRad)

                    // BRG position
                    var brgX = bearingToX(bearing)
                    var brgY = timeToY(timeMinutes)

                    // Interpolate
                    return {
                        x: polarX * (1 - progress) + brgX * progress,
                        y: polarY * (1 - progress) + brgY * progress
                    }
                }
            }

            function bearingToX(bearing) {
                // Map bearing (0-360) to plot width
                var normalizedBearing = bearing / 360
                return -plotWidth / 2 + normalizedBearing * plotWidth
            }

            function timeToY(timeMinutes) {
                // Map time (0-240) to plot height, with 0 at bottom
                var normalizedTime = timeMinutes / totalTimeMinutes
                return plotHeight / 2 - normalizedTime * plotHeight
            }

            // Repaint on property changes
            Connections {
                target: window
                function onAnimationProgressChanged() { plotCanvas.requestPaint() }
                function onTimeProgressChanged() { plotCanvas.requestPaint() }
            }

            // Repaint on resize
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
        }
    }

    // Animations
    NumberAnimation {
        id: toLineAnimation
        target: window
        property: "animationProgress"
        from: animationProgress
        to: 1.0
        duration: 3000
        easing.type: Easing.OutCubic
    }

    NumberAnimation {
        id: toCircleAnimation
        target: window
        property: "animationProgress"
        from: animationProgress
        to: 0.0
        duration: 3000
        easing.type: Easing.OutCubic
    }

    SequentialAnimation {
        id: timeAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: window
            property: "timeProgress"
            from: 0.0
            to: 1.0
            duration: 4000
            easing.type: Easing.Linear
        }

        PauseAnimation { duration: 1000 }

        NumberAnimation {
            target: window
            property: "timeProgress"
            from: 1.0
            to: 0.0
            duration: 4000
            easing.type: Easing.Linear
        }

        PauseAnimation { duration: 1000 }
    }
}
*/

// version 1 not better
/*
ApplicationWindow {
    id: window
    visible: true

    width: fullWidth - 2 * padding
    height:  fullHeight - 2 * padding
    title: "Polar Coordinate with Bearing Points Animation"
    color: "#1a1a1a"

    property real animationProgress: 0.0
    property real fullWidth: 500
    property real fullHeight: 500
    property real padding: 30
    property real halfWidth: width / 2
    property real halfHeight: height / 2
    property real centerX: window.width / 2
    property real centerY: window.height / 2
    property real timeAxisPadding: 40
    property real dynamicPaddingForTimeAxis: animationProgress * timeAxisPadding

    // Time progression for bearing points (0 to 1, where 1 = 5 seconds ago to now)
    property real timeProgress: 0.0

    // Dummy bearing data - represents a target moving over time
    // Each point: {bearing: degrees, time: 0-1 (where 0=now, 1=5sec ago), color: string}
    property var bearingData: [
        // Target 1: Moving from 45° to 90° over time
        {bearing: 45, time: 1.0, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 52, time: 0.8, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 61, time: 0.6, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 72, time: 0.4, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 85, time: 0.2, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 90, time: 0.0, color: "#ff6b6b", label: "Target A", id: 1},

        // Target 2: Moving from 270° to 225° over time
        {bearing: 270, time: 1.0, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 260, time: 0.8, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 248, time: 0.6, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 240, time: 0.4, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 232, time: 0.2, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 225, time: 0.0, color: "#4ecdc4", label: "Target B", id: 2},

        // Target 3: Steady bearing (collision course)
        {bearing: 180, time: 1.0, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, time: 0.8, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, time: 0.6, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, time: 0.4, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, time: 0.2, color: "#f39c12", label: "Target C", id: 3},
        {bearing: 180, time: 0.0, color: "#f39c12", label: "Target C", id: 3}
    ]

    // Tick data - matches the original Svelte implementation
    property var ticksData: [
        {angle: 180, label: "180°", dy: 15},
        {angle: 225, label: "", dy: 0},
        {angle: 270, label: "270°", dy: -5},
        {angle: 315, label: "", dy: 0},
        {angle: 0, label: "0° (360°)", dy: 0},
        {angle: 45, label: "", dy: 0},
        {angle: 90, label: "90°", dy: -5},
        {angle: 135, label: "", dy: 0},
        {angle: 179.999, label: "180°", dy: 15}
    ]

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 160
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 12

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Polar Coordinate with Bearing Points Animation"
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "▶ Unwrap to BRG"
                    onClicked: toLineAnimation.start()
                }

                Button {
                    text: "◀ Wrap to Polar"
                    onClicked: toCircleAnimation.start()
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toLineAnimation.stop()
                        toCircleAnimation.stop()
                        animationProgress = 0
                        timeProgress = 0
                    }
                }

                Button {
                    text: "⏯️ Time Progress"
                    onClicked: timeAnimation.running ? timeAnimation.stop() : timeAnimation.start()
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Coordinate Transform:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: progressSlider
                    from: 0
                    to: 1
                    value: animationProgress
                    width: 150
                    onValueChanged: {
                        if (!toLineAnimation.running && !toCircleAnimation.running) {
                            animationProgress = value
                        }
                    }
                }

                Text {
                    text: Math.round(animationProgress * 100) + "%"
                    color: "#4fc3f7"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Time History:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: timeSlider
                    from: 0
                    to: 1
                    value: timeProgress
                    width: 150
                    onValueChanged: {
                        if (!timeAnimation.running) {
                            timeProgress = value
                        }
                    }
                }

                Text {
                    text: (5 * (1 - timeProgress)).toFixed(1) + "s ago"
                    color: "#a6e3a1"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60
                }
            }
        }
    }

    // Main animation area
    Rectangle {
        id: animationArea
        anchors.top: controlPanel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: infoPanel.top
        color: "transparent"

        Canvas {
            id: polarCanvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Move to center
                ctx.translate(centerX, centerY)

                // Set up styles
                ctx.strokeStyle = "#666666"
                ctx.fillStyle = "white"
                ctx.lineWidth = 1
                ctx.font = "12px Arial"
                ctx.textAlign = "center"

                // Draw the main circle/line path
                drawCirclePath(ctx)

                // Draw radial lines (tick marks)
                drawRadialLines(ctx)

                // Draw bearing points and trails
                drawBearingPoints(ctx)

                // Draw labels
                drawLabels(ctx)

                // Draw time axis (appears during animation)
                if (animationProgress > 0.9) {
                    drawTimeAxis(ctx)
                }

                // Reset transform
                ctx.setTransform(1, 0, 0, 1, 0, 0)
            }

            function drawCirclePath(ctx) {
                var topFactor = (12 + 3 * animationProgress) / 16
                var circlePathRadius = halfWidth * topFactor

                ctx.beginPath()
                ctx.strokeStyle = "#888888"
                ctx.lineWidth = 2

                var first = true
                // Create circle degrees array: [180, 181, ..., 359, 0, 1, ..., 179, 179.9]
                for (var i = 180; i < 360; i++) {
                    var point = getLineDataFromAngle(i, circlePathRadius)
                    if (first) {
                        ctx.moveTo(point.x1, point.y1)
                        first = false
                    } else {
                        ctx.lineTo(point.x1, point.y1)
                    }
                }

                for (var i = 0; i < 180; i++) {
                    var point = getLineDataFromAngle(i, circlePathRadius)
                    ctx.lineTo(point.x1, point.y1)
                }

                // Close to 179.9 degrees
                var closePoint = getLineDataFromAngle(179.9, circlePathRadius)
                ctx.lineTo(closePoint.x1, closePoint.y1)

                ctx.stroke()
            }

            function drawRadialLines(ctx) {
                ctx.strokeStyle = "#666666"
                ctx.lineWidth = 1

                for (var i = 0; i < ticksData.length; i++) {
                    var tick = ticksData[i]
                    var lineData = getLineDataFromAngle(tick.angle)

                    ctx.beginPath()
                    ctx.moveTo(lineData.x1, lineData.y1)
                    ctx.lineTo(lineData.x2, lineData.y2)
                    ctx.stroke()
                }

                // Draw connection line at bottom
                var line180 = getLineDataFromAngle(180)
                var line179 = getLineDataFromAngle(179.9)
                ctx.beginPath()
                ctx.moveTo(line180.x2, line180.y2)
                ctx.lineTo(line179.x2, line179.y2)
                ctx.stroke()
            }

            function drawBearingPoints(ctx) {
                // Group points by target ID for trail drawing
                var targetTrails = {}

                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]
                    if (!targetTrails[point.id]) {
                        targetTrails[point.id] = []
                    }
                    targetTrails[point.id].push(point)
                }

                // Draw trails for each target
                for (var targetId in targetTrails) {
                    var trail = targetTrails[targetId]
                    if (trail.length > 1) {
                        drawBearingTrail(ctx, trail)
                    }
                }

                // Draw current points (only those at or before current time)
                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]

                    // Only show points that are at or before current time progress
                    if (point.time >= (1 - timeProgress)) {
                        drawBearingPoint(ctx, point)
                    }
                }
            }

            function drawBearingTrail(ctx, trail) {
                if (trail.length < 2) return

                ctx.strokeStyle = trail[0].color
                ctx.lineWidth = 2
                ctx.globalAlpha = 0.4

                ctx.beginPath()
                var first = true

                for (var i = 0; i < trail.length; i++) {
                    var point = trail[i]

                    // Only include points that should be visible
                    if (point.time >= (1 - timeProgress)) {
                        var bearingPoint = getBearingPointPosition(point.bearing, point.time)

                        if (first) {
                            ctx.moveTo(bearingPoint.x, bearingPoint.y)
                            first = false
                        } else {
                            ctx.lineTo(bearingPoint.x, bearingPoint.y)
                        }
                    }
                }

                ctx.stroke()
                ctx.globalAlpha = 1.0
            }

            function drawBearingPoint(ctx, point) {
                var pos = getBearingPointPosition(point.bearing, point.time)

                // Calculate opacity based on time (newer points are more opaque)
                var opacity = 0.3 + 0.7 * (1 - point.time)

                ctx.globalAlpha = opacity
                ctx.fillStyle = point.color
                ctx.strokeStyle = point.color
                ctx.lineWidth = 2

                // Draw point
                ctx.beginPath()
                ctx.arc(pos.x, pos.y, 4, 0, 2 * Math.PI)
                ctx.fill()
                ctx.stroke()

                // Draw label for current time points
                if (point.time < 0.1) { // Current time
                    ctx.fillStyle = "white"
                    ctx.font = "10px Arial"
                    ctx.textAlign = "center"
                    ctx.fillText(point.label, pos.x, pos.y - 10)

                    // Draw bearing line from center to point
                    ctx.strokeStyle = point.color
                    ctx.lineWidth = 1
                    ctx.globalAlpha = 0.6
                    ctx.beginPath()
                    ctx.moveTo(0, 0) // Center
                    ctx.lineTo(pos.x, pos.y)
                    ctx.stroke()
                }

                ctx.globalAlpha = 1.0
            }

            function getBearingPointPosition(bearing, timeValue) {
                // In polar mode: bearing = angle, time = radius
                // In BRG mode: bearing = x position, time = y position

                if (animationProgress < 0.1) {
                    // Pure polar coordinates
                    var angleRad = (bearing - 90) * Math.PI / 180 // -90 to make 0° point up
                    var radius = (halfWidth * 0.8) * (1 - timeValue) // Newer = closer to center
                    return {
                        x: radius * Math.cos(angleRad),
                        y: radius * Math.sin(angleRad)
                    }
                } else {
                    // Transform using the same logic as the coordinate system
                    var transformedPoint = getLineDataFromAngle(bearing, halfWidth * 0.8 * (1 - timeValue))
                    return {
                        x: transformedPoint.x1,
                        y: transformedPoint.y1
                    }
                }
            }

            function drawLabels(ctx) {
                ctx.fillStyle = "white"
                ctx.textAlign = "center"
                ctx.font = "12px Arial"

                var tickEndDy = -5

                for (var i = 0; i < ticksData.length; i++) {
                    var tick = ticksData[i]
                    if (tick.label.length > 0 &&
                        !(Math.floor(tick.angle) === 179 && animationProgress === 0)) {

                        var lineData = getLineDataFromAngle(tick.angle)
                        var dy = tickEndDy * animationProgress + (1 - animationProgress) * tick.dy

                        ctx.fillText(tick.label, lineData.x1, lineData.y1 + dy)
                    }
                }
            }

            function drawTimeAxis(ctx) {
                var opacity = Math.max(0, 10 * (animationProgress - 0.9))
                ctx.globalAlpha = opacity

                ctx.strokeStyle = "#888888"
                ctx.lineWidth = 2
                ctx.fillStyle = "white"
                ctx.textAlign = "end"

                var timeAxisTop = -halfHeight * ((12 + 3 * animationProgress) / 16)
                var timeAxisX = -halfWidth + timeAxisPadding - 10

                // Draw time axis
                ctx.fillText("Now", timeAxisX - 20, timeAxisTop + 5)

                ctx.beginPath()
                ctx.moveTo(timeAxisX - 15, timeAxisTop)
                ctx.lineTo(timeAxisX, timeAxisTop)
                ctx.moveTo(timeAxisX, timeAxisTop)
                ctx.lineTo(timeAxisX, halfHeight)
                ctx.moveTo(timeAxisX - 15, halfHeight)
                ctx.lineTo(timeAxisX, halfHeight)
                ctx.stroke()

                ctx.fillText("5 sec", timeAxisX - 20, halfHeight - 5)
                ctx.fillText("ago", timeAxisX - 20, halfHeight + 10)

                ctx.globalAlpha = 1.0
            }

            // Redraw when animation progresses
            Connections {
                target: window
                function onAnimationProgressChanged() {
                    polarCanvas.requestPaint()
                }
            }

            Connections {
                target: window
                function onTimeProgressChanged() {
                    polarCanvas.requestPaint()
                }
            }
        }
    }

    // Core transformation functions (matching the Svelte implementation exactly)
    function x2Scale(angle) {
        // Linear interpolation for x2 coordinates
        var domain = [0, 180, 180, 360]
        var range = [
            dynamicPaddingForTimeAxis / 2,
            animationProgress * halfWidth,
            -animationProgress * halfWidth + dynamicPaddingForTimeAxis,
            dynamicPaddingForTimeAxis / 2
        ]

        // Find the appropriate segment
        if (angle <= 180) {
            var t = angle / 180
            return range[0] + t * (range[1] - range[0])
        } else {
            var t = (angle - 180) / 180
            return range[2] + t * (range[3] - range[2])
        }
    }

    function y2Value() {
        return animationProgress * halfHeight
    }

    function thetaScale(angle) {
        // Linear interpolation for theta (angle transformation)
        var domain = [0, 180, 180, 360]
        var range = [0, (1 - animationProgress) * 180, (animationProgress - 1) * 180, 0]

        if (angle <= 180) {
            var t = angle / 180
            return range[0] + t * (range[1] - range[0])
        } else {
            var t = (angle - 180) / 180
            return range[2] + t * (range[3] - range[2])
        }
    }

    function getLineDataFromAngle(angle, radius) {
        if (radius === undefined) radius = halfWidth

        var x2 = x2Scale(angle)
        var y2 = y2Value()
        var theta = thetaScale(angle) * Math.PI / 180 // Convert to radians

        return {
            x1: x2 + radius * Math.sin(theta),
            y1: -radius * Math.cos(theta),
            x2: x2,
            y2: y2
        }
    }

    // Animations
    NumberAnimation {
        id: toLineAnimation
        target: window
        property: "animationProgress"
        from: 0.0
        to: 1.0
        duration: 4000
        easing.type: Easing.OutCubic
    }

    NumberAnimation {
        id: toCircleAnimation
        target: window
        property: "animationProgress"
        from: 1.0
        to: 0.0
        duration: 4000
        easing.type: Easing.OutCubic
    }

    // Time progression animation
    SequentialAnimation {
        id: timeAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: window
            property: "timeProgress"
            from: 0.0
            to: 1.0
            duration: 3000
            easing.type: Easing.Linear
        }

        PauseAnimation {
            duration: 500
        }
    }

    // Information panel
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 180
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: {
                    var p = animationProgress
                    if (p < 0.1) return "🔵 Polar Display: Bearing = Angle, Time = Radius"
                    else if (p < 0.3) return "📐 Transforming coordinates..."
                    else if (p < 0.6) return "📈 Circle unwrapping to BRG..."
                    else if (p < 0.9) return "📊 Bearing Rate Graph forming..."
                    else return "✅ BRG View: Bearing = X-axis, Time = Y-axis"
                }
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 40
                height: 1
                color: "#444444"
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30

                Column {
                    Text {
                        text: "🎯 Target Legend:"
                        color: "#cdd6f4"
                        font.pixelSize: 12
                        font.bold: true
                    }
                    Text {
                        text: "● Target A (Red) - Moving Right"
                        color: "#ff6b6b"
                        font.pixelSize: 11
                    }
                    Text {
                        text: "● Target B (Cyan) - Moving Left"
                        color: "#4ecdc4"
                        font.pixelSize: 11
                    }
                    Text {
                        text: "● Target C (Orange) - Steady Bearing"
                        color: "#f39c12"
                        font.pixelSize: 11
                    }
                }

                Column {
                    Text {
                        text: "📡 Navigation Concepts:"
                        color: "#cdd6f4"
                        font.pixelSize: 12
                        font.bold: true
                    }
                    Text {
                        text: "• Steady bearing = Collision course"
                        color: "#fab387"
                        font.pixelSize: 11
                    }
                    Text {
                        text: "• Changing bearing = Safe pass"
                        color: "#a6e3a1"
                        font.pixelSize: 11
                    }
                    Text {
                        text: "• Trail shows movement history"
                        color: "#94e2d5"
                        font.pixelSize: 11
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "💡 Use 'Time Progress' to see how bearing points evolve over 5 seconds"
                color: "#cba6f7"
                font.pixelSize: 12
                font.italic: true
            }
        }
    }
}

*/

// version 2 is better
/*
ApplicationWindow {
    id: window
    visible: true

    width: fullWidth - 2 * padding
    height: fullHeight - 2 * padding
    title: "Polar Coordinate with Bearing Points Animation"
    color: "transparent"

    property real animationProgress: 0.0
    property real fullWidth: 500
    property real fullHeight: 500
    property real padding: 30
    property real halfWidth: width / 4
    property real halfHeight: height / 3
    property real centerX: window.width / 2
    property real centerY: window.height / 2
    property real timeAxisPadding: 40
    property real dynamicPaddingForTimeAxis: animationProgress * timeAxisPadding

    // Time progression for bearing points (0 to 1, where 1 = 5 seconds ago to now)
    property real timeProgress: 0.0

    // Y-axis range configuration
    property real yAxisMin: 0
    property real yAxisMax: 240
    property int yAxisTicks: 7

    // Bearing and Range data - represents targets at different distances
    // Each point: {bearing: degrees, range: meters (0-240), time: 0-1, color: string}
    property var bearingData: [
        // Target 1: Approaching from 200m to 80m, bearing changing from 45° to 90°
        {bearing: 45, range: 200, time: 1.0, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 52, range: 170, time: 0.8, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 61, range: 140, time: 0.6, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 72, range: 110, time: 0.4, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 85, range: 95, time: 0.2, color: "#ff6b6b", label: "Target A", id: 1},
        {bearing: 90, range: 80, time: 0.0, color: "#ff6b6b", label: "Target A", id: 1},

        // Target 2: Moving away from 120m to 180m, bearing changing
        {bearing: 270, range: 120, time: 1.0, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 260, range: 130, time: 0.8, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 248, range: 145, time: 0.6, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 240, range: 160, time: 0.4, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 232, range: 170, time: 0.2, color: "#4ecdc4", label: "Target B", id: 2},
        {bearing: 225, range: 180, time: 0.0, color: "#4ecdc4", label: "Target B", id: 2},

        // Target 3: Steady bearing, approaching from 240m to 60m (collision course!)
        {bearing: 180, range: 240, time: 1.0, color: "#f39c12", label: "Target C -"}
]

    // Tick data - matches the original Svelte implementation
    property var ticksData: [
        {angle: 180, label: "180°", dy: 15},
        {angle: 225, label: "", dy: 0},
        {angle: 270, label: "270°", dy: -5},
        {angle: 315, label: "", dy: 0},
        {angle: 0, label: "0° (360°)", dy: 0},
        {angle: 45, label: "", dy: 0},
        {angle: 90, label: "90°", dy: -5},
        {angle: 135, label: "", dy: 0},
        {angle: 179.999, label: "180°", dy: 15}
    ]

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.right: parent.right
        height: 160
        color: "transparent"

        Column {
            anchors.centerIn: parent
            spacing: 12

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Polar Coordinate with Bearing Points Animation"
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "▶ Unwrap to BRG"
                    onClicked: toLineAnimation.start()
                }

                Button {
                    text: "◀ Wrap to Polar"
                    onClicked: toCircleAnimation.start()
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toLineAnimation.stop()
                        toCircleAnimation.stop()
                        animationProgress = 0
                        timeProgress = 0
                    }
                }

                Button {
                    text: "⏯️ Time Progress"
                    onClicked: timeAnimation.running ? timeAnimation.stop() : timeAnimation.start()
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Coordinate Transform:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: progressSlider
                    from: 0
                    to: 1
                    value: animationProgress
                    width: 150
                    onValueChanged: {
                        if (!toLineAnimation.running && !toCircleAnimation.running) {
                            animationProgress = value
                        }
                    }
                }

                Text {
                    text: Math.round(animationProgress * 100) + "%"
                    color: "#4fc3f7"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Time History:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: timeSlider
                    from: 0
                    to: 1
                    value: timeProgress
                    width: 150
                    onValueChanged: {
                        if (!timeAnimation.running) {
                            timeProgress = value
                        }
                    }
                }

                Text {
                    text: (240 * (1 - timeProgress)).toFixed(0) + " min ago"
                    color: "#a6e3a1"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    width: 80
                }
            }
        }
    }

    // Main animation area
    Rectangle {
        id: animationArea
        anchors.top: controlPanel.bottom
        width: parent.width
        height: parent.height * 0.9
        color: "transparent"
        border.width: 2
        border.color: "white"
        anchors.centerIn: parent

        Canvas {
            id: polarCanvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Move to center
                ctx.translate(centerX, centerY)

                // Set up styles
                ctx.strokeStyle = "#666666"
                ctx.fillStyle = "white"
                ctx.lineWidth = 1
                ctx.textAlign = "center"

                // Draw the main circle/line path
                drawCirclePath(ctx)

                // Draw radial lines (tick marks)
                drawRadialLines(ctx)

                // Draw bearing points and trails
                drawBearingPoints(ctx)

                // Draw labels
                drawLabels(ctx)

                // Draw Y-axis with proper scale (0-240)
                if (animationProgress > 0.9) {
                    drawYAxis(ctx)
                }

                // Reset transform
                ctx.setTransform(1, 0, 0, 1, 0, 0)
            }

            function drawCirclePath(ctx) {
                var topFactor = (12 + 3 * animationProgress) / 16
                var circlePathRadius = halfWidth * topFactor

                ctx.beginPath()
                ctx.strokeStyle = "#888888"
                ctx.lineWidth = 2

                var first = true
                // Create circle degrees array: [180, 181, ..., 359, 0, 1, ..., 179, 179.9]
                for (var i = 180; i < 360; i++) {
                    var point = getLineDataFromAngle(i, circlePathRadius)
                    if (first) {
                        ctx.moveTo(point.x1, point.y1)
                        first = false
                    } else {
                        ctx.lineTo(point.x1, point.y1)
                    }
                }

                for (var i = 0; i < 180; i++) {
                    var point = getLineDataFromAngle(i, circlePathRadius)
                    ctx.lineTo(point.x1, point.y1)
                }

                // Close to 179.9 degrees
                var closePoint = getLineDataFromAngle(179.9, circlePathRadius)
                ctx.lineTo(closePoint.x1, closePoint.y1)

                ctx.stroke()
            }

            function drawRadialLines(ctx) {
                ctx.strokeStyle = "#666666"
                ctx.lineWidth = 1

                for (var i = 0; i < ticksData.length; i++) {
                    var tick = ticksData[i]
                    var lineData = getLineDataFromAngle(tick.angle)

                    ctx.beginPath()
                    ctx.moveTo(lineData.x1, lineData.y1)
                    ctx.lineTo(lineData.x2, lineData.y2)
                    ctx.stroke()
                }

                // Draw connection line at bottom
                var line180 = getLineDataFromAngle(180)
                var line179 = getLineDataFromAngle(179.9)
                ctx.beginPath()
                ctx.moveTo(line180.x2, line180.y2)
                ctx.lineTo(line179.x2, line179.y2)
                ctx.stroke()
            }

            function drawBearingPoints(ctx) {
                // Group points by target ID for trail drawing
                var targetTrails = {}

                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]
                    if (!targetTrails[point.id]) {
                        targetTrails[point.id] = []
                    }
                    targetTrails[point.id].push(point)
                }

                // Draw trails for each target
                for (var targetId in targetTrails) {
                    var trail = targetTrails[targetId]
                    if (trail.length > 1) {
                        drawBearingTrail(ctx, trail)
                    }
                }

                // Draw current points (only those at or before current time)
                for (var i = 0; i < bearingData.length; i++) {
                    var point = bearingData[i]

                    // Only show points that are at or before current time progress
                    if (point.time >= (1 - timeProgress)) {
                        drawBearingPoint(ctx, point)
                    }
                }
            }

            function drawBearingTrail(ctx, trail) {
                if (trail.length < 2) return

                ctx.strokeStyle = trail[0].color
                ctx.lineWidth = 2
                ctx.globalAlpha = 0.4

                ctx.beginPath()
                var first = true

                for (var i = 0; i < trail.length; i++) {
                    var point = trail[i]

                    // Only include points that should be visible
                    if (point.time >= (1 - timeProgress)) {
                        var bearingPoint = getBearingPointPosition(point.bearing, point.time)

                        if (first) {
                            ctx.moveTo(bearingPoint.x, bearingPoint.y)
                            first = false
                        } else {
                            ctx.lineTo(bearingPoint.x, bearingPoint.y)
                        }
                    }
                }

                ctx.stroke()
                ctx.globalAlpha = 1.0
            }

            function drawBearingPoint(ctx, point) {
                var pos = getBearingPointPosition(point.bearing, point.time)

                // Calculate opacity based on time (newer points are more opaque)
                var opacity = 0.3 + 0.7 * (1 - point.time)

                ctx.globalAlpha = opacity
                ctx.fillStyle = point.color
                ctx.strokeStyle = point.color
                ctx.lineWidth = 2

                // Draw point
                ctx.beginPath()
                ctx.arc(pos.x, pos.y, 4, 0, 2 * Math.PI)
                ctx.fill()
                ctx.stroke()

                // Draw label for current time points
                if (point.time < 0.1) { // Current time
                    ctx.fillStyle = "white"
                    ctx.textAlign = "center"
                    ctx.fillText(point.label, pos.x, pos.y - 10)

                    // Draw bearing line from center to point
                    ctx.strokeStyle = point.color
                    ctx.lineWidth = 1
                    ctx.globalAlpha = 0.6
                    ctx.beginPath()
                    ctx.moveTo(0, 0) // Center
                    ctx.lineTo(pos.x, pos.y)
                    ctx.stroke()
                }

                ctx.globalAlpha = 1.0
            }

            function getBearingPointPosition(bearing, timeValue) {
                // INVERTED: Data flows from circumference (old) to center (new)
                // In polar mode: bearing = angle, time = radius (inverted)
                // In BRG mode: bearing = x position, time = y position

                if (animationProgress < 0.1) {
                    // Pure polar coordinates - INVERTED radius
                    var angleRad = (bearing - 90) * Math.PI / 180 // -90 to make 0° point up
                    var radius = (halfWidth * 0.8) * timeValue // INVERTED: Older = farther from center
                    return {
                        x: radius * Math.cos(angleRad),
                        y: radius * Math.sin(angleRad)
                    }
                } else {
                    // Transform using the same logic as the coordinate system
                    var transformedPoint = getLineDataFromAngle(bearing, halfWidth * 0.8 * timeValue)

                    // In BRG mode, map time to Y-axis (0-240 range)
                    if (animationProgress > 0.9) {
                        // Map timeValue (0-1) to yAxis range (0-240)
                        var yPosition = -halfHeight + (2 * halfHeight * timeValue)
                        transformedPoint.y1 = yPosition
                    }

                    return {
                        x: transformedPoint.x1,
                        y: transformedPoint.y1
                    }
                }
            }

            function drawLabels(ctx) {
                ctx.fillStyle = "white"
                ctx.textAlign = "center"

                var tickEndDy = -5

                for (var i = 0; i < ticksData.length; i++) {
                    var tick = ticksData[i]
                    if (tick.label.length > 0 &&
                        !(Math.floor(tick.angle) === 179 && animationProgress === 0)) {

                        var lineData = getLineDataFromAngle(tick.angle)
                        var dy = tickEndDy * animationProgress + (1 - animationProgress) * tick.dy

                        ctx.fillText(tick.label, lineData.x1, lineData.y1 + dy)
                    }
                }
            }

            function drawYAxis(ctx) {
                var opacity = Math.max(0, 10 * (animationProgress - 0.9))
                ctx.globalAlpha = opacity

                ctx.strokeStyle = "#888888"
                ctx.lineWidth = 2
                ctx.fillStyle = "white"
                ctx.textAlign = "end"

                var yAxisX = -halfWidth + timeAxisPadding - 10
                var yAxisTop = -halfHeight
                var yAxisBottom = halfHeight

                // Draw Y-axis title
                ctx.save()
                ctx.translate(yAxisX - 40, 0)
                ctx.rotate(-Math.PI / 2)
                ctx.textAlign = "center"
                ctx.fillText("Range (meters)", 0, 0)
                ctx.restore()

                // Draw Y-axis line
                ctx.beginPath()
                ctx.moveTo(yAxisX, yAxisTop)
                ctx.lineTo(yAxisX, yAxisBottom)
                ctx.stroke()

                // Draw Y-axis ticks and labels (0 to 240 in 7 ticks)
                for (var i = 0; i <= yAxisTicks; i++) {
                    var t = i / yAxisTicks
                    var y = yAxisTop + t * (yAxisBottom - yAxisTop)
                    var value = yAxisMin + (yAxisMax - yAxisMin) * (1 - t) // Inverted to go from top to bottom

                    // Draw tick
                    ctx.beginPath()
                    ctx.moveTo(yAxisX - 10, y)
                    ctx.lineTo(yAxisX, y)
                    ctx.stroke()

                    // Draw label
                    ctx.textAlign = "end"
                    ctx.fillText(Math.round(value).toString(), yAxisX - 15, y + 4)
                }

                // Add grid lines for better readability
                ctx.strokeStyle = "#444444"
                ctx.lineWidth = 0.5
                ctx.setLineDash([2, 4])

                for (var i = 0; i <= yAxisTicks; i++) {
                    var t = i / yAxisTicks
                    var y = yAxisTop + t * (yAxisBottom - yAxisTop)

                    ctx.beginPath()
                    ctx.moveTo(yAxisX, y)
                    ctx.lineTo(halfWidth + dynamicPaddingForTimeAxis / 2, y)
                    ctx.stroke()
                }

                ctx.setLineDash([])
                ctx.globalAlpha = 1.0
            }

            // Redraw when animation progresses
            Connections {
                target: window
                function onAnimationProgressChanged() {
                    polarCanvas.requestPaint()
                }
            }

            Connections {
                target: window
                function onTimeProgressChanged() {
                    polarCanvas.requestPaint()
                }
            }
        }
    }

    // Core transformation functions (matching the Svelte implementation exactly)
    function x2Scale(angle) {
        // Linear interpolation for x2 coordinates
        var domain = [0, 180, 180, 360]
        var range = [
            dynamicPaddingForTimeAxis / 2,
            animationProgress * halfWidth,
            -animationProgress * halfWidth + dynamicPaddingForTimeAxis,
            dynamicPaddingForTimeAxis / 2
        ]

        // Find the appropriate segment
        if (angle <= 180) {
            var t = angle / 180
            return range[0] + t * (range[1] - range[0])
        } else {
            var t = (angle - 180) / 180
            return range[2] + t * (range[3] - range[2])
        }
    }

    function y2Value() {
        return animationProgress * halfHeight
    }

    function thetaScale(angle) {
        // Linear interpolation for theta (angle transformation)
        var domain = [0, 180, 180, 360]
        var range = [0, (1 - animationProgress) * 180, (animationProgress - 1) * 180, 0]

        if (angle <= 180) {
            var t = angle / 180
            return range[0] + t * (range[1] - range[0])
        } else {
            var t = (angle - 180) / 180
            return range[2] + t * (range[3] - range[2])
        }
    }

    function getLineDataFromAngle(angle, radius) {
        if (radius === undefined) radius = halfWidth

        var x2 = x2Scale(angle)
        var y2 = y2Value()
        var theta = thetaScale(angle) * Math.PI / 180 // Convert to radians

        return {
            x1: x2 + radius * Math.sin(theta),
            y1: -radius * Math.cos(theta),
            x2: x2,
            y2: y2
        }
    }

    // Animations
    NumberAnimation {
        id: toLineAnimation
        target: window
        property: "animationProgress"
        from: 0.0
        to: 1.0
        duration: 4000
        easing.type: Easing.OutCubic
    }

    NumberAnimation {
        id: toCircleAnimation
        target: window
        property: "animationProgress"
        from: 1.0
        to: 0.0
        duration: 4000
        easing.type: Easing.OutCubic
    }

    // Time progression animation
    SequentialAnimation {
        id: timeAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: window
            property: "timeProgress"
            from: 0.0
            to: 1.0
            duration: 3000
            easing.type: Easing.Linear
        }

        PauseAnimation {
            duration: 500
        }
    }
}
*/
