//
// Created by Rene Dohan on 1/9/20.
//

import UIKit

extension UITraitCollection {
    @available(iOS 12.0, *)
    public var isDarkMode: Bool { userInterfaceStyle == .dark }
}