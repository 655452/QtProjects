pragma Singleton
import QtQuick 2.15
import "smartMainLibrary/KeyManager.qml" as KeyManager

QtObject {
    id: eventManager

    property var activeComponent: ""

    function setActiveComponent(component) {
        activeComponent = component;
        console.log("Active Component Set to:", activeComponent);
    }

    function triggerFunctionKey(key) {
        console.log("Triggering Function Key:", key, "for Component:", activeComponent);
        KeyManager.triggerKeyPress(key);
    }
}
