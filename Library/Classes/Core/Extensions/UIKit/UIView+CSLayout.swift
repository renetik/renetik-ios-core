//
//  UIView+CSLayout.swift
//  CS-IOS
//
//  Created by Rene on 11/26/18.
//

import UIKit

public extension UIView {
    public func add<T: UIView>(view subView: T) -> T {
        self.add(subView)
        return subView
    }

    public func addUnderLast<T: UIView>(view subView: T, offset: Int) -> T {
        addUnderLast(subView)
        if subView.top > 0 { subView.addTop(offset) }
        return subView
    }

    public func addNextLast<T: UIView>(view subView: T, offset: Int) -> T {
        addNextLast(subView)
        if subView.left > 0 { subView.addLeft(offset) }
        return subView
    }
}
