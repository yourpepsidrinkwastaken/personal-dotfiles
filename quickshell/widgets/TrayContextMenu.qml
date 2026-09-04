import ".."

import QtQuick
import QtQuick.Layouts
import Quickshell

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
            } else {
                menuColumn.forceActiveFocus()
                //console.log("popup size:", implicitWidth, implicitHeight)
                //console.log("menuColumn size:", menuColumn.implicitWidth, menuColumn.implicitHeight)
                //console.log("opener.children.count:", opener.children.count)
            }
        }

        ColumnLayout {
            id: menuColumn
            anchors.fill: parent
            spacing: 0
            Keys.onEscapePressed: popup.visible = false

            Repeater {
                model: opener.children
                MenuEntryDelegate{
                  onEntryClicked: popup.visible = false
                  //Component.onCompleted: console.log("delegate created, modelData:", modelData)
                }
            }
        }
    }
}
