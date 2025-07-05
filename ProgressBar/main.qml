import QtQuick 2.15
import QtQuick.Controls 2.15
// ------------------------------ Progress step indicator Linear ----------------------------------------------
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Stepper Menu"

    Item {
        width:parent.width
        height:parent.height
        Rectangle {
            id: stepperMenu
            width: parent.width
            height: parent.height
            color:"transparent"
            property int currentStep: 1

            function updateGraphics(){
                innerCircle.requestPaint()
            }

            function goToNextStep() {
                if (currentStep < 5) {
                    currentStep++
                    updateGraphics()
                }
            }

            function goToPreviousStep() {
                if (currentStep > 1) {
                    currentStep--
                    updateGraphics()
                }
            }

            Row {
                anchors.centerIn: parent
                spacing: 5
                Rectangle {
                    id: item
                    radius: 50
                    width: 50
                    height: 50
                    color: stepperMenu.currentStep >= 2 ? "lightgreen" : "transparent"

                    Canvas {
                        id: innerCircle
                        anchors.centerIn: parent
                        width: item.width / 2
                        height: item.height / 2

                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);
                            if (stepperMenu.currentStep < 2) {
                                ctx.fillStyle = "#3b90f3";
                                ctx.beginPath();
                                ctx.arc(width / 2, height / 2, width / 2, 0, Math.PI * 2, true);
                                ctx.fill();
                            } else {
                                ctx.strokeStyle = "#3b90f3";
                                ctx.lineWidth = 4;
                                ctx.beginPath();
                                ctx.moveTo(width * 0.2, height * 0.5);
                                ctx.lineTo(width * 0.4, height * 0.7);
                                ctx.lineTo(width * 0.8, height * 0.3);
                                ctx.stroke();
                            }
                        }
                    }

                    Rectangle {
                        radius: 50
                        anchors.fill: parent
                        color: "transparent"
                        border.width: 2
                        border.color: "grey"

                        Rectangle {
                            id: borderAnim
                            radius: 50
                            anchors.fill: parent
                            anchors.margins: -2
                            color: "transparent"
                            border.width: 2
                            border.color: stepperMenu.currentStep >= 1 ? "#3b90f3" : "transparent"
                            Behavior on border.color {
                                ColorAnimation { duration: 500 }
                            }
                        }
                    }
                }
                Rectangle {
                    id: spacer
                    radius: 5
                    width: 35
                    height: 5
                    color: "grey"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        id: fillRect
                        width: stepperMenu.currentStep >= 2 ? spacer.width : 0
                        height: 5
                        color: "#3b90f3"
                        radius: 5
                        Behavior on width {
                            NumberAnimation { duration: 500 }
                        }
                    }
                }

                Rectangle {
                    id: item1
                    radius: 50
                    width: 50
                    height: 50
                    color: stepperMenu.currentStep >= 3 ? "lightgreen" : "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: "Hello"
                    }

                    Rectangle {
                        radius: 50
                        anchors.fill: parent
                        color: "transparent"
                        border.width: 2
                        border.color: "grey"

                        Rectangle {
                            id: borderAnim1
                            radius: 50
                            anchors.fill: parent
                            anchors.margins: -2
                            color: "transparent"
                            border.width: 2
                            border.color: stepperMenu.currentStep >= 2 ? "#3b90f3" : "transparent"
                            Behavior on border.color {
                                ColorAnimation { duration: 500 }
                            }
                        }
                    }
                }

                Rectangle {
                    id: spacer2
                    radius: 5
                    width: 35
                    height: 5
                    color: "grey"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        id: fillRect2
                        width: stepperMenu.currentStep >= 3 ? spacer2.width : 0
                        height: 5
                        color: "#3b90f3"
                        radius: 5
                        Behavior on width {
                            NumberAnimation { duration: 500 }
                        }
                    }
                }

                Rectangle {
                    id: item2
                    radius: 50
                    width: 50
                    height: 50
                    color: stepperMenu.currentStep >= 4 ? "lightgreen" : "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: "!!!!"
                    }

                    Rectangle {
                        radius: 50
                        anchors.fill: parent
                        color: "transparent"
                        border.width: 2
                        border.color: "grey"

                        Rectangle {
                            id: borderAnim2
                            radius: 50
                            anchors.fill: parent
                            anchors.margins: -2
                            color: "transparent"
                            border.width: 2
                            border.color: stepperMenu.currentStep >= 3 ? "#3b90f3" : "transparent"
                            Behavior on border.color {
                                ColorAnimation { duration: 500 }
                            }
                        }
                    }
                }
                Rectangle {
                    id: spacer3
                    radius: 5
                    width: 35
                    height: 5
                    color: "grey"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        id: fillRect3
                        radius: 5
                        width: stepperMenu.currentStep >= 4 ? spacer3.width : 0
                        height: 5
                        color: "#3b90f3"
                        Behavior on width {
                            NumberAnimation { duration: 500 }
                        }
                    }
                }
                Rectangle {
                    id: item3
                    radius: 50
                    width: 50
                    height: 50
                    color: stepperMenu.currentStep >= 5 ? "lightgreen" : "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: "Hello"
                    }

                    Rectangle {
                        radius: 50
                        anchors.fill: parent
                        color: "transparent"
                        border.width: 2
                        border.color: "grey"

                        Rectangle {
                            id: borderAnim3
                            radius: 50
                            anchors.fill: parent
                            anchors.margins: -2
                            color: "transparent"
                            border.width: 2
                            border.color: stepperMenu.currentStep >= 4 ? "#3b90f3" : "transparent"
                            Behavior on border.color {
                                ColorAnimation { duration: 500 }
                            }
                        }
                    }
                }
            }
            Row {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Previous"
                    enabled: stepperMenu.currentStep > 1
                    onClicked: stepperMenu.goToPreviousStep()
                }

                Button {
                    text: "Next"
                    enabled: stepperMenu.currentStep < 4
                    onClicked: stepperMenu.goToNextStep()
                }
            }
        }
    }
}

