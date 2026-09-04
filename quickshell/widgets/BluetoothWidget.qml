import ".."

import QtQuick
import Quickshell.Io

Rectangle {
  id: root
  implicitWidth: icon.implicitWidth + 16
  implicitHeight: icon.implicitHeight + 5
  radius: 50
  color : mouseArea.containsMouse? Colors.md3.surface_container
  : "transparent"
  
  Text {
    id: icon
    anchors.centerIn: parent
    color: Colors.md3.on_surface
    font { family: "JetBrainsMono Nerd Font Propo"; pixelSize: 15; bold: true}
    text: {
      if (!BluetoothStatus.enabled) return "󰂲"        // bluetooth off
            if (BluetoothStatus.connectedCount > 0) return "󰂱"  // connected
            return "󰂯"                                       // on, nothing connected
    }
  }
  
  Process {
    id: btProc
    command: ["blueman-manager"]
  }
 
  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: btProc.running = true
  }
}
