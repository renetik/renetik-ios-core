//
// Created by Rene Dohan on 12/22/19.
//

import Foundation

public extension NotificationCenter {
    public class func add(observer: NSNotification.Name?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(forName: observer, object: nil, queue: nil, using: block)
    }

    public class func remove(observer: NSObjectProtocol?) { NotificationCenter.default.removeObserver(observer) }
}