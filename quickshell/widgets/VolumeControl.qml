import ".."

import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire

Rectangle {
    id: root
    radius: 8
    implicitWidth: label.implicitWidth + 20
    implicitHeight: label.implicitHeight + 6
    color: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_bright
    Behavior on color { ColorAnimation { duration: 200 } }

    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [root.sink] }   // required — binds the sink so .audio is valid
    
    required property var parentWindow
    VolumeSlider {
      id: volumeSlider
      parentWindow: root.parentWindow   // or however this widget currently gets its window reference
    }

    Text {
        id: label
        renderType: Text.NativeRendering
        anchors.centerIn: parent
        color: Colors.md3.on_surface
        font { family : "JetBrainsMono Nerd Font Propo"; pixelSize: 13; bold: true}
        text: {
            const vol = root.sink?.audio?.volume ?? 0
            const muted = root.sink?.audio?.muted ?? false
            let glyph
            if (muted) glyph = ""
            else if (vol < 0.33) glyph = " "
            else if (vol < 0.66) glyph = " "
            else glyph = " "
            return muted ? glyph : glyph + Math.round(vol * 100) + "%"
        }
    }

    Process { id: pavuProc; command: ["pavucontrol-qt"] }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        // onClicked: pavuProc.running = true
        onClicked: {
            const pos = root.mapToItem(parentWindow.contentItem, root.width / 2, 0)
            volumeSlider.openAt(pos.x - 28, pos.y + 40 )
        }
        onWheel: wheel => {
            if (!root.sink?.ready || !root.sink?.audio) return
            const step = 0.02
            const delta = wheel.angleDelta.y > 0 ? step : -step
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta))
        }
    }
}
