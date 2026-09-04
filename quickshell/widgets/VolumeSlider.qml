import ".."
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Item {
    id: root
    required property var parentWindow
    property real anchorX: 0
    property real anchorY: 0

    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [root.sink] }

    function openAt(x, y) {
        popup.visible = false
        root.anchorX = x
        root.anchorY = y
        Qt.callLater(() => { popup.visible = true })
    }

    Process { id: pavuProc; command: ["pavucontrol-qt"] }

    PopupWindow {
        id: popup
        anchor.window: root.parentWindow
        anchor.rect.x: root.anchorX
        anchor.rect.y: root.anchorY
        grabFocus: true
        color: "transparent"
        implicitWidth: 56
        implicitHeight: 200

        
        Rectangle {
            anchors.fill: parent
            radius: 15
            color: Colors.md3.surface
            border {
              color: Colors.md3.primary
              width: 2
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                // vertical track + fill + drag handle
                Item {
                    id: track
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillHeight: true
                    implicitWidth: 8

                    Keys.onEscapePressed: popup.visible = false

                    Rectangle {
                        anchors.fill: parent
                        radius: 4
                        color: Colors.md3.surface_container_high
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        radius: 4
                        color: Colors.md3.primary
                        height: parent.height * (root.sink?.audio?.volume ?? 0)
                        Behavior on height { NumberAnimation { duration: 80 } }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: mouse => updateVolume(mouse.y)
                        onPositionChanged: mouse => { if (pressed) updateVolume(mouse.y) }

                        function updateVolume(y) {
                            if (!root.sink?.audio) return
                            const ratio = 1 - Math.max(0, Math.min(1, y / track.height))
                            root.sink.audio.volume = ratio
                        }
                    }
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: Math.round((root.sink?.audio?.volume ?? 0) * 100) + "%"
                    color: Colors.md3.on_surface
                    font.family: Config.fontFamily
                    font.pixelSize: Config.fontSize
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    radius: 16
                    color: mixerMouse.containsMouse ? Colors.md3.surface_container_high : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "\uf6a8"   // mixer/slider glyph, swap for your preferred one
                        color: Colors.md3.on_surface
                        font.family: Config.fontFamily
                    }

                    MouseArea {
                        id: mixerMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                          pavuProc.running = true
                          popup.visible = false
                        }
                    }
                }
            }
        }
    }
}
