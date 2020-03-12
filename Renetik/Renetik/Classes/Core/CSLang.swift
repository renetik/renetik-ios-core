//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

public let defaultAnimationTime: TimeInterval = 0.25

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

let isDebug: Bool = {
    var isDebug = false

    func setDebug() -> Bool {
        isDebug = true
        return true
    }

    assert(setDebug())
    return isDebug
}()

let renetikBundle = {
    Bundle(path: Bundle.main.path(forResource: "RenetikBundle", ofType: "bundle")!)!
}()

public func localized(_ key: String) -> String {
    var string = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    if string == key {
        string = renetikBundle.localizedString(forKey: key, value: nil, table: nil)
        if string == key { logWarn("localized key ot found \(key)") }
    }
    return string
}

public func later(seconds: Int = 0, function: @escaping () -> Void) {
    later(seconds: Double(seconds), function: function)
}

public func later(seconds: Double, function: @escaping () -> Void) {
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

extension IndexPath: CSAny {}

extension NSObject: CSAny {}

extension String: CSAny {}

extension Int: CSAny {}

extension Float: CSAny {}

extension Double: CSAny {}

extension CGFloat: CSAny {}

extension Array: CSAny {}

extension Dictionary: CSAny {}

func function(if boolean: Bool, function: () -> Void) -> CSConditionalResult {
    if boolean { function() }
    return CSConditionalResult(doElseIf: boolean == false)
}

public class CSConditionalResult {
    let isDoElse: Bool

    public init(doElseIf: Bool) { self.isDoElse = doElseIf }

    public func elseDo(_ function: () -> Void) { if isDoElse { function() } }
}

func functionTest() {
    let A = "A"
    let B = "B"
    function(if: A == B) {
        let message = "A == B"
        logInfo(message)
    }.elseDo {
        let message = "A != B"
        logInfo(message)
    }
}
