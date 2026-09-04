// BluetoothStatus.qml
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    property var adapter: Bluetooth.defaultAdapter
    property bool enabled: adapter?.enabled ?? false
    property int connectedCount: {
        if (!adapter) return 0
        let count = 0
        for (const dev of adapter.devices.values) {
            if (dev.connected) count++   // ← `connected` on BluetoothDevice not yet confirmed, worth verifying
        }
        return count
    }
}
