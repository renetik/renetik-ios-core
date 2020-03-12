//
// Created by Rene Dohan on 2/21/20.
//

import UIKit

public extension UIEdgeInsets {

    var horizontalSize: CGFloat { left + right }

    var horizontal: (left: CGFloat, right: CGFloat) { (left: left, right: right) }

    var verticalSize: CGFloat { top + bottom }

    var vertical: (top: CGFloat, bottom: CGFloat) { (top: top, bottom: bottom) }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(_ inset: CGFloat) { self.init(horizontal: inset, vertical: inset) }
}