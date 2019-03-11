//
//  UIView+CSLayout.swift
//  CS-IOS
//
//  Created by Rene on 11/26/18.
//

import RenetikObjc

public extension UIView {
    @discardableResult
    public func add<T: UIView>(view subView: T) -> T {
        add(subView)
        return subView
    }

    @discardableResult
    public func add<T: UIView>(view subView: T, _ function: (T) -> Void) -> T {
        add(subView)
        function(subView)
        return subView
    }

    @discardableResult
    public func addUnderLast<T: UIView>(view subView: T, offset: CGFloat) -> T {
        addUnderLast(subView)
        if subView.top > 0 { subView.top += offset }
        return subView
    }

    @discardableResult
    public func addNextLast<T: UIView>(view subView: T, offset: CGFloat) -> T {
        addNextLast(subView)
        if subView.left > 0 { subView.left += offset }
        return subView
    }
}
