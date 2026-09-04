//@ pragma UseQApplication

import qs.main
import Quickshell
import Quickshell.Io

Scope {
  Bar {}

  IpcHandler {
    target: "reload"
    function hard(): void {
        Quickshell.reload(true)
    }
  }
}


