import Quickshell
import QtQuick
import QtQuick.Layouts

// import directories
import ".."
import qs.widgets

Scope {
  Variants {
    model: Quickshell.screens // this will allow us to run multiple monitors

    PanelWindow {
      id: barWindow
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }
      color: Colors.md3.surface

      implicitHeight: 42

      Component.onCompleted: AppWindow.barWindow = barWindow

      // modules-left 
      RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 8

        RofiButton {}
        //HyprWorkspaces{}
        ExtWorkspacesMango {
          screen: barWindow.screen
        }
      }

      // modules-center
      RowLayout {
        anchors.centerIn: parent
        spacing: 8

        ClockButton{}
        NotificationsButton{}
      }

      // modules-right
      RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        spacing: 8

        SysTray{
         parentWindow: barWindow
        }
        NetworkBluetoothRow{}
        BatteryButton{}
        VolumeControl{
          parentWindow: barWindow
        }
        LogoutButton{}
      }
    }
  }
}
