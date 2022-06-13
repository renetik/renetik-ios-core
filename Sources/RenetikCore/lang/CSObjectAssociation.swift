//
// Created by Rene Dohan on 01/06/22.
//

import Foundation

open class CSObjectAssociation<T> {
    private let policy: objc_AssociationPolicy

    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }

    public subscript(source: AnyObject) -> T? {
        get { objc_getAssociatedObject(source, Unmanaged.passUnretained(self).toOpaque()) as? T }
        set { objc_setAssociatedObject(source, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}

extension CSObjectAssociation {
    func value(_ parent: NSObjectProtocol, onCreate: () -> T) -> T {
        let value = self[parent]
        if value == nil {
            let dictionary = onCreate()
            self[parent] = dictionary
            return dictionary
        }
        else {
            return value!
        }
    }

    func value(weak parent: NSObjectProtocol, onCreate: () -> T) -> T {
        let value = self[parent]
        if value == nil {
            let dictionary = onCreate()
            self[parent] = dictionary
            return dictionary
        }
        else {
            return value!
        }
    }
}
