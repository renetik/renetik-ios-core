//
// Created by Rene Dohan on 1/31/20.
//

import Foundation

//import RenetikBlocksKit

private let associatedDictionaryAccessor = CSAssociatedObject<NSMutableDictionary>()
private let associatedWeakDictionaryAccessor = CSAssociatedObject<NSMapTable<NSString, AnyObject>>()

//private var associatedPropertyValuesKey: Void?

public extension NSObject {

    var associatedDictionary: NSMutableDictionary {
        associatedDictionaryAccessor.value(self, onCreate: { NSMutableDictionary() })
//        associatedValue(&associatedPropertyValuesKey) { NSMutableDictionary() }
    }

    func associatedDictionary<T>(_ key: String) -> T? { associatedDictionary[key] as? T }
    func associatedDictionary<T>(_ key: String, _ value: T) { associatedDictionary[key] = value }

    func associated<T>(_ key: String, onCreate: () -> T) -> T {
        var object: T? = associatedDictionary[key] as? T
        if object == nil {
            object = onCreate()
            associatedDictionary(key, object!)
        }
        return object!
    }

    var associatedWeakDictionary: NSMapTable<NSString, AnyObject> {
        associatedWeakDictionaryAccessor.value(self, onCreate: {
            NSMapTable<NSString, AnyObject>(keyOptions: .strongMemory, valueOptions: .weakMemory)
        })
//        associatedValue(&associatedPropertyValuesKey) { NSMutableDictionary() }
    }

    func associatedWeakDictionary<T: AnyObject>(_ key: String, onCreate: () -> T) -> T {
        var object: T? = weaklyAssociatedValue(key)
        if object == nil {
            object = onCreate()
            weaklyAssociateValue(key, object!)
        }
        return object!
    }

    func weaklyAssociatedValue<T: AnyObject>(_ key: String) -> T? {
        associatedWeakDictionary.object(forKey: key.asNSString) as? T
    }

    func weaklyAssociateValue<T: AnyObject>(_ key: String, _ value: T?) {
        associatedWeakDictionary.setObject(value, forKey: key.asNSString)
    }

//    private func associatedValue<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
//        var object: T? = associatedValue(key) as? T
//        if object == nil {
//            object = onCreate()
//            associateValue(key, object)
//        }
//        return object!

//    func weaklyAssociatedValue<T: NSObject>(_ key: UnsafeRawPointer!, onCreate: () -> T) -> T {
//        var object: T? = associatedValue(key) as? T
//        if object == nil {
//            object = onCreate()
//            weaklyAssociateValue(key, object)
//        }
//        return object!
//    }

//    func associatedValue(_ key: UnsafeRawPointer!) -> Any? {
//        bk_associatedValue(forKey: key)
//    }

//    func associateValue(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
//        bk_associateValue(value, withKey: key)
//        return self
//    }

//    func weaklyAssociateValue(_ key: UnsafeRawPointer!, _ value: Any?) -> Self {
//        bk_weaklyAssociateValue(value, withKey: key)
//        return self
//    }

}