//
// Created by Rene Dohan on 1/31/20.
//

import Foundation
import RenetikObjc

private var associatedPropertyValuesKey: Void?

public extension NSObject {

    var values: NSMutableDictionary {
        getObject(&associatedPropertyValuesKey) { NSMutableDictionary() }
    }

    func getObject<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
        var object: T? = getObject(key) as? T
        if object == nil {
            object = onCreate()
            setObject(key, object)
        }
        return object!
    }

    func getWeakObject<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
        var object: T? = getObject(key) as? T
        if object == nil {
            object = onCreate()
            setWeakObject(key, object)
        }
        return object!
    }

    func getObject(_ key: UnsafeRawPointer!) -> Any? {
        bk_associatedValue(forKey: key)
    }

    func setObject(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
        bk_associateValue(value, withKey: key)
        return self
    }

    func setWeakObject(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
        bk_weaklyAssociateValue(value, withKey: key)
        return self
    }

}