import Foundation

private struct WeakValue<Value:AnyObject> {
    weak var value: Value?
}

public class CSWeakValueDictionary<Key:AnyObject, Value:AnyObject> {
    private let dictionary = NSMutableDictionary()
    public subscript(source: Key) -> Value? {
        get {
            let value = (dictionary["\(source)"] as? WeakValue<Value>)?.value
            if value == nil { dictionary.removeObject(forKey: "\(source)") }
            return value
        }
        set { dictionary["\(source)"] = WeakValue(value: newValue) }
    }
}
