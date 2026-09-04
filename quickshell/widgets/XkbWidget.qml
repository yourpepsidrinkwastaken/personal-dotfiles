import ".."
import QtQuick

Text {
  text: HyprlandXkb.currentLayoutCode
  renderType: Text.NativeRendering
  anchors.centerIn: parent
  font {
    family: Config.fontFamily
    pixelSize: Config.fontSize
    bold: COnfig.fontBold
  }
}