// ------------------------------Circular Progress step indicator V1----------------------------------------------
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 400
//     title: "Circular Stepper"

//     Rectangle {
//         id:circular
//         anchors.centerIn: parent
//         width: 300
//         height: 300
//         color: "transparent"
//         property int currentStep: 1
//         property int totalSteps: 4

//         Canvas {
//             id: progressCanvas
//             anchors.fill: parent
//             onPaint: {
//                 var ctx = getContext("2d");
//                 ctx.clearRect(0, 0, width, height);

//                 var cx = width / 2;
//                 var cy = height / 2;
//                 var r = 100;
//                 var startAngle = -Math.PI / 2;

//                 // Background Circle
//                 ctx.beginPath();
//                 ctx.strokeStyle = '#ccc';
//                 ctx.lineWidth = 10;
//                 ctx.arc(cx, cy, r, 0, 2 * Math.PI);
//                 ctx.stroke();

//                 // Progress Arc
//                 ctx.beginPath();
//                 ctx.strokeStyle = '#3b90f3';
//                 ctx.lineWidth = 10;
//                 ctx.arc(cx, cy, r, startAngle, startAngle + (2 * Math.PI) * (circular.currentStep / circular.totalSteps));
//                 ctx.stroke();
//             }
//         }

//         Repeater {
//             model: 4
//             Rectangle {
//                 width: 30; height: 30; radius: 15
//                 color: index + 1 <= circular.currentStep ? "#3b90f3" : "lightgray"
//                 border.width: 2; border.color: "gray"
//                 anchors.centerIn: parent
//                 x: parent.width / 2 + 100 * Math.cos(index * 90 * Math.PI / 180 - Math.PI / 2) - width / 2
//                 y: parent.height / 2 + 100 * Math.sin(index * 90 * Math.PI / 180 - Math.PI / 2) - height / 2
//                 Text {
//                     anchors.centerIn: parent
//                     text: index + 1
//                     color: "white"
//                 }
//             }
//         }

//         Row {
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             spacing: 20
//             Button {
//                 text: "Previous"
//                 enabled: circular.currentStep > 1
//                 onClicked: {
//                     circular.currentStep--
//                     progressCanvas.requestPaint()
//                 }
//             }
//             Button {
//                 text: "Next"
//                 enabled: circular.currentStep < circular.totalSteps
//                 onClicked: {
//                     circular.currentStep++
//                     progressCanvas.requestPaint()
//                 }
//             }
//         }
//     }
// }

// ------------------------------Circular Progress step indicator V2----------------------------------------------
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 400
//     title: "Circular Stepper with Icons"

//     Rectangle {
//         id: circular
//         anchors.centerIn: parent
//         width: 300
//         height: 300
//         color: "transparent"
//         property int currentStep: 1
//         property int totalSteps: 4

