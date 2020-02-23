//
// Created by Rene Dohan on 2/21/20.
//

import UIKit

public extension UIEdgeInsets {

    var horizontal: CGFloat { left + right }

    var vertical: CGFloat { top + bottom }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(_ inset: CGFloat) { self.init(horizontal: inset, vertical: inset) }
}