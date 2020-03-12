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

//    class func vertical(content view: UIView) -> Self {
//        let instance: UIScrollView = Self.withSize(view.width, view.height)
//        instance.vertical(content: view)
//        return instance as! Self
//    }

//    class func horizontal(content view: UIView) -> Self {
//        let instance: UIScrollView = Self.withSize(view.width, view.height)
//        instance.horizontal(content: view)
//        return instance as! Self
//    }

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
    func content<View: UIView>(horizontal view: View) -> View {
        super.content(view).matchParentHeight().from(left: 0)
        contentSizeWidthByLastContentSubview()
        return view
    }

    @discardableResult
    public func content<View: UIView>(vertical view: View) -> View {
        super.content(view).matchParentWidth().from(top: 0)
        contentSizeHeightByLastContentSubview()
        return view
    }

    @discardableResult
    func contentSize(width: CGFloat) -> Self {
        contentSize = CGSize(width: width, height: contentSize.height)
        return self
    }

    @discardableResult
    func contentSize(height: CGFloat) -> Self {
        contentSize = CGSize(width: contentSize.width, height: height)
        return self
    }

    @discardableResult
    func contentSizeWidthByLastContentSubview(padding: CGFloat = 0) -> Self {
        content!.width = (content!.subviews.last?.right ?? 0) + padding
        if content!.width < width { content!.width = width }
        contentSize(width: content!.right)
        return self
    }

    @discardableResult
    func contentSizeHeightByLastContentSubview(padding: CGFloat = 0) -> Self {
        content!.height = (content!.subviews.last?.bottom ?? 0) + padding
        if content!.height < height { content!.height = height }
        contentSize(height: content!.bottom)
        return self
    }

    func scrollToTop() {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: true)
    }

    func scrollToBottom() {
        setContentOffset(CGPoint(x: contentOffset.x,
                y: contentSize.height - bounds.size.height - contentInset.bottom), animated: true)
    }

    func scrollTo(page index: Int, of count: Int, animated: Bool = true) {
        let pageWidth = contentSize.width / CGFloat(count)
        let x = CGFloat(index) * pageWidth
        setContentOffset(CGPoint(x: x, y: 0), animated: animated)
    }

    func currentPageIndex(from: Int) -> Int {
        lround(Double(contentOffset.x / (contentSize.width / CGFloat(from))))
    }

    override func content(_ view: UIView) -> UIView {
        super.content(view)
        contentSize = view.size
        return view
    }
}