//         Canvas {
//             id: progressCanvas
//             anchors.fill: parent
//             onPaint: {
//                 var ctx = getContext("2d");
//                 ctx.clearRect(0, 0, width, height);

//                 var cx = width / 2;
//                 var cy = height / 2;
//                 var r = 100;
//                 var startAngle = -Math.PI / 2;

//                 ctx.beginPath();
//                 ctx.strokeStyle = '#ccc';
//                 ctx.lineWidth = 10;
//                 ctx.arc(cx, cy, r, 0, 2 * Math.PI);
//                 ctx.stroke();

//                 ctx.beginPath();
//                 ctx.strokeStyle = '#3b90f3';
//                 ctx.lineWidth = 10;
//                 ctx.arc(cx, cy, r, startAngle, startAngle + (2 * Math.PI) * (circular.currentStep / circular.totalSteps));
//                 ctx.stroke();
//             }
//         }

//         Repeater {
//             model: ListModel {
//                 ListElement { icon: "🔍" }
//                 ListElement { icon: "✏️" }
//                 ListElement { icon: "✅" }
//                 ListElement { icon: "🚀" }
//             }

//             Rectangle {
//                 width: 40; height: 40; radius: 20
//                 property int angle: index * 360 / circular.totalSteps
//                 color: index + 1 <= circular.currentStep ? "#3b90f3" : "lightgray"
//                 border.width: 2; border.color: "#666"
//                 anchors.centerIn: parent
//                 x: parent.width / 2 + 100 * Math.cos(Math.PI * (angle - 90) / 180) - width / 2
//                 y: parent.height / 2 + 100 * Math.sin(Math.PI * (angle - 90) / 180) - height / 2

//                 Text {
//                     anchors.centerIn: parent
//                     text: model.icon
//                     font.pixelSize: 18
//                     color: "white"
//                 }
//             }
//         }

//         Row {
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             spacing: 20

//             Button {
//                 text: "Previous"
//                 enabled: circular.currentStep > 1
//                 onClicked: {
//                     circular.currentStep--
//                     progressCanvas.requestPaint()
//                 }
//             }

//             Button {
//                 text: "Next"
//                 enabled: circular.currentStep < circular.totalSteps
//                 onClicked: {
//                     circular.currentStep++
//                     progressCanvas.requestPaint()
//                 }
//             }
//         }
//     }
// }


// ------------------------------Circular Progress step indicator----------------------------------------------
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 400
//     title: "Circular Stepper with Icons at Milestones"

//     Rectangle {
//         id: circular
//         anchors.centerIn: parent
//         width: 300
//         height: 300
//         color: "transparent"
//         property int currentStep: 1
//         property int totalSteps: 4
//         property real radius: 100
//         property real centerX: width / 2
//         property real centerY: height / 2

//         Canvas {
//             id: progressCanvas
//             anchors.fill: parent
//             onPaint: {
//                 var ctx = getContext("2d");
//                 ctx.clearRect(0, 0, width, height);

//                 var startAngle = -Math.PI / 2;
//                 var endAngle = startAngle + (2 * Math.PI) * (circular.currentStep / circular.totalSteps);

//                 ctx.beginPath();
//                 ctx.strokeStyle = '#ccc';
//                 ctx.lineWidth = 10;
//                 ctx.arc(circular.centerX, circular.centerY, circular.radius, 0, 2 * Math.PI);
//                 ctx.stroke();

//                 ctx.beginPath();
//                 ctx.strokeStyle = '#3b90f3';
//                 ctx.lineWidth = 10;
//                 ctx.arc(circular.centerX, circular.centerY, circular.radius, startAngle, endAngle);
//                 ctx.stroke();
//             }
//         }

//         // Icons at 25%, 50%, 75%, 100%
//         Repeater {
//             model: ListModel {
//                 ListElement { icon: "🔍"; angleDeg: 0 }
//                 ListElement { icon: "✏️"; angleDeg: 90 }
//                 ListElement { icon: "✅"; angleDeg: 180 }
//                 ListElement { icon: "🚀"; angleDeg: 270 }
//             }

//             Rectangle {
//                 width: 40; height: 40; radius: 20
//                 property real radian: angleDeg * Math.PI / 180
//                 x: circular.centerX + circular.radius * Math.cos(radian) - width / 2
//                 y: circular.centerY + circular.radius * Math.sin(radian) - height / 2
//                 color: index + 1 === circular.currentStep ? "#3b90f3" : "#eee"
//                 border.width: 2; border.color: "#666"

