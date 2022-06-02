//
// Created by Rene Dohan on 2/12/20.
//

import UIKit

public extension UIApplicationDelegate {
    static var instance: Self { UIApplication.shared.delegate as! Self }
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}