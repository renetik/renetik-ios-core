//
// Created by Rene Dohan on 12/16/19.
//

import UIKit

public protocol CSAnyProtocol {
}

public extension CSAnyProtocol {

    static func cast(_ object: Any) -> Self { object as! Self }

    var notNil: Bool { true }

    var isSet: Bool { true }

    var isNil: Bool { false }

    @discardableResult
    func also(_ function: (Self) -> Void) -> Self {
        function(self)
        return self
    }

    func then(_ function: (Self) -> Void) {
        function(self)
    }

    @discardableResult
    func invoke(_ function: Func) -> Self {
        function()
        return self
    }

    @discardableResult
    func invoke(from: Int, until: Int, function: (Int) -> Void) -> Self {
        from.until(until, function)
        return self
    }

    func run(_ function: Func) {
        function()
    }

    // Kotlin let
    func ret<ReturnType>(_ function: (Self) -> ReturnType) -> ReturnType { function(self) }

    var asString: String {
        (self as? CSNameProtocol)?.name ??
            (self as? CustomStringConvertible)?.description ?? "\(self)"
    }

    var asInt: Int {
        let value = asString
        return value.isEmpty ? 0 : value.intValue
    }

    var asDouble: Double {
        let value = asString
        return value.isEmpty ? 0 : value.doubleValue
    }

    func cast<T>() -> T { self as! T }

    func castOrNil<T>() -> T? { self as? T }

    func isTrue(predicate: (Self) -> Bool) -> Bool { predicate(self) }

    func isFalse(predicate: (Self) -> Bool) -> Bool { !predicate(self) }
}

public extension CSAnyProtocol where Self: AnyObject {
    var hashString: String { String(UInt(bitPattern: ObjectIdentifier(self))) }
}

public extension CSAnyProtocol where Self: NSObject {

    static func className() -> String { description() }

    func className() -> String { type(of: self).description() }

    func equals(any objects: NSObject...) -> Bool {
        if objects.contains(self) { return true }; return false
    }
}

public extension CSAnyProtocol where Self: Equatable {
    func equals(any objects: Self...) -> Bool { objects.contains { $0 == self } }

    func isAny(_ objects: Self...) -> Bool { objects.contains { $0 == self } }

    func equals(_ object: Self) -> Bool { object == self }
}

public extension CSAnyProtocol where Self: Equatable, Self: AnyObject {
    static func ==(lhs: Self, rhs: Self) -> Bool { lhs === rhs }
}

public extension CSAnyProtocol where Self: CustomStringConvertible {
    var description: String { "\(type(of: self))" }
}

public extension CSAnyProtocol where Self: CustomStringConvertible, Self: CSNameProtocol {
    var description: String { name }
}


extension IndexPath: CSAnyProtocol {}

extension NSObject: CSAnyProtocol {}

extension Bool: CSAnyProtocol {}

extension String: CSAnyProtocol {}

extension Int: CSAnyProtocol {}

extension Float: CSAnyProtocol {}

extension Double: CSAnyProtocol {}

extension CGFloat: CSAnyProtocol {}

extension Array: CSAnyProtocol {}

extension Dictionary: CSAnyProtocol {}

extension Date: CSAnyProtocol {}

//public extension Optional where Wrapped: CSAnyProtocol {
//    public var asString: String {
//        (self as? CSNameProtocol)?.name ??
//                (self as? CustomStringConvertible)?.description ?? "\(self)"
//    }
//}
