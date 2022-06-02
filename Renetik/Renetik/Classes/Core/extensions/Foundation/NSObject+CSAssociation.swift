//
// Created by Rene Dohan on 1/31/20.
//

import Foundation

private let dictionaryAssociation = CSObjectAssociation<NSMutableDictionary>()
private let weakDictionaryAssociation = CSObjectAssociation<NSMapTable<NSString, AnyObject>>()

public extension NSObject {

    var associatedDictionary: NSMutableDictionary {
        dictionaryAssociation.value(self, onCreate: { NSMutableDictionary() })
    }

    func associated<T>(_ key: String) -> T? { associatedDictionary[key] as? T }

    @discardableResult
    func associate<T>(_ key: String, _ value: T?) -> T? {
        associatedDictionary[key] = value
        return value
    }

    func associated<T>(_ key: String, onCreate: () -> T) -> T {
        associated(key) ?? associate(key, onCreate())!
    }

    var associatedWeakDictionary: NSMapTable<NSString, AnyObject> {
        weakDictionaryAssociation.value(self, onCreate: {
            NSMapTable<NSString, AnyObject>(keyOptions: .strongMemory, valueOptions: .weakMemory)
        })
    }

    func weakAssociated<T: AnyObject>(_ key: String) -> T? {
        associatedWeakDictionary.object(forKey: key.asNSString) as? T
    }

    @discardableResult
    func weakAssociate<T: AnyObject>(_ key: String, _ value: T?) -> T? {
        associatedWeakDictionary.setObject(value, forKey: key.asNSString)
        return value
    }

    func associatedWeakDictionary<T: AnyObject>(_ key: String, onCreate: () -> T) -> T {
        weakAssociated(key) ?? weakAssociate(key, onCreate())!
    }
}