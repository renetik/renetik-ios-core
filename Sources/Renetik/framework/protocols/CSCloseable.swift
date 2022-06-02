import Foundation

protocol CSCloseable {
    func close()
}

extension CSCloseable {
    func use(_ function: Func) {
        defer { close() }
        function()
    }
}

class Closeable: CSCloseable {
    init(_ onClose: @escaping Func) {
        self.onClose = onClose
    }

    let onClose: Func

    func close() {
        onClose()
    }
}
