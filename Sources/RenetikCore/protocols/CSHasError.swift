//
// Created by Rene Dohan on 2/5/21.
//

import Foundation

public protocol CSHasErrorProtocol {
    func errorClear()
    func error(_ message: String)
}

public extension CSHasErrorProtocol {
    @discardableResult
    func errorClear() -> Self { errorClear(); return self }

    @discardableResult
    func error(_ message: String) -> Self { error(message); return self }
}