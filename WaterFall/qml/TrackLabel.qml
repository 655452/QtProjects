import QtQuick

Rectangle {

    property string labelName

    id: seriesLabel
    width: seriesLabelName.width + 5
    height: seriesLabelName.height + 5
    border.color: "white"
    radius: 2
    color: "black"
    z: parent.z + 1
    visible: true

    Text {
        id: seriesLabelName
        color: "white"
        text: seriesLabel.labelName
        anchors.centerIn: parent
        font.family: "Ubuntu"
        font.pointSize: 7
        font.weight: 500
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("clicked on the label" + labelName)
        }
    }
    Component.onCompleted: {
        // let mappedPosition = chartView.mapToPosition(Qt.point(100.9, 30.3), lineSeries1);
        // console.log("Mapped Position:", mappedPosition);
    }
}



/*

Rectangle {
    id: seriesLabel
    width: seriesLabelName.width + 5
    height: seriesLabelName.height + 5
    border.color: "white"
    radius: 2
    color: "black"
    z: parent.z + 1
    visible: true

    // Dynamically position based on mapToPosition
    x: {
        let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
        // Ensure it stays within the chart's plot area
        Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
    }
    y: {
        let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
        // Ensure it stays within the chart's plot area
        Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
    }

    Text {
        id: seriesLabelName
        color: "white"
        text: qsTr("OWN")
        anchors.centerIn: parent
        font.family: "Ubuntu"
        font.pointSize: 7
        font.weight: 500
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("clicked on the label")
        }
    }
    Component.onCompleted: {
        let mappedPosition = chartView.mapToPosition(Qt.point(100.9, 30.3), lineSeries1);
        console.log("Mapped Position:", mappedPosition);
    }
}

Rectangle {
    id: seriesLabel2
    width: seriesLabelName2.width + 5
    height: seriesLabelName2.height + 5
    border.color: "white"
    radius: 2
    color: "black"
    z: parent.z + 1
    visible: true

    // Dynamically position based on mapToPosition
    x: {
        let position = chartView.mapToPosition(Qt.point(180, 0), lineSeries2);
        // Ensure it stays within the chart's plot area
        Math.max(chartView.plotArea.x, Math.min(position.x, chartView.plotArea.x + chartView.plotArea.width - width)) - width/2;
    }
    y: {
        let position = chartView.mapToPosition(Qt.point(100, 0), lineSeries1);
        // Ensure it stays within the chart's plot area
        Math.max(chartView.plotArea.y, Math.min(position.y, chartView.plotArea.y + chartView.plotArea.height - height)) - height/2 - 10;
    }

    Text {
        id: seriesLabelName2
        color: "white"
        text: qsTr("MN1001")
        anchors.centerIn: parent
        font.family: "Ubuntu"
        font.pointSize: 7
        font.weight: 500
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("clicked on the label")
        }
    }
    Component.onCompleted: {
        let mappedPosition = chartView.mapToPosition(Qt.point(100.9, 30.3), lineSeries1);
        console.log("Mapped Position:", mappedPosition);
    }
}

*/
