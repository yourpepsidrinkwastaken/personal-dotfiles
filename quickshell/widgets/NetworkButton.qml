import ".."

import QtQuick
import Quickshell.Io

Rectangle {
  id: root
  implicitWidth: icon.implicitWidth + 13
  implicitHeight: icon.implicitHeight + 6
  radius: 50
  color: mouseArea.containsMouse? Colors.md3.surface_container
       : "transparent"

  Text {
    id: icon
    anchors.centerIn: parent
    //color: mouseArea.containsMouse? Colors.md3.scrim
    color     : Colors.md3.on_surface

    text: {
        if (!NetworkStatus.connected) return "󰤭"
        if (!NetworkStatus.isWifi) return "󰈀"
        return "󰤨"   // placeholder single wifi glyph until strength is confirmed
    }

    font {
      family: "JetBrainsMono Nerd Font Propo"
      pixelSize: 14
      bold: true
    }
  }

  Process {
    id: nmProc
    command: ["kitty", "-e", "nmtui"]
  }

  MouseArea {
    id: mouseArea
    hoverEnabled: true
    anchors.fill: parent
    onClicked: nmProc.running = true
  }

  Shortcut {
    sequence: "Escape"
    onActivated: nmProc.running = false
  }

}
