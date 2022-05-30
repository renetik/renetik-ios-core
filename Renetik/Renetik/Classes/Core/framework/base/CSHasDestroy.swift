//
// Created by Rene Dohan on 29/05/22.
//

import Foundation

public protocol CSHasDestroy: CSAnyProtocol {
    var eventDestroy: CSEvent<Void> { get }
    func onDestroy()
}

public extension CSHasDestroy {
    public func onDestroy() {}

    public func onDestroy(listener: @escaping Func) -> CSRegistration {
        eventDestroy.listenOnce { _ in listener() }
    }
}