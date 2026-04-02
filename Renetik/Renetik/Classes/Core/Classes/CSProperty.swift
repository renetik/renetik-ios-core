//
// Created by Rene Dohan on 4/2/26.
//

import Foundation

public func property<Type>(_ value: Type, onChange: ((Type) -> Void)? = nil) -> CSProperty<Type> {
    CSProperty(value, onChange: onChange)
}

public func property<Type>(onChange: ((Type?) -> Void)? = nil) -> CSProperty<Type?> {
    CSProperty<Type?>(nil, onChange: onChange)
}

open class CSProperty<Type>: CSObject {
    public typealias Equality = (Type, Type) -> Bool

    private let equals: Equality
    private let onApply: ((Type) -> Void)?
    private var _value: Type
    private var pauseCount = 0

    public let eventChange: CSEvent<Type> = event()

    public private(set) var isChanged = false

    public init(_ value: Type, onChange: ((Type) -> Void)? = nil) {
        _value = value
        equals = CSProperty.defaultEquals
        onApply = onChange
        super.init()
    }

    public init(
        _ value: Type,
        equals: @escaping Equality,
        onChange: ((Type) -> Void)? = nil
    ) {
        _value = value
        self.equals = equals
        onApply = onChange
        super.init()
    }

    open var value: Type {
        get { _value }
        set(value) { self.value(value) }
    }

    @discardableResult
    open func onChange(_ function: @escaping (Type) -> Void) -> CSEventListener<Type> {
        eventChange.invoke(listener: function)
    }

    @discardableResult
    open func onChange(
        _ function: @escaping (CSEventListener<Type>, Type) -> Void
    ) -> CSEventListener<Type> {
        eventChange.invoke(listener: function)
    }

    open func fireChange() {
        let actualValue = value
        onApply?(actualValue)
        if isPaused { return }
        eventChange.fire(actualValue)
    }

    open func value(_ newValue: Type, fire: Bool = true) {
        if equals(_value, newValue) { return }
        _value = newValue
        onValueChanged(newValue, fire: fire)
    }

    open func pause() {
        if !isPaused { isChanged = false }
        pauseCount += 1
    }

    open func resume(fireChange shouldFireChange: Bool = true) {
        if pauseCount > 0 { pauseCount -= 1 }
        if isPaused { return }
        if isChanged, shouldFireChange { fireChange() }
        isChanged = false
    }

    open func onValueChanged(_: Type, fire: Bool = true) {
        isChanged = true
        if fire { fireChange() }
    }

    private var isPaused: Bool {
        pauseCount > 0
    }

    private static func defaultEquals(_ lhs: Type, _ rhs: Type) -> Bool {
        if let lhs = lhs as? any Equatable {
            return lhs.isEqual(to: rhs)
        }
        if let lhs = lhs as? NSObject, let rhs = rhs as? NSObject {
            return lhs.isEqual(rhs)
        }
        return false
    }
}

public extension CSProperty {
    @discardableResult
    func fire() -> Self {
        fireChange()
        return self
    }

    @discardableResult
    func paused(fire: Bool = true, _ function: (CSProperty<Type>) -> Void) -> Self {
        pause()
        function(self)
        resume(fireChange: fire)
        return self
    }
}

private extension Equatable {
    func isEqual(to other: Any) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}
