.pragma library
var map = {
    "OpenDashboard": function() { console.log("Dashboard logic") },
    "PrintReport": function() { console.log("Report printed") }
}

function dispatch(action) {
    if (map[action]) map[action]()
    else console.warn("Unknown action:", action)
}
