import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Form from C++ Data"

    Column {
        spacing: 20
        padding: 20

        TextField {
            id: nameField
            placeholderText: "Enter your name"
        }

        ComboBox {
            id: roleCombo
            model: formDataProvider.roles
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
