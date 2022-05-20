//
// Created by Rene Dohan on 1/31/20.
//

import Foundation
import BlocksKit

private var associatedPropertyValuesKey: Void?

public extension NSObject {

    var associatedDictionary: NSMutableDictionary {
        associatedValue(&associatedPropertyValuesKey) { NSMutableDictionary() }
    }

    func associatedDictionary<T>(_ key: String, onCreate: () -> T) -> T {
        var object: T? = associatedDictionary[key] as? T
        if object == nil {
            object = onCreate()
            associatedDictionary(key, object)
        }
        return object!
    }

    func associatedDictionary<T>(_ key: String, _ value: T) { associatedDictionary[key] = value }

    private func associatedValue<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
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