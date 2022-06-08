//
// Created by Rene Dohan on 1/24/20.
//

import Foundation

public extension Dictionary {

    var isSet: Bool { !isEmpty }

    var isNotEmpty: Bool { !isEmpty }

    @discardableResult
    mutating func add(_ other: Dictionary) -> Dictionary {
        for (k, v) in other { self[k] = v }
        return self
    }

    @discardableResult
    mutating func add(key: Key, value: Value) -> Value {
        self[key] = value
        return value
    }

    @discardableResult
    mutating func remove(key: Key) -> Value? {
        removeValue(forKey: key)
    }

    @inlinable mutating func clear(keepingCapacity keepCapacity: Bool = false) {
        removeAll(keepingCapacity: keepCapacity)
    }

    @inlinable mutating func removeIf(condition: (Self.Element) -> Bool) {
        for (key, _) in filter(condition) { removeValue(forKey: key) }
    }
}