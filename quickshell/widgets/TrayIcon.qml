// TrayIcon.qml
import QtQuick
import Quickshell.Services.SystemTray

Item {
    id: trayItem
    required property var itemData
    required property var contextMenu
    required property var parentWindow
    implicitWidth: 20
    implicitHeight: 20

    Image {
        anchors.centerIn: parent
        source: trayItem.itemData.icon
        sourceSize: Qt.size(12, 12)
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                trayItem.itemData.activate()
            } else if (mouse.button === Qt.RightButton) {
                const pos = trayItem.mapToItem(parentWindow.contentItem, mouseX, mouseY)
                contextMenu.openAt(itemData.menu, pos.x, pos.y)
            }
        }
    }
}
