//
//  UIScrollView+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit
import RenetikObjc

public extension UIScrollView {

    static let scrollStateInaccuracy: CGFloat = 15

    class func vertical(content view: UIView) -> Self {
        let instance: UIScrollView = Self.withSize(view.width, view.height)
        instance.vertical(content: view)
        return instance as! Self
    }

    class func horizontal(content view: UIView) -> Self {
        let instance: UIScrollView = Self.withSize(view.width, view.height)
        instance.horizontal(content: view)
        return instance as! Self
    }

    public func scrollable(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    public var isAtTop: Bool { contentOffset.y <= verticalOffsetForTop }

    public var isAtBottom: Bool {
//        let bottomEdge = contentOffset.y + height
//        return bottomEdge >= contentSize.height
        contentOffset.y >= verticalOffsetForBottom
    }

    public var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    public var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset.rounded()
    }

    @discardableResult
    public func vertical<View: UIView>(content view: View) -> View {
        super.content(view).matchParentWidth().from(top: 0)
        contentSizeHeightByLastContentSubview()
        return view
    }

    func horizontal<View: UIView>(content view: View) -> View {
        super.content(view).matchParentHeight().from(left: 0)
        contentSizeWidthByLastContentSubview()
        return view
    }
}
