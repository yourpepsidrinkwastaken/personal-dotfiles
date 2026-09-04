import ".."

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

ColumnLayout {
    id: entryRoot
    required property var modelData
    property bool expanded: false
    signal entryClicked()
    Layout.fillWidth: true
    spacing: 0

    Rectangle {
        id: rowRect
        Layout.fillWidth: true
        Layout.preferredHeight: entryRoot.modelData?.isSeparator ? 8 : 24
        implicitWidth: label.implicitWidth + (checkMark.visible ? 24 : 8) + (entryRoot.modelData?.hasChildren ? 28 : 16)
        implicitHeight: entryRoot.modelData?.isSeparator ? 8 : 24
        color: rowMouse.containsMouse ? Colors.md3.surface_container : "transparent"

        Rectangle {
            visible: entryRoot.modelData?.isSeparator ?? false
            anchors.centerIn: parent
            width: parent.width - 8
            height: 1
            color: Colors.md3.outline_variant
        }

        Text {
            id: checkMark
            visible: !(entryRoot.modelData?.isSeparator ?? false) && entryRoot.modelData?.checkState === Qt.Checked
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf00c"
            color: Colors.md3.primary
        }

        Text {
            id: label
            visible: !(entryRoot.modelData?.isSeparator ?? false)
            anchors.left: checkMark.visible ? checkMark.right : parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 8
            text: entryRoot.modelData?.text ?? ""
            color: (entryRoot.modelData?.enabled ?? false) ? Colors.md3.on_surface : Colors.md3.outline
        }

        Text {
            visible: entryRoot.modelData?.hasChildren ?? false
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 8
            text: entryRoot.expanded ? "\uf078" : "\uf054"
            color: Colors.md3.on_surface
        }

        MouseArea {
            id: rowMouse
            anchors.fill: parent
            hoverEnabled: true
            enabled: !(entryRoot.modelData?.isSeparator ?? false) && (entryRoot.modelData?.enabled ?? false)
            onClicked: {
                if (entryRoot.modelData?.hasChildren) {
                    entryRoot.expanded = !entryRoot.expanded
                } else {
                    entryRoot.modelData?.triggered()
                    entryRoot.entryClicked()
                }
            }
        }
    }

    QsMenuOpener {
        id: childOpener
        menu: entryRoot.expanded ? entryRoot.modelData : null
    }

    ColumnLayout {
        visible: entryRoot.expanded
        Layout.fillWidth: true
        Layout.leftMargin: 16
        spacing: 0

        Repeater {
            model: childOpener.children
            Loader {
                id: subLoader
                active: false

                Component.onCompleted: {
                    setSource("MenuEntryDelegate.qml", { modelData: modelData })
                    active = true
                }

                onLoaded: {
                    //item.modelData = modelData
                    item.entryClicked.connect(entryRoot.entryClicked)
                }
            }
        }
    }
}
