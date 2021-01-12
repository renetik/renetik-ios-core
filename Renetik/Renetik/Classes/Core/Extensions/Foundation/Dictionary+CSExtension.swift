//
// Created by Rene Dohan on 1/24/20.
//

import Foundation

public extension Dictionary {

    var isSet: Bool { !isEmpty }

    var isNotEmpty: Bool { !isEmpty }

    @discardableResult
    public mutating func add(_ other: Dictionary) -> Dictionary {
        other.forEach { k, v in self[k] = v }
        return self
    }

    @discardableResult
    public mutating func add(key: Key, value: Value) -> Value {
        self[key] = value
        return value
    }

    @discardableResult
    public mutating func remove(key: Key) -> Value? {
        removeValue(forKey: key)
    }

    public func toJsonString(formatted: Bool = false) -> String? {
        var options: JSONSerialization.WritingOptions = formatted ? [.prettyPrinted] : []
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: options) {
            return String(data: theJSONData, encoding: .ascii)
        }
        return nil
    }
}