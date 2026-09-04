import ".."

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import Niri

Item {
    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.log("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Connection error:", error)
        }
    }

    ListView {
        model: niri.workspaces
        delegate: Rectangle {
            Text {
                text: "Workspace " + model.index +
                      (model.isFocused ? " (focused)" : "")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: niri.focusWorkspaceById(model.id)
            }
        }
    }
}


//RowLayout {
//    id: workspacesRow
//    Layout.leftMargin: 10
//    Layout.rightMargin: 10
//    spacing: 2
//
//    property var workspaceIds: {
//        let ids = []
//        for (let i = 1; i <= 2; i++) ids.push(i)
//        for (const ws of Hyprland.workspaces.values) {
//            if (!ids.includes(ws.id)) ids.push(ws.id)
//        }
//        return ids.sort((a, b) => a - b)
//    }
//
//      Repeater {
//          model: workspaceIds
//
//          Rectangle {
//              property int wsId: index + 1
//              property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)
//              property bool isActive: Hyprland.focusedWorkspace?.id === wsId
//
//              implicitWidth: 20
//              implicitHeight: 22
//              radius: 8
//              color: isActive ? Colors.md3.primary
//                   : mouseArea.containsMouse ? Colors.md3.primary
//                   : Colors.md3.surface
//              Behavior on color { ColorAnimation { duration: 150 } }
//
//              Text {
//                  anchors.centerIn: parent
//                  text: wsId
//                  renderType: Text.NativeRendering
//                  color: isActive ? Colors.md3.on_primary : mouseArea.containsMouse ? Colors.md3.on_primary : Colors.md3.on_surface
//                  font {
//                      family: "JetBrainsMono Nerd Font Propo"
//                      pixelSize: 13
//                      bold: true
//                  }
//              }
//
//              Process {
//                  id: moveWorkspace
//                  command: ["hyprctl","dispatch","hl.dsp.focus({ workspace = " + wsId + " })"]
//              }
//
//              MouseArea {
//                  id:mouseArea
//                  anchors.fill: parent
//                  hoverEnabled: true
//                  onClicked: moveWorkspace.running = true // Hyprland.dispatch("workspace " + wsId) this will be have to be updated
//              }
//          }
//      }
//}
