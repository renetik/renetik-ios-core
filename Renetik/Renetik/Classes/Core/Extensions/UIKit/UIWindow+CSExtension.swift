//
// Created by Rene Dohan on 3/12/20.
//

import Foundation

public extension UIWindow {

    class var window: UIWindow { delegate.window! }
    class var safeWidth: CGFloat { window.width - (window.safeAreaInsets.left + window.safeAreaInsets.right) }
    class var safeHeight: CGFloat { window.height - (window.safeAreaInsets.top + window.safeAreaInsets.bottom) }
}