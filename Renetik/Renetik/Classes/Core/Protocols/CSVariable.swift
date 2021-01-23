//
// Created by Rene Dohan on 11/22/20.
//

import Foundation

public protocol CSVariableProtocol: CSValueProtocol {
    override var value: T { get set }
}

public func variable<T>(_ value: T) -> CSVariable<T> {
    CSVariable(value: value)
}

public class CSVariable<T>: CSVariableProtocol {
    public var value: T

    init(value: T) {
        self.value = value
    }
}

extension CSVariableProtocol where T: Any {
    func value(_ value: T) -> Self {
        self.value = value
        return self
    }
}

public extension CSVariableProtocol where T == Bool {
    @discardableResult
    func setTrue() -> Self {
        value = true
        return self
    }

    @discardableResult
    func setFalse() -> Self {
        value = false
        return self
    }
}

public extension CSVariable where T == Bool {
    @discardableResult
    func setTrue() -> Self {
        value = true
        return self
    }

    @discardableResult
    func setFalse() -> Self {
        value = false
        return self
    }

    var isTrue: Bool { value }

    var isFalse: Bool { !value }
}

