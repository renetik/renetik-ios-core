//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import RenetikObjc
import BlocksKit

extension UIView: CSVisibilityProtocol {
    public var eventVisibilityChange: CSEvent<Bool> {
        associatedDictionary("UIView+eventVisibilityChange") { event() }
    }
    public var isVisible: Bool {
        get { !isHidden }
        set(value) { isHidden = !value; eventVisibilityChange.fire(value); }
    }
}

public extension UIView {
    @discardableResult
    func visible(if condition: Bool) -> Self {
        isVisible = condition
        superview?.layoutSubviews()
        return self
    }

    @discardableResult
    func shown(if condition: Bool) -> Self {
        isVisible = condition
        superview?.layoutSubviews()
        return self
    }

    @discardableResult
    func hidden(if condition: Bool) -> Self {
        isVisible = !condition
        superview?.layoutSubviews()
        return self
    }

    @discardableResult
    func show() -> Self {
        isVisible = true
        superview?.layoutSubviews()
        return self
    }

    @discardableResult
    func hide() -> Self {
        isVisible = false
        superview?.layoutSubviews()
        return self
    }
}