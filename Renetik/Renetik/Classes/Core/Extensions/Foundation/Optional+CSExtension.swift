//
// Created by Rene Dohan on 12/16/19.
//

import Foundation

public extension Optional {
    public var notNil: Bool { self != nil }

    public var isNil: Bool { self == nil }

    public var asString: String {
        if self == nil { return "" } else { return "\(self!)" }
    }

    @discardableResult
    public func notNil(_ function: (Wrapped) -> Void) -> CSConditionalResult {
        if self != nil {
            function(self!)
            return CSConditionalResult(doElseIf: false)
        }
        return CSConditionalResult(doElseIf: true)
    }

    @discardableResult
    public func isNil(_ function: Func) -> CSConditionalResultNotNil<Wrapped> {
        if self == nil {
            function()
            return CSConditionalResultNotNil()
        }
        return CSConditionalResultNotNil(variable: self!)
    }

    public func then<ReturnType>(_ function: (Wrapped) -> ReturnType) -> ReturnType? {
        if self != nil { return function(self!) } else { return nil }
    }

    public func equals(to object: Any?) -> Bool { //TODO: check how this is reliable
        if String(describing: self) == String(describing: object) { return true }
        return false
    }
}

public extension Optional where Wrapped: NSObject { //TODO: Use custom isEqual
    public func equals(one objects: NSObject...) -> Bool {
        if notNil { if objects.contains(self!) { return true } }
        return false
    }
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