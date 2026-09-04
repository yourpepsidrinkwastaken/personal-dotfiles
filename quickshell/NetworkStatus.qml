// NetworkStatus.qml
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    property var activeDevice: {
        for (const dev of Networking.devices.values) {
            if (dev.state === 2) return dev
        }
        return null
    }
    property bool connected: activeDevice !== null
    property bool isWifi: activeDevice?.type === 1
}
