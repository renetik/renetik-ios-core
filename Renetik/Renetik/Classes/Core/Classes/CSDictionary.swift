//
// Created by Rene Dohan on 3/15/20.
//

import Foundation
import RenetikObjc

public class CSDictionary<Key, Value>: CSObject {

    private let dictionary = NSMutableDictionary()

    public var isEmpty: Bool { dictionary.count == 0 }

    public func add(_ key: Key, _ value: Value) -> Value { dictionary.put("\(key)", value); return value }

    public func add(key: Key, value: Value) -> Value { dictionary.put("\(key)", value); return value }

    public func value(_ key: Key) -> Value? { dictionary["\(key)"] as? Value }

    public func value(key: Key) -> Value? { dictionary["\(key)"] as? Value }

    public func remove(_ key: Key) -> Self { dictionary.removeObject(forKey: "\(key)"); return self }

    public func remove(key: Key) -> Self { dictionary.removeObject(forKey: "\(key)"); return self }

    public var values: [Value] { dictionary.allValues as! [Value] }

    public var keys: [Key] { dictionary.allKeys as! [Key] }
}
