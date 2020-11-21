//
// Created by Rene Dohan on 1/31/20.
//

import Foundation
import RenetikObjc

private var associatedPropertyValuesKey: Void?

public extension NSObject {

    var values: NSMutableDictionary {
        associatedValue(&associatedPropertyValuesKey) { NSMutableDictionary() }
    }

    func value<T>(_ key: String, onCreate: () -> T) -> T {
        var object: T? = values.get(key) as? T
        if object == nil {
            object = onCreate()
            values.put(key, object)
        }
        return object!
    }

    func associatedValue<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
        var object: T? = associatedValue(key) as? T
        if object == nil {
            object = onCreate()
            associateValue(key, object)
        }
        return object!
    }

    func weaklyAssociatedValue<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
        var object: T? = associatedValue(key) as? T
        if object == nil {
            object = onCreate()
            weaklyAssociateValue(key, object)
        }
        return object!
    }

    func associatedValue(_ key: UnsafeRawPointer!) -> Any? {
        bk_associatedValue(forKey: key)
    }

    func associateValue(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
        bk_associateValue(value, withKey: key)
        return self
    }

    func weaklyAssociateValue(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
        bk_weaklyAssociateValue(value, withKey: key)
        return self
    }

}