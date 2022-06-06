//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

public typealias Boolean = Bool
public typealias Func = () -> Void
public typealias ArgFunc<Argument> = (Argument) -> Void

public class CSLang {
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
//    public let isDebug: Bool = {
//        var isDebug = false
//
//        func setDebug() -> Bool {
//            isDebug = true
//            return true
//        }
//
//        assert(setDebug())
//        return isDebug
//    }()
}

extension TimeInterval {
    public static let defaultAnimation: TimeInterval = 0.25
}

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

public let csBundle: Bundle = {
    //    When use_frameworks! let bundle = Bundle(identifier: "org.cocoapods.Renetik")!
    //    When #use_modular_headers! Bundle.main
    //    TODO?: How to solve this universally
    let bundle = Bundle(identifier: "org.cocoapods.Renetik")!
    return Bundle(path: bundle.path(forResource: "RenetikBundle", ofType: "bundle")!)!
}()

public func localized(_ key: String) -> String {
    var string = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    if string == key {
        string = csBundle.localizedString(forKey: key, value: nil, table: nil)
        if string == key { logWarn("localized key ot found \(key)") }
    }
    return string
}

public func later(function: @escaping Func) {
    DispatchQueue.main.async(execute: function)
}

public func later(seconds: TimeInterval, function: @escaping Func) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: function)
}

private let userInitiatedQueue = DispatchQueue(label: "CSUserInitiatedQueue", qos: .userInitiated)

private let utilityQueue = DispatchQueue(label: "CSUtilityQueue", qos: .utility)

public func background(function: @escaping Func) {
    userInitiatedQueue.async(execute: function)
}

public func stringify<Subject>(_ value: Subject) -> String {
    (value as? OptionalProtocol)?.asString ?? String(describing: value)
}

public func describe<Subject>(_ value: Subject) -> String {
    String(describing: value)
}

public func notNil(_ items: Any?...) -> Bool {
    for it in items { if it.isNil { return false } }
    return true
}

public func isAllNil(_ items: Any?...) -> Bool {
    for it in items { if it.notNil { return false } }
    return true
}

public func isAnyNil(_ items: Any?...) -> Bool {
    for it in items { if it.isNil { return true } }
    return false
}

public func when<Type>(notNil item: Type?, then: ArgFunc<Type>) {
    if item.notNil { then(item!) }
}

public func when<Type>(isNil item: Type?, then: Func) {
    if item.isNil { then() }
}

open class CSObject: CSAnyProtocol, Equatable, CustomStringConvertible {
    public init() {}
}

public class Nil: CSAnyProtocol, Equatable {
    private init() {}
    
    public static var instance: Nil = Nil()
    
    public static func ==(lhs: Nil, rhs: Nil) -> Bool { true }
}

public class CSConditionalResult {
    let isDoElse: Bool
    
    public init(doElseIf: Bool) { isDoElse = doElseIf }
    
    public func elseDo(_ function: Func) { if isDoElse { function() } }
}
