//
// Created by Rene Dohan on 11/22/20.
//

import Foundation

public protocol CSPropertyProtocol: CSVariableProtocol {
    @discardableResult
    func onChange(_ function: @escaping (T) -> Void) -> CSEventRegistration
}

extension CSPropertyProtocol {
    @discardableResult
    public func onChange(_ function: @escaping Func) -> CSEventRegistration {
        onChange { _ in function() }
    }
}

open class CSProperty<T>: CSPropertyProtocol where T: Equatable {

    private let eventChange: CSEvent<T> = event()
    private var onApply: ((T) -> ())?
    private var _value: T

    public var value: T {
        get { _value }
        set { value(newValue, fireEvents: true) }
    }

    public init(value: T, onApply: ((T) -> ())? = nil) {
        _value = value
        self.onApply = onApply
    }

    @discardableResult
    public func value(_ newValue: T, fireEvents: Bool = true) -> Self {
        if _value == newValue { return self }
        _value = newValue
        if (fireEvents) {
            onApply?(newValue)
            eventChange.fire(newValue)
        }
        return self
    }

    @discardableResult
    public func onChange(_ function: @escaping ArgFunc<T>) -> CSEventRegistration {
        eventChange.listen { function($0) }
    }

    @discardableResult
    public func apply() -> Self {
        onApply?(value)
        eventChange.fire(value)
        return self
    }
}

public extension CSPropertyProtocol where T: CSAnyProtocol {
    var isSet: Bool {
        get { value.notNil }
    }
}

public extension CSPropertyProtocol where T == Bool {
    @discardableResult
    func toggle() -> Self { value = !value; return self }

    @discardableResult
    func setFalse() -> Self { value = false; return self }

    @discardableResult
    func setTrue() -> Self { value = true; return self }

    @discardableResult
    func onFalse(function: @escaping () -> Unit) -> CSEventRegistration {
        onChange { if $0.isFalse { function() } }
    }

    @discardableResult
    func onTrue(function: @escaping () -> Unit) -> CSEventRegistration {
        onChange { if $0.isTrue { function() } }
    }

    var isTrue: Bool {
        get { value }
        set { value = newValue }
    }

    var isFalse: Bool {
        get { !value }
        set { value = !newValue }
    }
}

public extension CSProperty where T == String? {
    var string: T {
        get { value.asString }
        set { value = newValue }
    }

    func text(_ string: T) { value = string }

    func string(_ string: T) { value = string }
}

public func property<T>(_ value: T, _ onApply: ((T) -> ())? = nil) -> CSProperty<T> {
    CSProperty(value: value, onApply: onApply)
}

//func property<T>(_ key: T, _  default: String, _ onApply: ((T) -> Unit)? = nil) -> CSProperty<T> {
//    application.store.property(key, default, onApply)
//}

//fun property(key: String, default: String, onApply: ((value: String) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(key: String, default: Float, onApply: ((value: Float) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(key: String, default: Int, onApply: ((value: Int) -> Unit)? = null) =
//        application.store.property(key, default, onApply)
//
//fun property(
//        key: String, default: Boolean,
//        onApply: ((value: Boolean) -> Unit)? = null
//) = application.store.property(key, default, onApply)
//
//fun <T> property(
//        key: String, values: List<T>, default: T,
//        onApply: ((value: T) -> Unit)? = null
//) = application.store.property(key, values, default, onApply)
//
//fun <T> property(
//        key: String, values: List<T>, defaultIndex: Int = 0,
//        onApply: ((value: T) -> Unit)? = null
//) = application.store.property(key, values, values[defaultIndex], onApply)
