//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    @discardableResult
    public func heightByLastSubview(padding: Int = 0) -> Self {
        let lastSubViewBottom = content?.subviews.last?.bottom ?? subviews.last?.bottom ?? 0
        height = lastSubViewBottom > 0 ? lastSubViewBottom + CGFloat(padding) : 0
        return self
    }
}
