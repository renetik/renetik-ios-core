//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit

extension UIView: CSHasVisibilityProtocol {
    public var eventVisibilityChange: CSEvent<Bool> {
        associated("UIView+eventVisibilityChange") { event() }
    }
    public var isVisible: Bool {
        get { !isHidden }
        set(value) { isHidden = !value; eventVisibilityChange.fire(value); }
    }
}

public extension UIView {

    @discardableResult
    func shown(if condition: Bool) -> Self {
        if condition { show() }
        else { hide() }
        return self
    }

    @discardableResult
    func hidden(if condition: Bool) -> Self {
        if condition { hide() }
        else { show() }
        return self
    }

    @discardableResult
    @objc func show() -> Self {
        isVisible = true
        navigation.topViewController?.view.setNeedsLayout()
        superview?.setNeedsLayout()
        return self
    }

    @discardableResult
    @objc func hide() -> Self {
        isVisible = false
        navigation.topViewController?.view.setNeedsLayout()
        superview?.setNeedsLayout()
        return self
    }

    var isVisibleThroughHierarchy: Bool {
        var view: UIView? = self
        repeat {
            if view!.isHidden { return false }
            view = view?.superview
        } while view.notNil
        return true
    }

    var isHiddenThroughHierarchy: Bool { !isVisibleThroughHierarchy }

}