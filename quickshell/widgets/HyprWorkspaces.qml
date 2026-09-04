import ".."

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.WindowManager
import Quickshell.Io

RowLayout {
    id: workspacesRow
    Layout.leftMargin: 10
    Layout.rightMargin: 10
    spacing: 2

    property var persistentIds: [1, 2, 3, 4]

    property var workspaceIds: {
        let ids = [...persistentIds]
        for (const ws of Hyprland.workspaces.values) {
            if (!ids.includes(ws.id)) ids.push(ws.id)
        }
        return ids.sort((a, b) => a - b)
    }
    Repeater {
        model: workspaceIds

        Rectangle {
            property int wsId: modelData
            property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)
            property bool isActive: Hyprland.focusedWorkspace?.id === wsId
            property bool isUrgent: ws?.urgent ?? false

            implicitWidth: 20
            implicitHeight: 22
            radius: 8
            color: isUrgent ? Colors.md3.error
                 : isActive ? Colors.md3.primary
                 : mouseArea.containsMouse ? Colors.md3.primary
                 : Colors.md3.surface
            Behavior on color { ColorAnimation { duration: 150 } }

            Text {
                anchors.centerIn: parent
                text: wsId
                renderType: Text.NativeRendering
                color: isUrgent ? Colors.md3.on_error : isActive ? Colors.md3.on_primary : mouseArea.containsMouse ? Colors.md3.on_primary : Colors.md3.on_surface
                font {
                    family: "JetBrainsMono Nerd Font Propo"
                    pixelSize: 13
                    bold: true
                }
            }

            Process {
                id: moveWorkspace
                command: ["hyprctl","dispatch","hl.dsp.focus({ workspace = " + wsId + " })"]
            }

            MouseArea {
                id:mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: ws.activate()// Hyprland.dispatch("workspace " + wsId) this will be have to be updated
            }

            //Component.onCompleted: console.log("windowset count:", WindowManager.windowsets.length)

            //Connections {
            //    target: WindowManager
            //    function onWindowsetsChanged() {
            //        console.log("windowset count now:", WindowManager.windowsets.length)
            //    }
            //}

            Component.onCompleted: {
                for (const ws of WindowManager.windowsets) {
                    console.log("workspace:", ws.id, ws.name, "active:", ws.active, "keys:", Object.keys(ws))
                }
            }
        }
    }
}
