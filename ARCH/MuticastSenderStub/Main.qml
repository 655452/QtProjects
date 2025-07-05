// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts

// ApplicationWindow {
//     visible: true
//     width: 600
//     height: 600
//     title: "Multicast Sender"

//     ColumnLayout {
//         anchors.centerIn: parent
//         spacing: 32

//         // Part 1 UI
//         GroupBox {
//             title: "Part 1"
//             Layout.alignment: Qt.AlignCenter

//             GridLayout {
//                 columns: 3


//                 Repeater {
//                     model: 9
//                     Button {
//                         id: part1Button
//                         text: "P1-" + (index + 1)
//                         checkable: true
//                         checked: multicastSender.part1Status[index] === 1

//                         // Update button color based on state
//                         background: Rectangle {
//                             color: part1Button.checked ? "green" : "gray"
//                             border.color: "black"
//                         }

//                         onClicked: {
//                             multicastSender.toggleNode(1, index);
//                         }
//                     }
//                 }
//             }
//         }

//         // Part 2 UI
//         GroupBox {
//             title: "Part 2"
//             Layout.alignment: Qt.AlignCenter

//             GridLayout {
//                 columns: 3

//                 Repeater {
//                     model: 9
//                     Button {
//                         id: part2Button
//                         text: "P2-" + (index + 1)
//                         checkable: true
//                         checked: multicastSender.part2Status[index] === 1

//                         // Update button color based on state
//                         background: Rectangle {
//                             color: part2Button.checked ? "green" : "gray"
//                             border.color: "black"
//                         }

//                         onClicked: {
//                             multicastSender.toggleNode(2, index);
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }


import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 600
    height: 600
    title: "Multicast Sender"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 32

        CheckBox {
            id: app1Switch
            text: "App1"
        }

        CheckBox {
            id: app2Switch
            text: "App2"
        }
        // Part 1 UI
        GroupBox {
            title: "Part 1"
            Layout.alignment: Qt.AlignCenter

            GridLayout {
                columns: 3

                Repeater {
                    model: 9
                    Button {
                        id: part1Button
                        text: "P1-Node" + (index + 1)
                        checkable: true
                        checked: multicastSender.part1Status["Node" + (index + 1)] === true

                        background: Rectangle {
                            color: part1Button.checked ? "green" : "gray"
                            border.color: "black"
                        }

                        onClicked: {
                            multicastSender.toggleNode(1, "Node" + (index + 1), app1Switch.checked?"app1":"",app2Switch.checked?"app2":"");
                        }

                    }
                }
            }


        }

        // Part 2 UI
        GroupBox {
            title: "Part 2"
            Layout.alignment: Qt.AlignCenter

            GridLayout {
                columns: 3

                Repeater {
                    model: 9
                    Button {
                        id: part2Button
                        text: "P2-Node" + (index + 1)
                        checkable: true
                        checked: multicastSender.part2Status["Node" + (index + 1)] === true

                        background: Rectangle {
                            color: part2Button.checked ? "green" : "gray"
                            border.color: "black"
                        }

                        onClicked: {
                            multicastSender.toggleNode(2, "Node" + (index + 1));
                        }
                    }
                }
            }
        }
    }
}
