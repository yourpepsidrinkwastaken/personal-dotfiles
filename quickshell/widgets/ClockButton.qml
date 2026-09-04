import ".."

import QtQuick

Rectangle {
    id: root
    color: Colors.md3.surface_bright
    radius: 8
    implicitWidth: label.implicitWidth + 20
    implicitHeight: label.implicitHeight + 6
    
    Text {
      renderType: Text.NativeRendering
      id: label
      anchors.centerIn: parent
      text: Time.time
      color: Colors.md3.on_surface
      font {
        family: Config.fontFamily
        pixelSize: Config.fontSize
        bold: Config.fontBold
      }
    }
}
