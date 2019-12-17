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

public func doLaterSwift(_ function: @escaping () -> Void) {
    doLaterSwift(0, function)
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

public func notNil(_ items: Any?...) -> Bool {
    for it in items { if it.isNil { return false } }
    return true
}

public func isSomeNil(_ items: Any?...) -> Bool { !notNil(items) }


open class CSObject: CSAny, Equatable {
    public static func ==(lhs: CSObject, rhs: CSObject) -> Bool {
        lhs === rhs
    }
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