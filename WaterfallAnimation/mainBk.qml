import QtQuick 2.15
import QtQuick.Controls 2.15

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
/*
ApplicationWindow {
    id: window
    visible: true
    width: fullWidth - 2 * padding
    height:  fullHeight - 2 * padding
    title: "Polar Coordinate Unwrapping - Fixed Animation"
    color: "#1a1a1a"

    property real animationProgress: 0.0
    property real fullWidth: 500
    property real fullHeight: 500
    property real padding: 30
    // property real width: fullWidth - 2 * padding
    // property real height: fullHeight - 2 * padding
    property real halfWidth: width / 2
    property real halfHeight: height / 2
    property real centerX: window.width / 2
    property real centerY: window.height / 2
    property real timeAxisPadding: 40
    property real dynamicPaddingForTimeAxis: animationProgress * timeAxisPadding

    // Force update trigger
    property int updateTrigger: 0
    onAnimationProgressChanged: updateTrigger++

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 15

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Polar Coordinate Unwrapping - Fixed Animation"
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "▶ Unwrap to Line"
                    onClicked: {
                        console.log("Starting unwrap animation")
                        toLineAnimation.start()
                    }
                }

                Button {
                    text: "◀ Wrap to Circle"
                    onClicked: {
                        console.log("Starting wrap animation")
                        toCircleAnimation.start()
                    }
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toLineAnimation.stop()
                        toCircleAnimation.stop()
                        animationProgress = 0
                        console.log("Reset to progress:", animationProgress)
                    }
                }

                Button {
                    text: "🔄 Loop"
                    onClicked: loopAnimation.start()
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Manual:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: progressSlider
                    from: 0
                    to: 1
                    value: animationProgress
                    width: 200
                    onValueChanged: {
                        if (!toLineAnimation.running && !toCircleAnimation.running && !loopAnimation.running) {
                            animationProgress = value
                            console.log("Manual progress:", animationProgress)
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

        // Debug indicator to show the center
        Rectangle {
            x: centerX - 2
            y: centerY - 2
            width: 4
            height: 4
            color: "#ff6b6b"
            radius: 2
        }

        // Main morphing shape
        Shape {
            id: morphingShape
            anchors.fill: parent

            // Add this to force updates
            property int triggerUpdate: updateTrigger
            onTriggerUpdateChanged: {
                console.log("Shape update triggered, progress:", animationProgress)
            }

            ShapePath {
                strokeWidth: 3
                strokeColor: "#89b4fa"
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                PathSvg {
                    id: morphPath
                    path: generateMorphingPath()

                    // Force path updates
                    property int updateCounter: updateTrigger
                    onUpdateCounterChanged: {
                        path = generateMorphingPath()
                        console.log("Path updated:", path.substring(0, 50) + "...")
                    }
                }
            }
        }

        // Tick lines
        Repeater {
            model: 8

            Shape {
                anchors.fill: parent

                property real angle: index * 45 // 0, 45, 90, 135, 180, 225, 270, 315
                property var startPoint: getTransformedPoint(angle, halfWidth * 0.9)
                property var endPoint: getTransformedPoint(angle, halfWidth * 0.1)
                property int updateCounter: updateTrigger

                ShapePath {
                    strokeWidth: 1
                    strokeColor: "#666666"
                    fillColor: "transparent"

                    startX: centerX + parent.startPoint.x
                    startY: centerY + parent.startPoint.y

                    PathLine {
                        x: centerX + parent.endPoint.x
                        y: centerY + parent.endPoint.y
                    }
                }
            }
        }

        // Labels
        Repeater {
            model: [
                {angle: 0, label: "0°"},
                {angle: 90, label: "90°"},
                {angle: 180, label: "180°"},
                {angle: 270, label: "270°"}
            ]

            Text {
                property var labelData: modelData
                property var transformedPoint: getTransformedPoint(labelData.angle, halfWidth * 1.1)
                property int updateCounter: updateTrigger

                x: centerX + transformedPoint.x - width/2
                y: centerY + transformedPoint.y - height/2

                text: labelData.label
                color: "white"
                font.pixelSize: 14
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    // Generate morphing path function
    function generateMorphingPath() {
        var pathString = ""
        var numPoints = 180 // Reduced for debugging
        var topFactor = (12 + 3 * animationProgress) / 16
        var radius = halfWidth * topFactor

        console.log("Generating path with progress:", animationProgress, "radius:", radius)

        // Start from 180 degrees
        var firstPoint = getTransformedPoint(180, radius)
        pathString = "M " + (centerX + firstPoint.x).toFixed(1) + " " + (centerY + firstPoint.y).toFixed(1)

        // Create path: 180 -> 360 -> 0 -> 179
        for (var i = 1; i <= numPoints; i++) {
            var angle
            if (i <= 90) {
                // 181 to 270
                angle = 180 + i
            } else if (i <= 180) {
                // 271 to 360, then 0 to 89
                if (i <= 135) {
                    angle = 180 + i
                } else {
                    angle = i - 135 - 1
                }
            }
            if (angle > 360) angle -= 360

            var point = getTransformedPoint(angle, radius)
            pathString += " L " + (centerX + point.x).toFixed(1) + " " + (centerY + point.y).toFixed(1)
        }

        // Close the path
        pathString += " L " + (centerX + firstPoint.x).toFixed(1) + " " + (centerY + firstPoint.y).toFixed(1)

        return pathString
    }

    // Core transformation function
    function getTransformedPoint(angleDegrees, radius) {
        var x2 = x2Scale(angleDegrees)
        var y2 = y2Value()
        var theta = thetaScale(angleDegrees) * Math.PI / 180

        return {
            x: x2 + radius * Math.sin(theta),
            y: -radius * Math.cos(theta)
        }
    }

    function x2Scale(angle) {
        if (angle <= 180) {
            var t = angle / 180
            var start = dynamicPaddingForTimeAxis / 2
            var end = animationProgress * halfWidth
            return start + t * (end - start)
        } else {
            var t = (angle - 180) / 180
            var start = -animationProgress * halfWidth + dynamicPaddingForTimeAxis
            var end = dynamicPaddingForTimeAxis / 2
            return start + t * (end - start)
        }
    }

    function y2Value() {
        return animationProgress * halfHeight
    }

    function thetaScale(angle) {
        if (angle <= 180) {
            var t = angle / 180
            var start = 0
            var end = (1 - animationProgress) * 180
            return start + t * (end - start)
        } else {
            var t = (angle - 180) / 180
            var start = (animationProgress - 1) * 180
            var end = 0
            return start + t * (end - start)
        }
    }

    // Animations with debug output
    NumberAnimation {
        id: toLineAnimation
        target: window
        property: "animationProgress"
        from: 0.0
        to: 1.0
        duration: 4000
        easing.type: Easing.OutCubic

        onStarted: console.log("Animation to line started")
        onFinished: console.log("Animation to line finished")
    }

    NumberAnimation {
        id: toCircleAnimation
        target: window
        property: "animationProgress"
        from: 1.0
        to: 0.0
        duration: 4000
        easing.type: Easing.OutCubic

        onStarted: console.log("Animation to circle started")
        onFinished: console.log("Animation to circle finished")
    }

    SequentialAnimation {
        id: loopAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: window
            property: "animationProgress"
            from: 0.0
            to: 1.0
            duration: 3000
            easing.type: Easing.InOutCubic
        }

        PauseAnimation { duration: 1000 }

        NumberAnimation {
            target: window
            property: "animationProgress"
            from: 1.0
            to: 0.0
            duration: 3000
            easing.type: Easing.InOutCubic
        }

        PauseAnimation { duration: 1000 }
    }

    // Information panel
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: {
                    var p = animationProgress
                    if (p < 0.1) return "🔵 Polar coordinate circle (Progress: " + p.toFixed(2) + ")"
                    else if (p < 0.5) return "📐 Unwrapping in progress... (" + p.toFixed(2) + ")"
                    else if (p < 0.9) return "📈 Almost complete line (" + p.toFixed(2) + ")"
                    else return "✅ Complete bearing rate graph! (" + p.toFixed(2) + ")"
                }
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "🎨 QML Shapes with forced updates - Check console for debug info"
                color: "#81c784"
                font.pixelSize: 12
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "🔧 Use manual slider to test if shapes are updating properly"
                color: "#ffb74d"
                font.pixelSize: 11
                font.italic: true
            }
        }
    }
}
*/
// claude properf copy and working
import QtQuick 2.15
import QtQuick.Controls 2.15

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
/*
ApplicationWindow {
    id: window
    visible: true
    width: fullWidth - 2 * padding
    height: fullHeight - 2 * padding
    title: "Polar Coordinate Unwrapping Animation"
    color: "#1a1a1a"

    property real animationProgress: 0.0
    property real fullWidth: 500
    property real fullHeight: 500
    property real padding: 30
    // property real width: fullWidth - 2 * padding
    // property real height: fullHeight - 2 * padding
    property real halfWidth: width / 2
    property real halfHeight: height / 2
    property real centerX: window.width / 2
    property real centerY: window.height / 2
    property real timeAxisPadding: 40
    property real dynamicPaddingForTimeAxis: animationProgress * timeAxisPadding

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
        height: 120
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 15

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Polar Coordinate Unwrapping Animation"
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "▶ Unwrap to Line"
                    onClicked: toLineAnimation.start()
                }

                Button {
                    text: "◀ Wrap to Circle"
                    onClicked: toCircleAnimation.start()
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toLineAnimation.stop()
                        toCircleAnimation.stop()
                        animationProgress = 0
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Manual:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: progressSlider
                    from: 0
                    to: 1
                    value: animationProgress
                    width: 200
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

    // Information panel
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 140
        color: "#2a2a2a"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: {
                    var p = animationProgress
                    if (p < 0.1) return "🔵 Polar coordinate system (circular)"
                    else if (p < 0.3) return "📐 Radial lines straightening..."
                    else if (p < 0.6) return "📈 Circle unwrapping to horizontal line..."
                    else if (p < 0.9) return "📊 Bearing Rate Graph forming..."
                    else return "✅ Complete unwrapped BRG with time axis!"
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

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "💡 This shows how a polar coordinate system (circular) transforms into"
                color: "#81c784"
                font.pixelSize: 12
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "a rectangular coordinate system (Bearing Rate Graph)"
                color: "#81c784"
                font.pixelSize: 12
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "🎯 Used in navigation: bearings vs time analysis"
                color: "#ffb74d"
                font.pixelSize: 11
                font.italic: true
            }
        }
    }
}
*/
/*
ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Straight Line to Circle Animation"
    color: "#1e1e2e"

    property real animationProgress: 0.0
    property real lineLength: 300
    property real centerX: width / 2
    property real centerY: height / 2
    property real finalRadius: lineLength / (2 * Math.PI)

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 100
        color: "#313244"

        Column {
            anchors.centerIn: parent
            spacing: 15

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Button {
                    text: "▶ Animate to Circle"
                    onClicked: toCircleAnimation.start()
                }

                Button {
                    text: "◀ Back to Line"
                    onClicked: toLineAnimation.start()
                }

                Button {
                    text: "⟲ Reset"
                    onClicked: {
                        toCircleAnimation.stop()
                        toLineAnimation.stop()
                        animationProgress = 0
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    text: "Manual Control:"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: progressSlider
                    from: 0
                    to: 1
                    value: animationProgress
                    width: 200
                    onValueChanged: {
                        if (!toCircleAnimation.running && !toLineAnimation.running) {
                            animationProgress = value
                        }
                    }
                }

                Text {
                    text: Math.round(animationProgress * 100) + "%"
                    color: "#89b4fa"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
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

        // Reference guides
        Canvas {
            id: guidesCanvas
            anchors.fill: parent
            opacity: 0.2

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Draw center point
                ctx.fillStyle = "#f38ba8"
                ctx.beginPath()
                ctx.arc(centerX, centerY, 3, 0, 2 * Math.PI)
                ctx.fill()

                // Draw original line position
                ctx.strokeStyle = "#45475a"
                ctx.lineWidth = 2
                ctx.setLineDash([5, 5])
                ctx.beginPath()
                ctx.moveTo(centerX - lineLength/2, centerY)
                ctx.lineTo(centerX + lineLength/2, centerY)
                ctx.stroke()

                // Draw target circle
                ctx.beginPath()
                ctx.arc(centerX, centerY, finalRadius, 0, 2 * Math.PI)
                ctx.stroke()
                ctx.setLineDash([])
            }
        }

        // Main morphing shape
        Canvas {
            id: morphCanvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Set up drawing style
                ctx.strokeStyle = "#89b4fa"
                ctx.lineWidth = 4
                ctx.lineCap = "round"
                ctx.lineJoin = "round"

                // Calculate current state
                var progress = animationProgress
                var numPoints = 200 // High resolution for smooth curve

                ctx.beginPath()

                for (var i = 0; i <= numPoints; i++) {
                    var t = i / numPoints // Parameter from 0 to 1
                    var point = calculateMorphPoint(t, progress)

                    if (i === 0) {
                        ctx.moveTo(point.x, point.y)
                    } else {
                        ctx.lineTo(point.x, point.y)
                    }
                }

                ctx.stroke()

                // Draw end points
                if (progress < 0.98) {
                    var startPoint = calculateMorphPoint(0, progress)
                    var endPoint = calculateMorphPoint(1, progress)

                    // Start point (green)
                    ctx.fillStyle = "#a6e3a1"
                    ctx.beginPath()
                    ctx.arc(startPoint.x, startPoint.y, 6, 0, 2 * Math.PI)
                    ctx.fill()

                    // End point (yellow)
                    ctx.fillStyle = "#f9e2af"
                    ctx.beginPath()
                    ctx.arc(endPoint.x, endPoint.y, 6, 0, 2 * Math.PI)
                    ctx.fill()
                }
            }

            // Redraw when animation progresses
            Connections {
                target: window
                function onAnimationProgressChanged() {
                    morphCanvas.requestPaint()
                    guidesCanvas.requestPaint()
                }
            }
        }
    }

    // The key function that calculates the morphing
    function calculateMorphPoint(t, progress) {
        // t goes from 0 to 1 along the shape
        // progress goes from 0 (line) to 1 (circle)

        if (progress === 0) {
            // Pure straight line
            return {
                x: centerX - lineLength/2 + t * lineLength,
                y: centerY
            }
        }

        // Calculate the bending
        var totalAngle = progress * 2 * Math.PI
        var currentRadius = finalRadius * smoothStep(progress)

        // Map t (0 to 1) to angle (0 to totalAngle)
        var angle = t * totalAngle - Math.PI/2 // Start from top

        if (progress < 1.0) {
            // Partial circle - interpolate between line and circle positions
            var lineX = centerX - lineLength/2 + t * lineLength
            var lineY = centerY

            var circleX = centerX + currentRadius * Math.cos(angle)
            var circleY = centerY + currentRadius * Math.sin(angle)

            // Use smooth interpolation
            var blendFactor = smoothStep(progress)

            return {
                x: lineX * (1 - blendFactor) + circleX * blendFactor,
                y: lineY * (1 - blendFactor) + circleY * blendFactor
            }
        } else {
            // Complete circle
            return {
                x: centerX + finalRadius * Math.cos(angle),
                y: centerY + finalRadius * Math.sin(angle)
            }
        }
    }

    // Smooth step function for better easing
    function smoothStep(t) {
        return t * t * (3 - 2 * t)
    }

    // Animations
    NumberAnimation {
        id: toCircleAnimation
        target: window
        property: "animationProgress"
        from: 0.0
        to: 1.0
        duration: 3000
        easing.type: Easing.InOutCubic
    }

    NumberAnimation {
        id: toLineAnimation
        target: window
        property: "animationProgress"
        from: 1.0
        to: 0.0
        duration: 3000
        easing.type: Easing.InOutCubic
    }

    // Information panel
    Rectangle {
        id: infoPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "#313244"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: {
                    var p = animationProgress
                    if (p < 0.05) return "🔵 Horizontal straight line (Length: " + lineLength + ")"
                    else if (p < 0.2) return "📐 Line starts bending from the center point..."
                    else if (p < 0.5) return "🌙 Curvature increases - forming an arc..."
                    else if (p < 0.8) return "⭕ Arc segments connecting smoothly..."
                    else if (p < 0.98) return "🔄 Almost complete circle formation..."
                    else return "✅ Perfect circle! (Radius: " + finalRadius.toFixed(1) + ")"
                }
                color: "white"
                font.pixelSize: 16
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 40
                height: 1
                color: "#45475a"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "💡 Key Insight: Circumference = 2πr, so " + lineLength + " length → " + finalRadius.toFixed(1) + " radius"
                color: "#94e2d5"
                font.pixelSize: 12
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "The line bends smoothly from its midpoint until both ends meet at the starting position"
                color: "#fab387"
                font.pixelSize: 11
                font.italic: true
            }
        }
    }
}
*/
/*
ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Straight Line to Circle Animation"
    color: "#1e1e2e"

    property real animationProgress: 0.0
    property real lineLength: 400
    property real centerX: width / 2
    property real centerY: height / 2
    property real radius: lineLength / (2 * Math.PI)

    // Control panel
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#313244"

        Row {
            anchors.centerIn: parent
            spacing: 20

            Button {
                text: "Start Animation"
                onClicked: {
                    if (animation.running) {
                        animation.stop()
                        animationProgress = 0
                    }
                    animation.start()
                }
            }

            Button {
                text: "Reset"
                onClicked: {
                    animation.stop()
                    animationProgress = 0
                }
            }

            Text {
                text: "Progress: " + Math.round(animationProgress * 100) + "%"
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
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
        color: "transparent"

        // Grid background for reference
        Canvas {
            id: gridCanvas
            anchors.fill: parent
            opacity: 0.3

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "#45475a"
                ctx.lineWidth = 1

                // Draw grid
                for (var x = 0; x <= width; x += 50) {
                    ctx.beginPath()
                    ctx.moveTo(x, 0)
                    ctx.lineTo(x, height)
                    ctx.stroke()
                }

                for (var y = 0; y <= height; y += 50) {
                    ctx.beginPath()
                    ctx.moveTo(0, y)
                    ctx.lineTo(width, y)
                    ctx.stroke()
                }

                // Draw center point
                ctx.fillStyle = "#f38ba8"
                ctx.beginPath()
                ctx.arc(centerX, centerY, 3, 0, 2 * Math.PI)
                ctx.fill()
            }
        }

        // The main shape that transforms from line to circle
        Shape {
            id: morphingShape
            anchors.fill: parent

            ShapePath {
                strokeWidth: 4
                strokeColor: "#89b4fa"
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                // Calculate the path based on animation progress
                PathSvg {
                    path: generatePath()
                }
            }

            function generatePath() {
                var path = "M "
                var numPoints = 100 // Number of points for smooth curve

                // Calculate bending factor based on animation progress
                var bendFactor = animationProgress * Math.PI

                for (var i = 0; i <= numPoints; i++) {
                    var t = i / numPoints // Parameter from 0 to 1
                    var x, y

                    if (animationProgress === 0) {
                        // Straight line
                        x = centerX - lineLength/2 + t * lineLength
                        y = centerY
                    } else {
                        // Interpolate between straight line and circle
                        var angle = t * bendFactor * 2 // Total angle covered
                        var currentRadius = radius * Math.sin(animationProgress * Math.PI / 2)

                        // Calculate position on the bending curve
                        if (bendFactor < Math.PI) {
                            // Partial bending - line is curving but not closed
                            var arcLength = bendFactor * radius
                            var straightLength = lineLength - arcLength

                            if (t <= straightLength / (2 * lineLength)) {
                                // Left straight portion
                                x = centerX - lineLength/2 + t * lineLength
                                y = centerY
                            } else if (t >= 1 - straightLength / (2 * lineLength)) {
                                // Right straight portion
                                x = centerX - lineLength/2 + t * lineLength
                                y = centerY
                            } else {
                                // Curved middle portion
                                var curveT = (t - straightLength / (2 * lineLength)) / (1 - straightLength / lineLength)
                                var curveAngle = curveT * bendFactor - bendFactor/2
                                x = centerX + currentRadius * Math.cos(curveAngle + Math.PI/2)
                                y = centerY + currentRadius * Math.sin(curveAngle + Math.PI/2)
                            }
                        } else {
                            // Full circle formation
                            angle = t * 2 * Math.PI - Math.PI/2
                            x = centerX + radius * Math.cos(angle)
                            y = centerY + radius * Math.sin(angle)
                        }
                    }

                    if (i === 0) {
                        path += x.toFixed(2) + " " + y.toFixed(2)
                    } else {
                        path += " L " + x.toFixed(2) + " " + y.toFixed(2)
                    }
                }

                // Close the path when animation is complete
                if (animationProgress >= 0.99) {
                    path += " Z"
                }

                return path
            }
        }

        // End points indicators
        Rectangle {
            id: startPoint
            width: 8
            height: 8
            radius: 4
            color: "#a6e3a1"
            visible: animationProgress < 0.99

            property real pointX: {
                if (animationProgress === 0) {
                    return centerX - lineLength/2
                } else {
                    var angle = -Math.PI/2
                    return centerX + radius * Math.cos(angle)
                }
            }

            property real pointY: {
                if (animationProgress === 0) {
                    return centerY
                } else {
                    var angle = -Math.PI/2
                    return centerY + radius * Math.sin(angle)
                }
            }

            x: pointX - width/2
            y: pointY - height/2
        }

        Rectangle {
            id: endPoint
            width: 8
            height: 8
            radius: 4
            color: "#f9e2af"
            visible: animationProgress < 0.99

            property real pointX: {
                if (animationProgress === 0) {
                    return centerX + lineLength/2
                } else if (animationProgress >= 0.99) {
                    var angle = -Math.PI/2
                    return centerX + radius * Math.cos(angle)
                } else {
                    var angle = 3*Math.PI/2
                    return centerX + radius * Math.cos(angle)
                }
            }

            property real pointY: {
                if (animationProgress === 0) {
                    return centerY
                } else if (animationProgress >= 0.99) {
                    var angle = -Math.PI/2
                    return centerY + radius * Math.sin(angle)
                } else {
                    var angle = 3*Math.PI/2
                    return centerY + radius * Math.sin(angle)
                }
            }

            x: pointX - width/2
            y: pointY - height/2
        }
    }

    // Animation
    SequentialAnimation {
        id: animation
        loops: 1

        NumberAnimation {
            target: window
            property: "animationProgress"
            from: 0.0
            to: 1.0
            duration: 3000
            easing.type: Easing.InOutQuad
        }

        PauseAnimation {
            duration: 1000
        }

        NumberAnimation {
            target: window
            property: "animationProgress"
            from: 1.0
            to: 0.0
            duration: 3000
            easing.type: Easing.InOutQuad
        }
    }

    // Information panel
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        color: "#313244"
        opacity: 0.9

        Text {
            anchors.centerIn: parent
            text: {
                if (animationProgress < 0.1) return "Straight horizontal line"
                else if (animationProgress < 0.5) return "Line bending from the middle..."
                else if (animationProgress < 0.99) return "Ends approaching each other..."
                else return "Perfect circle formed!"
            }
            color: "white"
            font.pixelSize: 16
        }
    }
}

*/
/*
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Form from C++ Data"

    MouseArea{
        visible:true
        anchors.fill:parent
        onClicked:{
            console.log(" Hello ")
            roleCombo.popup.open()
            nameField.forceActiveFocus()
        }
    }

    Column {
        spacing: 20
        padding: 20

        TextField {
            id: nameField
            placeholderText: "Enter your name"
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    console.log("nameField Clicked")
                }
            }
        }

        ComboBox {
            id: roleCombo
            model: formDataProvider.roles
        }
        // SpinBox {
        //     id: spinBox
        //     from: 0
        //     value: decimalToInt(1.1)
        //     to: decimalToInt(100)
        //     stepSize: decimalFactor
        //     editable: true
        //     // anchors.centerIn: parent

        //     property int decimals: 2
        //     property real realValue: value / decimalFactor
        //     readonly property int decimalFactor: Math.pow(10, decimals)

        //     function decimalToInt(decimal) {
        //         return decimal * decimalFactor
        //     }

        //     validator: DoubleValidator {
        //         bottom: Math.min(spinBox.from, spinBox.to)
        //         top:  Math.max(spinBox.from, spinBox.to)
        //         decimals: spinBox.decimals
        //         notation: DoubleValidator.StandardNotation
        //     }

        //     textFromValue: function(value, locale) {
        //         return Number(value / decimalFactor).toLocaleString(locale, 'f', spinBox.decimals)
        //     }

        //     valueFromText: function(text, locale) {
        //         return Math.round(Number.fromLocaleString(locale, text) * decimalFactor)
        //     }
        // }

        SpinBox {
            id: spinBox
            width:120
            from: 0
            value: decimalToInt(1.1)
            to: decimalToInt(100)
            stepSize: decimalFactor
            editable: true

            property int decimals: 2
            property real realValue: value / decimalFactor
            readonly property int decimalFactor: Math.pow(10, decimals)

            function decimalToInt(decimal) {
                return decimal * decimalFactor
            }

            validator: DoubleValidator {
                bottom: Math.min(spinBox.from, spinBox.to)
                top: Math.max(spinBox.from, spinBox.to)
                decimals: spinBox.decimals
                notation: DoubleValidator.StandardNotation
            }

            textFromValue: function(value, locale) {
                return Number(value / decimalFactor).toLocaleString(locale, 'f', spinBox.decimals)
            }

            valueFromText: function(text, locale) {
                return Math.round(Number.fromLocaleString(locale, text) * decimalFactor)
            }

            // === Style Section ===
            background: Rectangle {
                color: "black"
                radius: 4
                border.color: "#444"
            }

            contentItem: TextInput {
                text: spinBox.textFromValue(spinBox.value, Qt.locale())
                color: "white"
                font.pixelSize: 16
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                readOnly: !spinBox.editable
                validator: spinBox.validator
                onEditingFinished:{
                }
                onTextChanged:{
                    // spinBox.value=spinBox.valueFromText(selectedText,Qt.locale())
                    const parsed = Number.fromLocaleString(Qt.locale(), text)
                            if (!isNaN(parsed)) {
                                spinBox.value = Math.round(parsed * spinBox.decimalFactor)
                            }
                }

                // background: null
            }

            up.indicator: Rectangle {
                x: spinBox.mirrored ? 0 : spinBox.width - width

                implicitWidth: 24
                implicitHeight: 16
                color: "black"
                border.color: "white"
                radius: 2
                // padding: 4

                Text {
                    anchors.centerIn: parent
                    text: "▲"
                    color: "white"
                    font.pixelSize: 12
                }
            }

            down.indicator: Rectangle {
                y:16
                x: spinBox.mirrored ? parent.width - width : parent.width - width
                implicitWidth: 24
                implicitHeight: 16
                color: "black"
                border.color: "white"
                radius: 2
                // padding: 4

                Text {
                    anchors.centerIn: parent
                    text: "▼"
                    color: "white"
                    font.pixelSize: 12
                }
            }
        }

        Row {
            spacing: 10
            Text { text: "Gender:" }

            Repeater {
                model: formDataProvider.genders
                RadioButton {
                    text: modelData
                    checked: index === 0
                    onClicked: console.log("Selected Gender:", modelData)
                }
            }
        }

        Button {
            text: "Save"
            onClicked: {
                console.log("Saving...")
                console.log("Name:", nameField.text)
                console.log("Role:", roleCombo.currentText)
                console.log("Gender:", getSelectedGender())

                formHandler.submitForm(nameField.text, getSelectedGender(), roleCombo.currentText);
            }
        }
    }

    function getSelectedGender() {
        for (let i = 0; i < roleCombo.count; ++i) {
            if (roleCombo.currentIndex(i).checked)
                return roleCombo.itemAt(i).text;
        }
        return "Unknown";
    }
}
*/
