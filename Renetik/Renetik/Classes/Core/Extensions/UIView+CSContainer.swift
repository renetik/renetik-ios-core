//
//  UIView+CSLayout.swift
//  CS-IOS
//
//  Created by Rene on 11/26/18.
//

import RenetikObjc

public extension UIView {
    @discardableResult
    public func add<T: UIView>(view: T, _ function: ((T) -> Void)? = nil) -> T {
        add(view)
        function?(view)
        return view
    }

    @discardableResult
    public func verticalLayout<T: UIView>(
            add view: T, margin: Int = 0, function: ((T) -> Void)? = nil) -> T {
        verticalLayoutAdd(view, margin: margin)
        function?(view)
        return view
    }

    @discardableResult
    public func verticalLine<T: UIView>(
            add view: T, margin: Int = 0, function: ((T) -> Void)? = nil) -> T {
        verticalLineAdd(view, margin: margin)
        function?(view)
        return view
    }

    @discardableResult
    public func horizontalLayout<T: UIView>(
            add view: T, margin: Int, columns: Int, function: ((T) -> Void)? = nil) -> T {
        horizontalLayoutAdd(view, margin: margin, columns: columns)
        function?(view)
        return view
    }

    @discardableResult
    public func horizontalLayout<T: UIView>(add view: T, function: ((T) -> Void)? = nil) -> T {
        horizontalLayoutAdd(view)
        function?(view)
        return view
    }

    @discardableResult
    public func horizontalLine<T: UIView>(
            add view: T, margin: Int = 0, function: ((T) -> Void)? = nil) -> T {
        horizontalLineAdd(view, margin: margin)
        function?(view)
        return view
    }
}
