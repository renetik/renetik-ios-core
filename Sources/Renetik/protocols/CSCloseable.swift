import Foundation

public protocol CSCloseable {
    func close()
}

extension CSCloseable {
    public func use(_ function: Func) {
        defer { close() }
        function()
    }
}

public class Closeable: CSCloseable {
    public init(_ onClose: @escaping Func) {
        self.onClose = onClose
    }

    let onClose: Func

    public func close() {
        onClose()
    }
}
