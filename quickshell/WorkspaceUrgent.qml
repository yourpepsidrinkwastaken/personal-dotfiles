// WorkspaceUrgent.qml (or fold into an existing workspace service if you build one)
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    property var urgentIds: {
        let ids = []
        for (const ws of Hyprland.workspaces.values) {
            if (ws.urgent) ids.push(ws.id)   // property name unconfirmed — see below
        }
        return ids
    }
}
