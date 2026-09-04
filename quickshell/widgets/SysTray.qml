import ".."

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

Rectangle {
    id: trayBackground
    required property var parentWindow
    property alias contextMenu: contextMenu
    implicitWidth: trayRow.implicitWidth + 12
    implicitHeight: trayRow.implicitHeight + 4
    radius: 8
    color: Colors.md3.surface_container

    Connections {
        target: SystemTray.items
        property var knownIds: [ "discord_status_icon_1", "steam" ]

        function onValuesChanged() {
            for (const item of SystemTray.items.values) {
                if (!knownIds.includes(item.id)) {
                    knownIds.push(item.id)
                    console.log("new tray item — id:", item.id, "title:", item.title)
                }
            }
        }
    }

    TrayContextMenu {
        id: contextMenu
        parentWindow: trayBackground.parentWindow
    }

    property bool expanded: false
    property var alwaysVisible: ["discord_status_icon_1", "steam"]   // pinned icons — always shown

    RowLayout {
        id: trayRow
        anchors.centerIn: parent
        spacing: 4

        property var pinnedItems: SystemTray.items.values.filter(item => alwaysVisible.includes(item.id))
        property var hiddenItems: SystemTray.items.values.filter(item => !alwaysVisible.includes(item.id))

        // Chevron toggle — now first, so it renders on the left
        Rectangle {
            visible: trayRow.hiddenItems.length > 0
            implicitWidth: 18
            implicitHeight: 18
            radius: 9
            color: chevronMouse.containsMouse ? Colors.md3.surface_container_high : "transparent"

            Text {
                anchors.centerIn: parent
                text: "\uf104"
                color: Colors.md3.on_surface
                rotation: trayBackground.expanded ? 180 : 0
                Behavior on rotation { NumberAnimation { duration: 150 } }
            }

            MouseArea {
                id: chevronMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: trayBackground.expanded = !trayBackground.expanded
            }
        }

        Repeater {
            model: trayBackground.expanded ? trayRow.hiddenItems : []
            delegate: TrayIcon {
                required property var modelData
                itemData: modelData
                contextMenu: trayBackground.contextMenu
                parentWindow: trayBackground.parentWindow
            }
        }

        Repeater {
            model: trayRow.pinnedItems
            delegate: TrayIcon {
                required property var modelData
                itemData: modelData
                contextMenu: trayBackground.contextMenu
                parentWindow: trayBackground.parentWindow
            }
        }
    }
}
