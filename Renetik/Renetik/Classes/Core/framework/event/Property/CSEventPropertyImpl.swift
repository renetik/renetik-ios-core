//
// Created by Rene Dohan on 11/22/20.
//

import Foundation

open class CSEventPropertyImpl<T>: CSEventProperty where T: Equatable {

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
    public func onChange(_ function: @escaping ArgFunc<T>) -> CSRegistration {
        eventChange.listen { function($0) }
    }

    @discardableResult
    public func apply() -> Self {
        onApply?(value)
        eventChange.fire(value)
        return self
    }
}