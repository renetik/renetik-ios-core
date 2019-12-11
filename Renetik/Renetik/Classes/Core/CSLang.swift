//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

enum CSError: Error {
    case todo
    case unsupported
    case failed
}

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}

public func doLaterSwift(_ delayInSeconds: Int, _ function: @escaping () -> Void) {
    doLaterSwift(Double(delayInSeconds), function)
}

public func doLaterSwift(_ delayInSeconds: Double, _ function: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: function)
}

public func stringify<Subject>(_ value: Subject) -> String {
    if value == nil { return "" }
    return String(describing: value)
}

public protocol CSAny {
}

public extension CSAny {
    public var notNil: Bool {
        return true
    }

    public var isNil: Bool {
        return false
    }

    @discardableResult
    public func apply(_ function: (Self) -> Void) -> Self {
        function(self)
        return self
    }

    public func then(function: (Self) -> Void) {
        function(self)
    }

    public func get<ReturnType>(function: (Self) -> ReturnType) -> ReturnType {
        return function(self)
    }

    public var asString: String {
        return "\(self)"
    }

    public static func cast(_ object: Any) -> Self {
        return object as! Self
    }
}

public extension CSAny where Self: NSObject {
    public func equalsOne(_ objects: NSObject...) -> Bool {
        for object in objects {
            if self == object { return true }
        }
        return false
    }
}

public extension Optional {
    public var notNil: Bool {
        return self != nil
    }

    public var isNil: Bool {
        return self == nil
    }

    public var asString: String {
        if self == nil { return "" } else { return "\(self!)" }
    }

    @discardableResult
    public func notNil(_ function: (Wrapped) -> Void) -> CSConditionalResultNil {
        if self != nil {
            function(self!)
            return CSConditionalResultNil(isNil: false)
        }
        return CSConditionalResultNil(isNil: true)
    }

    @discardableResult
    public func isNil(_ function: () -> Void) -> CSConditionalResultNotNil<Wrapped> {
        if self == nil {
            function()
            return CSConditionalResultNotNil()
        }
        return CSConditionalResultNotNil(variable: self!)
    }

    public func then<ReturnType>(_ function: (Wrapped) -> ReturnType) -> ReturnType? {
        if self != nil { return function(self!) } else { return nil }
    }
}

public class CSConditionalResultNil {

    let isNil: Bool

    init(isNil: Bool) {
        self.isNil = isNil
    }

    public func elseDo(_ function: () -> Void) {
        if isNil { function() }
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

    public func elseDo(_ function: (Type) -> Void) {
        if notNil { function(variable!) }
    }
}

public extension Optional where Wrapped: NSObject {
    public func equalsOne(_ objects: NSObject...) -> Bool {
        if self == nil { return false }
        for object in objects {
            if self == object { return true }
        }
        return false
    }
}

open class CSObject {
}

extension NSObject: CSAny {
}

extension String: CSAny {
}

extension Int: CSAny {
}

extension Array: CSAny {
}

extension Dictionary: CSAny {
}

extension CSObject: CSAny {
}
