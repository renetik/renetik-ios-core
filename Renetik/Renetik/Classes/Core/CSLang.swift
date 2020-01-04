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

    init(_ message: String) { self.message = message }

    public var localizedDescription: String { message }
}

public func localized(_ key: String) -> String {
    let notFound = "Not Found"
    let string = Bundle.main.localizedString(forKey: key, value: notFound, table: nil)
    if string == notFound {
        logWarn("localized key ot found \(key)")
        return key
    }
    return string
}

public func doLater(function: @escaping () -> Void) {
    doLater(seconds: 0, function: function)
}

public func doLater(seconds: Int, function: @escaping () -> Void) {
    doLater(seconds: Double(seconds), function: function)
}

public func doLater(seconds: Double, function: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: function)
}

public func stringify<Subject>(_ value: Subject) -> String {
    if value == nil { return "nil" }
    return String(reflecting: value)
}

public func notNil(_ items: Any?...) -> Bool {
    for it in items { if it.isNil { return false } }
    return true
}

public func isSomeNil(_ items: Any?...) -> Bool { !notNil(items) }

open class CSObject: CSAny, Equatable, CustomStringConvertible {
    public init() {}

    public static func ==(lhs: CSObject, rhs: CSObject) -> Bool { lhs === rhs }

    public var description: String { "\(type(of: self))" }
}

public class Nil: CSAny, Equatable {
    private init() {}

    public static var instance: Nil = Nil()

    public static func ==(lhs: Nil, rhs: Nil) -> Bool { true }
}

extension NSObject: CSAny {}

extension String: CSAny {}

extension Int: CSAny {}

extension Array: CSAny {}

extension Dictionary: CSAny {}