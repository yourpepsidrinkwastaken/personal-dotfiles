import ".."

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    implicitWidth: icon.implicitWidth + 14
    implicitHeight: icon.implicitHeight + 6
    radius: 25
    color: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_bright
    Behavior on color { ColorAnimation { duration: 200 } }
    
    property string iconState: "none"

    Text {
        id: icon
        renderType: Text.NativeRendering
        anchors.centerIn: parent
        color: Colors.md3.on_surface
        font {
            family : "JetBrainsMono Nerd Font Propo"
            pixelSize : 13
        }
        text: {
            switch (root.iconState) {
                case "notification": return "󱅫"
                case "dnd-notification": return "󰂠"
                case "dnd-none": return "󰪓"
                case "inhibited-notification": return "󰂛"
                case "inhibited-none": return "󰪑"
                case "dnd-inhibited-notification": return "󰂛"
                case "dnd-inhibited-none": return "󰪑"
                default: return "󰂜"
            }
        }
    }
    
    Process {
        id: swayncSub
        command: ["swaync-client", "-swb"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                const data = JSON.parse(line)
                root.iconState = data.alt ?? "none"
            }
        }
    }
    
    Process { id: toggleProc; command: ["swaync-client", "-t", "-sw"] }
    Process { id: dismissProc; command: ["swaync-client", "-d", "-sw"] }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) toggleProc.running = true
            else if (mouse.button === Qt.RightButton) dismissProc.running = true
        }
    }
    
    Shortcut {
        sequence: "Escape"
        onActivated: root.visible = false
    }
}
