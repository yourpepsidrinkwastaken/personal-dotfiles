import ".."

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    implicitWidth: icon.implicitWidth + 30
    implicitHeight: icon.implicitHeight + 6
    radius: 25
    color: mouseArea.containsMouse ? Colors.md3.primary : Colors.md3.surface_bright
    Behavior on color { ColorAnimation { duration: 200 } }
    
    Text {
        id: icon
        text: ""
        anchors.centerIn: parent
        color: mouseArea.containsMouse? Colors.md3.scrim : Colors.md3.on_surface
        font {
            family : "JetBrainsMono Nerd Font Propo"
            pixelSize : 13
        }
    }

    Process {
        id: rofiProc
        command: ["rofi", "-show", "drun"]
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        onClicked: rofiProc.running = true
    }
    
    Shortcut {
        sequence: "Escape"
        onActivated: root.visible = false
    }
}
