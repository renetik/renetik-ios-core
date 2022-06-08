//
// Created by Rene Dohan on 11/22/20.
//

import Foundation

public protocol CSProperty: CSValueProtocol {
    override var value: T { get set }
}

public func variable<T>(_ value: T) -> CSVariable<T> {
    CSVariable(value: value)
}

public class CSVariable<T>: CSProperty {
    public var value: T

    init(value: T) {
        self.value = value
    }
}

extension CSProperty where T: Any {
    func value(_ value: T) -> Self {
        self.value = value
        return self
    }
}

public extension CSProperty where T == Bool {
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

