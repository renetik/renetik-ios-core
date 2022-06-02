//
//  UIScrollView+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

public extension UIScrollView {

    class func construct(verticalContent: Bool) -> Self {
        verticalContent ? Self.construct(defaultSize: true).also {
            $0.content(vertical: CSView.construct())
        } : Self.construct()
    }

    class func construct(horizontalContent: Bool) -> Self {
        horizontalContent ? Self.construct(defaultSize: true).also {
            $0.content(horizontal: CSView.construct())
        } : Self.construct()
    }

    @discardableResult
    func content<View: UIView>(horizontal view: View) -> View {
        content(view).matchParentHeight().from(left: 0)
        contentWidthByLastContentSubview()
        return view
    }

    @discardableResult
    func content<View: UIView>(vertical view: View) -> View {
        content(view).matchParentWidth().from(top: 0)
        contentHeightByLastVisibleSubview()
        return view
    }

    @discardableResult
    func contentWidthByLastContentSubview(padding: CGFloat = 0) -> Self {
        content(width: (content!.subviews.last?.right ?? 0) + padding)
    }

    @discardableResult
    func content(width: CGFloat) -> Self {
        content!.width = width
        if content!.width < self.width {
            content!.width = self.width
            isScrollEnabled = false
        } else {
            contentSize(width: content!.right)
            isScrollEnabled = true
        }
        return self
    }

    @discardableResult
    func contentSize(width: CGFloat) -> Self {
        contentSize = CGSize(width: width, height: contentSize.height)
        return self
    }

    @discardableResult
    func contentHeightByLastVisibleSubview(padding: CGFloat = 0) -> Self {
        content(height: (content!.lastVisibleSubview?.bottom ?? 0) + padding)
    }

    @discardableResult
    func content(height: CGFloat) -> Self {
        content!.height = height
//TODO: Was Needed For What? bouncing? not needed?
//        if content!.height <= self.height {
//            content!.height = self.height
//            isScrollEnabled = false
//        } else {
//            isScrollEnabled = true
//        }
        contentSize(height: content!.bottom)
        return self
    }

    @discardableResult
    func contentSize(height: CGFloat) -> Self {
        contentSize = CGSize(width: contentSize.width, height: height)
        return self
    }

    @discardableResult
    func contentOffset(top: CGFloat, animated: Bool = true) -> Self {
        invoke(animated: animated) {
            self.contentOffset = CGPoint(left: self.contentOffset.left, top: top)
        }
        return self
    }

    @discardableResult
    func contentOffset(left: CGFloat, animated: Bool = true) -> Self {
        invoke(animated: animated) {
            self.contentOffset = CGPoint(left: left, top: self.contentOffset.top)
        }
        return self
    }

    @discardableResult
    func content(inset: UIEdgeInsets) -> Self { contentInset = inset; return self }

    func scrollable(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    var isAtTop: Bool { contentOffset.y <= verticalOffsetForTop }

    var isAtBottom: Bool {
//        let bottomEdge = contentOffset.y + height
//        return bottomEdge >= contentSize.height
        contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset.rounded()
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
}

public extension CSHasLayoutProtocol where Self: UIScrollView {

    @discardableResult
    func layout<View: UIView>(footer view: View, margin: CGFloat, function: @escaping ArgFunc<View>) -> View {
        layout { [unowned self] in
            function(view)
            if view.bottom < safeHeight {
                view.flexibleTop().from(safeBottom: 0) //navigation.navigationBar.bottom
            } else {
                contentSize(height: view.bottom)
            }
        }
        return view
    }

    @discardableResult
    func layout<View: UIView>(footer view: View, margin: CGFloat) -> View {
        layout(footer: view, margin: margin) { $0.fromPrevious(top: margin).heightToFit() }
    }
}