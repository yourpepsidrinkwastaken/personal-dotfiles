// TrayContextMenu.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    id: root
    required property var parentWindow
    property var menu: null
    property real menuX: 0
    property real menuY: 0

    function openAt(menuHandle, x, y) {
        popup.visible = false
        root.menu = null
        root.menuX = x
        root.menuY = y
        Qt.callLater(() => {
            root.menu = menuHandle
            popup.visible = true
        })
    }

    QsMenuOpener {
        id: opener
        menu: root.menu
    }

    PopupWindow {
        id: popup
        anchor.window: root.parentWindow
        anchor.rect.x: root.menuX
        anchor.rect.y: root.menuY
        grabFocus: true
        color: Colors.md3.surface
        implicitWidth: menuColumn.implicitWidth + 16
        implicitHeight: menuColumn.implicitHeight + 8

        onVisibleChanged: {
            if (!visible) {
                root.menu = null
                submenuPopup.visible = false
            }
        }

        Keys.onEscapePressed: popup.visible = false

        ColumnLayout {
            id: menuColumn
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: opener.children

                Rectangle {
                    id: entryRoot
                    required property var modelData
                    implicitWidth: label.implicitWidth + (modelData.hasChildren ? 28 : 16)
                    Layout.fillWidth: true
                    implicitHeight: modelData.isSeparator ? 8 : 24
                    color: mouseArea.containsMouse ? Colors.md3.surface_container : "transparent"

                    Rectangle {
                        visible: entryRoot.modelData.isSeparator
                        anchors.centerIn: parent
                        width: parent.width - 8
                        height: 1
                        color: Colors.md3.outline_variant
                    }

                    Text {
                        id: label
                        visible: !entryRoot.modelData.isSeparator
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 8
                        text: entryRoot.modelData.text
                        color: entryRoot.modelData.enabled ? Colors.md3.on_surface : Colors.md3.outline
                    }

                    Text {
                        visible: entryRoot.modelData.hasChildren
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 8
                        text: "\uf054"
                        color: Colors.md3.on_surface
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: !entryRoot.modelData.isSeparator && entryRoot.modelData.enabled
                        onEntered: {
                            if (entryRoot.modelData.hasChildren) {
                                submenuPopup.menu = entryRoot.modelData
                                submenuPopup.anchorY = entryRoot.y
                                submenuPopup.visible = true
                            }
                        }
                        onExited: {
                            if (entryRoot.modelData.hasChildren) {
                                submenuPopup.visible = false
                            }
                        }
                        onClicked: {
                            entryRoot.modelData.triggered()
                            popup.visible = false
                        }
                    }
                }
            }
        }
    }

    PopupWindow {
        id: submenuPopup
        property var menu: null
        property real anchorY: 0

        anchor.window: root.parentWindow
        anchor.rect.x: root.menuX - submenuColumn.implicitWidth
        anchor.rect.y: root.menuY + anchorY
        grabFocus: false
        color: Colors.md3.surface
        implicitWidth: submenuColumn.implicitWidth + 16
        implicitHeight: submenuColumn.implicitHeight + 8
        visible: false

        onVisibleChanged: {
            if (!visible) menu = null
        }

        QsMenuOpener {
            id: submenuOpener
            menu: submenuPopup.menu
        }

        ColumnLayout {
            id: submenuColumn
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: submenuOpener.children

                Rectangle {
                    required property var modelData
                    implicitWidth: subLabel.implicitWidth + 16
                    Layout.fillWidth: true
                    implicitHeight: modelData.isSeparator ? 8 : 24
                    color: "transparent"

                    Text {
                        id: subLabel
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 8
                        text: modelData.text
                        color: modelData.enabled ? Colors.md3.on_surface : Colors.md3.outline
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            modelData.triggered()
                            popup.visible = false
                            submenuPopup.visible = false
                        }
                    }
                }
            }
        }
    }
}
