import Foundation

public class CSDictionary<Key, Value>: CSObject {

    private let dictionary = NSMutableDictionary()

    public var isEmpty: Bool { dictionary.count == 0 }

    @discardableResult
    public func add(_ key: Key, _ value: Value) -> Value { dictionary["\(key)"] = value; return value }

    @discardableResult
    public func add(key: Key, value: Value) -> Value { dictionary["\(key)"] = value; return value }

    public func value(_ key: Key) -> Value? { dictionary["\(key)"] as? Value }

    public func value(key: Key) -> Value? { dictionary["\(key)"] as? Value }

    @discardableResult
    public func remove(key: Key) -> Value? {
        value(key: key).also { _ in dictionary.removeObject(forKey: "\(key)") }
    }

    public var values: [Value] { dictionary.allValues as! [Value] }

    public var keys: [Key] { dictionary.allKeys as! [Key] }
}
