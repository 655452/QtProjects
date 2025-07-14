function applyAnchors(item, modelData, layoutContainer) {
    const anchorKeys = [
        "anchors.right",
        "anchors.left",
        "anchors.top",
        "anchors.bottom",
        "anchors.horizontalCenter",
        "anchors.verticalCenter"
    ]

    for (let i = 0; i < anchorKeys.length; i++) {
        let key = anchorKeys[i]
        if (modelData[key] !== undefined) {
            let parts = key.split(".") // ["anchors", "right"]
            let anchorSide = parts[1]
            let targetExpr = modelData[key] // e.g., "parent.right"

            // Apply binding dynamically using eval
            try {
                item.anchors[anchorSide] = Qt.binding(function() {
                    return eval(targetExpr.replace("parent", "layoutContainer"))
                })
            } catch (e) {
                console.log("Failed to bind:", key, "->", targetExpr, e)
            }
        }
    }
}
function applyProperties(item, modelData) {
    const properties = ["radius", "opacity", "rotation", "scale", "border.width", "border.color"];

    for (let i = 0; i < properties.length; i++) {
        let key = properties[i];
        if (modelData[key] !== undefined) {
            try {
                let parts = key.split(".");
                if (parts.length === 2) {
                    let group = parts[0];       // e.g. "border"
                    let prop = parts[1];        // e.g. "width"
                    if (item[group] && prop in item[group]) {
                        item[group][prop] = modelData[key];
                    }
                } else {
                    item[key] = modelData[key];
                }
            } catch (e) {
                console.log("Property setting error:", key, e);
            }
        }
    }
}
