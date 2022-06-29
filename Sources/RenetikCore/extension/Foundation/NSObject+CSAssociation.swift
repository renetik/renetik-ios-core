import Foundation

private let dictionaryAssociation = CSObjectAssociation<NSMutableDictionary>()
private let weakDictionaryAssociation = CSObjectAssociation<CSWeakValueDictionary<NSString, AnyObject>>()

public extension NSObjectProtocol {

    var associatedDictionary: NSMutableDictionary {
        dictionaryAssociation.value(self, onCreate: { NSMutableDictionary() })
    }

    func associated<T>(key: String) -> T? { associatedDictionary[key] as? T }

    @discardableResult
    func associate<T>(_ key: String, _ value: T?) -> T? {
        associatedDictionary[key] = value
        return value
    }

    func associated<T>(_ key: String, onCreate: () -> T) -> T {
        associated(key: key) ?? associate(key, onCreate())!
    }

    var associatedWeakDictionary: CSWeakValueDictionary<NSString, AnyObject> {
        weakDictionaryAssociation.value(self, onCreate: {
            CSWeakValueDictionary<NSString, AnyObject>()
        })
    }

    func weakAssociated<T: AnyObject>(_ key: String) -> T? {
        associatedWeakDictionary[key.asNSString] as? T
    }

    @discardableResult
    func weakAssociate<T: AnyObject>(_ key: String, _ value: T?) -> T? {
        associatedWeakDictionary[key.asNSString] = value
        return value
    }
}
