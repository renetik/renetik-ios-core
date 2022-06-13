//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSValueProtocol: AnyObject {
    associatedtype T
    var value: T { get }
}

public func value<T>(_ value: T) -> CSValue<T> {
    CSValue(value: value)
}

public class CSValue<T>: CSValueProtocol {
    private var _value: T?
    public var value: T { _value! }

    init(value: T) { _value = value }

    init() {}

    func initialize(value: T) { _value = value }
}

public extension CustomStringConvertible where T == String, Self: CSValueProtocol {
    var description: String { value }
}