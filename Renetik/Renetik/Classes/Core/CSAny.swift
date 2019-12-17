//
// Created by Rene Dohan on 12/16/19.
//

import Foundation

public protocol CSAny: CustomStringConvertible {
}

public extension CSAny {

    public static func cast(_ object: Any) -> Self { object as! Self }

    public var notNil: Bool { true }

    public var isNil: Bool { false }

    @discardableResult
    public func also(_ function: (Self) -> Void) -> Self {
        function(self)
        return self
    }

    @discardableResult
    public func invoke(_ function: () -> Void) -> Self {
        function()
        return self
    }

    public func then(_ function: (Self) -> Void) { function(self) }

    // let in kotlin
    public func get<ReturnType>(_ function: (Self) -> ReturnType) -> ReturnType { function(self) }

    public var asString: String { "\(self)" }

    public var description: String { asString }

    public func cast<T>() -> T { self as! T }

    public func castOrNil<T>() -> T? { self as? T }

    public func equals(to object: Any?) -> Bool { //TODO: check how this is reliable
        if String(describing: self) == String(describing: object) { return true }
        return false
    }
}

public extension CSAny where Self: NSObject { //TODO: Use custom isEqual
    public func equals(one objects: NSObject...) -> Bool {
        if objects.contains(self) { return true }
        return false
    }
}