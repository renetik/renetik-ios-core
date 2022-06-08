//
// Created by Rene Dohan on 12/16/19.
//

import Foundation

public protocol OptionalProtocol {
    var asString: String { get }
}

extension Optional: OptionalProtocol, CSAnyProtocol {
    public var asString: String { self == nil ? "" : String(describing: unsafelyUnwrapped) }
    public var asInt: Int { let value = asString; return value.isEmpty ? 0 : value.intValue }
}

public extension Optional {
    var notNil: Bool { self != nil }
    var isSet: Bool { self != nil }
    var isNil: Bool { self == nil }

    @discardableResult
    func notNil(_ function: (Wrapped) -> Void) -> CSConditionalResult {
        if self != nil {
            function(self!)
            return CSConditionalResult(doElseIf: false)
        }
        return CSConditionalResult(doElseIf: true)
    }

    @discardableResult
    func isNil(_ function: Func) -> CSConditionalResultNotNil<Wrapped> {
        if self == nil {
            function()
            return CSConditionalResultNotNil()
        }
        return CSConditionalResultNotNil(variable: self!)
    }

    //Kotlin let
    func ret<ReturnType>(_ function: (Wrapped) -> ReturnType) -> ReturnType? {
        if self != nil { return function(self!) }
        else { return nil }
    }
}

public extension Optional where Wrapped: AnyObject {
    func equals<T>(to object: T?) -> Bool where T: AnyObject {
        if self == nil { return object == nil }
        else { return self! === object }
    }
}

public extension Optional where Wrapped == String {
    var boolValue: Bool {
        if self == nil { return false }
        else { return unsafelyUnwrapped.boolValue }
    }
}

public extension Optional where Wrapped: Equatable {
    func equals(any objects: Wrapped...) -> Bool { equals(any: objects) }

    func equals(any objects: [Wrapped]) -> Bool { objects.contains { $0 == self } }

    func equals(none objects: Wrapped...) -> Bool { !equals(any: objects) }

    func isOther(then objects: Wrapped...) -> Bool { !equals(any: objects) }
}

public class CSConditionalResultNotNil<Type> {

    let variable: Type?
    let notNil: Bool

    init() {
        self.notNil = false
        self.variable = nil
    }

    init(variable: Type) {
        self.notNil = true
        self.variable = variable
    }

    public func elseDo(_ function: (Type) -> Void) { if notNil { function(variable!) } }
}