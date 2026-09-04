// ExtWorkspaces.qml
import ".."
import QtQuick
import QtQuick.Layouts
import Quickshell.WindowManager

RowLayout {
    id: workspacesRow
    required property var screen   // pass this.screen from Bar.qml's PanelWindow

    Layout.leftMargin: 10
    Layout.rightMargin: 10
    spacing: 2

    property var persistentIds: [1, 2, 3, 4, 5]
    property var projection: WindowManager.screenProjection(screen)

    property var workspaceIds: {
        let ids = persistentIds.map(String)
        for (const ws of projection.windowsets) {
            if (!ids.includes(ws.name)) ids.push(ws.name)
        }
        const numeric = ids.filter(id => !isNaN(Number(id)))
        numeric.sort((a, b) => Number(a) - Number(b))
        return numeric
    }

    Repeater {
        model: workspacesRow.workspaceIds

        Rectangle {
            required property var modelData
            property var wsId: modelData
            property var ws: workspacesRow.projection.windowsets.find(w => w.name === wsId)
            property bool isActive: ws?.active ?? false
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
                color: isActive || mouseArea.containsMouse ? Colors.md3.on_primary : Colors.md3.on_surface
                font { family: Config.fontFamily; pixelSize: 13; bold: true }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: ws?.activate()
              }

            Component.onCompleted: {
              for (const ws of projection.windowsets) {
                  console.log("real workspace id:", ws.id, typeof ws.id)
              }
            }
        }
    }
}
