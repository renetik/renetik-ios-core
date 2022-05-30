//
// Created by Rene Dohan on 30/05/22.
//

import Foundation

public protocol CSEventProperty: CSProperty {
    @discardableResult
    func onChange(_ function: @escaping (T) -> Void) -> CSRegistration
}

extension CSEventProperty {
    @discardableResult
    public func onChange(_ function: @escaping Func) -> CSRegistration {
        self.onChange { _ in function() }
    }
}