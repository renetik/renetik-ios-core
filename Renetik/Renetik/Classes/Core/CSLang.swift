//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

enum CSError: Error {
    case todo()
    case unsupported()
    case failed()
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

public protocol CSLang {
}

public extension CSLang {
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

public extension CSLang where Self: NSObject {
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
    public func notNil(_ function: (Wrapped) -> Void) -> Optional<Wrapped> {
        if self != nil { function(self!) }
        return self
    }

    @discardableResult
    public func isNil(_ function: () -> Void) -> Bool {
        if self == nil { function() }
        return self == nil
    }

//
//    public func then(function: (Wrapped) -> Void) {
//        if self != nil { function(self!) }
//    }

    public func then<ReturnType>(_ function: (Wrapped) -> ReturnType) -> ReturnType? {
        if self != nil { return function(self!) } else { return nil }
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

extension NSObject: CSLang {
}

extension String: CSLang {
}

extension Array: CSLang {
}

extension Dictionary: CSLang {
}

extension CSObject: CSLang {
}
