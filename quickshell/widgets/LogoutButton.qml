import ".."

import QtQuick
import Quickshell.Io

Rectangle {
  id: root
  implicitWidth: 24
  implicitHeight: icon.implicitHeight + 6
  radius: 50
  color: mouseArea.containsMouse? Colors.md3.surface_container_high : Colors.md3.surface_bright
  Behavior on color { ColorAnimation { duration: 200 } }
  Text {
    id: icon
    anchors.centerIn: parent
    color: mouseArea.containsMouse? Colors.md3.error : Colors.md3.on_surface
    font {
      family: "JetBrainsMono Nerd Font Propo"
      pixelSize: 13
    }
    text: "󰐥"
  }

  Process {
    id: wlogoutCmd
    command: ["wlogout"]
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: wlogoutCmd.running = true
  }

  Shortcut {
    sequence: "Escape"
    onActivated: root.visible = false
  }
}
