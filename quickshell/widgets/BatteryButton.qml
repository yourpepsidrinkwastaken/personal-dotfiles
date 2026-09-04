import ".."

import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower

Rectangle {
    id: root
    radius: 8
    implicitWidth: icon.implicitWidth + 20
    implicitHeight: icon.implicitHeight + 6
    color: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_bright
    Behavior on color { ColorAnimation { duration: 200 } }

    Text {
        id: icon
        property var battery: UPower.displayDevice
        renderType: Text.NativeRendering
        anchors.centerIn: parent
        // Component.onCompleted: console.log("Enum value:", UPowerDeviceState.Charging, "Battery state:", battery.state, "Equal?", battery.state === UPowerDeviceState.Charging)

        color: pct <= 15 ? Colors.md3.error
             : pct <= 30 ? Colors.md3.tertiary
             : Colors.md3.on_surface

        property int pct: Math.round(battery.percentage * 100)
        property bool charging: battery.state === UPowerDeviceState.Charging
        property bool plugged: battery.state === UPowerDeviceState.FullyCharged
        property var icons: [" ", " ", " ", " ", " "]
        property int frameIndex: 0

        font { family : "JetBrainsMono Nerd Font Propo"; pixelSize: 13; bold: true}
        
        Timer {
            interval: 500
            running: icon.charging
            repeat: true
            onTriggered: icon.frameIndex = (icon.frameIndex + 1) % icon.icons.length
        }

        text: {
            let glyph
            if (charging) glyph = icon.icons[frameIndex]
            else if (plugged) glyph = "󰚥 "
            else glyph = icon.icons[Math.min(icon.icons.length - 1, Math.floor(pct / 20))]
            return glyph + pct + "%"
        }
    }

    Process { id: defaultApp; command: ["DAMX"] }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: defaultApp.running = true
    }
}