//                 Text {
//                     anchors.centerIn: parent
//                     text: model.icon
//                     font.pixelSize: 18
//                     color: index + 1 === circular.currentStep ? "white" : "black"
//                 }
//             }
//         }

//         Row {
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             spacing: 20

//             Button {
//                 text: "Previous"
//                 enabled: circular.currentStep > 1
//                 onClicked: {
//                     circular.currentStep--
//                     progressCanvas.requestPaint()
//                 }
//             }

//             Button {
//                 text: "Next"
//                 enabled: circular.currentStep < circular.totalSteps
//                 onClicked: {
//                     circular.currentStep++
//                     progressCanvas.requestPaint()
//                 }
//             }
//         }
//     }
// }

// ----------------------------------------------------Circular Custom Sidebar ------------------
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 400
//     height: 400
//     title: "Neon Circular Progress Bars"

//     Rectangle {
//         id: circular
//         width: 300
//         height: 300
//         anchors.centerIn: parent
//         color: "black"
//         property int currentStep: 25 // Set this 0–100 to control progress
//         property int totalBars: 100
//         property real radius: 110

//         Canvas {
//             id: neonCanvas
//             anchors.fill: parent
//             onPaint: {
//                 var ctx = getContext("2d");
//                 ctx.clearRect(0, 0, width, height);

//                 var cx = width / 2;
//                 var cy = height / 2;
//                 var barLength = 12;
//                 var barWidth = 4;
//                 var inclination = Math.PI / 3; // 60 degrees

//                 for (var i = 0; i < circular.totalBars; i++) {
//                     var angle = 2 * Math.PI * (i / circular.totalBars) - Math.PI / 2;

//                     // Bar position at outer ring
//                     var x = cx + circular.radius * Math.cos(angle);
//                     var y = cy + circular.radius * Math.sin(angle);

//                     ctx.save();
//                     ctx.translate(x, y);
//                     ctx.rotate(angle + inclination);

//                     if (i < circular.currentStep) {
//                         var gradient = ctx.createLinearGradient(0, 0, barLength, 0);
//                         gradient.addColorStop(0, "#00ffff");
//                         gradient.addColorStop(1, "#00ff00");

//                         ctx.fillStyle = gradient;
//                         ctx.shadowBlur = 10;
//                         ctx.shadowColor = "#00ffcc";
//                     } else {
//                         ctx.fillStyle = "#333";
//                         ctx.shadowBlur = 0;
//                     }

//                     ctx.fillRect(0, -barWidth / 2, barLength, barWidth);
//                     ctx.restore();
//                 }
//             }
//         }

//         Slider {
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: parent.width * 0.8
//             from: 0
//             to: circular.totalBars
//             value: circular.currentStep
//             onValueChanged: {
//                 circular.currentStep = Math.round(value)
//                 neonCanvas.requestPaint()
//             }
//         }
//     }
// }

// ------------------------------------------------progressBar--------------------------------------------------------------------------------------------------------------
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// ApplicationWindow {
//     visible: true
//     width: 800
//     height: 200
//     title: "Neon Linear Progress Bar (60°)"

//     Rectangle {
//         id: linearProgress
//         width: parent.width - 40
//         height: 100
//         anchors.centerIn: parent
//         color: "black"
//         property int totalBars: 100
//         property int currentStep: 25

//         Row {
//             id: barRow
//             spacing: 2
//             anchors.centerIn: parent

//             Repeater {
//                 model: linearProgress.totalBars
//                 Rectangle {
//                     width: 8
//                     height: 30
//                     rotation: 45
//                     antialiasing: true
//                     radius: 2

//                     gradient: Gradient {
//                         GradientStop { position: 0.0; color: index < linearProgress.currentStep ? "transparent" : "#111" }
//                         GradientStop { position: 1.0; color: index < linearProgress.currentStep ? "#003344" : "#000" }
//                     }

//                     border.color: index < linearProgress.currentStep ? "#00ffff" : "#00b3b3"
//                     border.width: 1
//                 }
//             }
//         }

//         Slider{
//             anchors.bottom: parent.bottom
//             anchors.horizontalCenter: parent.horizontalCenter
//             width: parent.width * 0.9
//             from: 0
//             to: linearProgress.totalBars
//             value: linearProgress.currentStep
//             onValueChanged: {
//                 linearProgress.currentStep = Math.round(value)
//             }
//         }
//     }
// }
