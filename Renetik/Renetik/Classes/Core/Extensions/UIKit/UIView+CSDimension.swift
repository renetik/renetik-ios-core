//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    @discardableResult
    public func heightByLastSubview(padding: CGFloat = 0) -> Self {
        let lastSubViewBottom = content?.subviews.last?.bottom ?? subviews.last?.bottom ?? 0
        height = lastSubViewBottom > 0 ? lastSubViewBottom + padding : 0
        return self
    }

    @discardableResult
    func size(_ size: CGFloat) -> Self { width(size, height: size) }

}
