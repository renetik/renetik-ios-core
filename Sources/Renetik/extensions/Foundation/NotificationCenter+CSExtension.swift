//
// Created by Rene Dohan on 12/22/19.
//

import Foundation

public extension NotificationCenter {
    @discardableResult
    class func add(observer: NSNotification.Name?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(forName: observer, object: nil, queue: nil, using: block)
    }

    class func remove(observer: NSObjectProtocol?) {
        if let observer = observer { NotificationCenter.default.removeObserver(observer) }
    }
}