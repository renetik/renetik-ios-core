//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import RenetikObjc

public extension UIView {
    public func invoke(animated: Bool, duration: TimeInterval = 0.3, operation: @escaping () -> Void) {
        if animated { UIView.animate(withDuration: duration, animations: operation) } else { operation() }
    }

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    public func asBottomSeparator(_ height: CGFloat = 0.5) -> Self {
        self.height(height).from(bottom: 0).matchParentWidth()
                .flexibleTop().fixedBottom().background(UIColor.darkGray)
    }

    @discardableResult
    @objc public func onClick(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        onTap { _ in block() }
        return self
    }

}