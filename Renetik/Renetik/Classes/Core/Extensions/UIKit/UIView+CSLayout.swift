//
// Created by Rene Dohan on 12/23/19.
//

import Foundation
import UIKit
import RenetikObjc

public extension UIView {
    @discardableResult
    func from(left: CGFloat) -> Self {
        self.left = left;
        fixedLeft()
        return self
    }

    @discardableResult
    func fromPrevious(left: CGFloat) -> Self {
        superview?.subviews.previous(of: self).notNil { previous in
            from(left: previous.right + left)
        }.elseDo {
            fatalError("View expected to have previous sibling in superview")
        }
        return self
    }

    @discardableResult
    func from(top: CGFloat) -> Self {
        self.top = top;
        fixedTop()
        return self
    }

    @discardableResult
    func fromPrevious(top: CGFloat) -> Self {
        superview?.subviews.previous(of: self).notNil { previous in
            from(top: previous.bottom + top)
        }.elseDo {
            fatalError("View expected to have previous sibling in superview")
        }
        return self
    }

    @discardableResult
    func from(right: CGFloat) -> Self {
        self.fromRight = right;
        fixedRight()
        return self
    }

    @discardableResult
    func from(bottom: CGFloat) -> Self {
        self.fromBottom = bottom;
        fixedBottom()
        return self
    }

    @discardableResult
    func from(left: CGFloat, top: CGFloat) -> Self {
        from(left: left)
        from(top: top)
        return self
    }

    @discardableResult
    func from(left: CGFloat, bottom: CGFloat) -> Self {
        from(left: left)
        from(bottom: bottom)
        return self
    }

    @discardableResult
    func from(right: CGFloat, top: CGFloat) -> Self {
        from(right: right)
        from(top: top)
        return self
    }

    @discardableResult
    func from(left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> Self {
        from(left: left, top: top)
        self.width(width, height: height)
        return self
    }

//    @discardableResult
//    func matchParentWidth(fromRight: CGFloat) -> Self {
//        fixedLeft()
//        width(fromRight: fromRight)
//        flexibleWidth()
//        return self
//    }
//
//    @discardableResult
//    func matchParentHeight(fromBottom: CGFloat) -> Self {
//        fixedTop()
//        height(fromBottom: fromBottom)
//        flexibleHeight()
//        return self
//    }

    @discardableResult
    func matchParentWidth(margin: CGFloat = 0) -> Self {
        from(left: margin).width(fromRight: margin).flexibleWidth()
    }

    @discardableResult
    func matchParentHeight(margin: CGFloat = 0) -> Self {
        from(top: margin).height(fromBottom: margin).flexibleHeight()
    }

    @discardableResult
    func matchParent(margin: CGFloat = 0) -> Self {
        matchParentWidth(margin: margin).matchParentHeight(margin: margin)
    }

    @discardableResult
    func matchParent(horizontalMargin: CGFloat = 0, verticalMargin: CGFloat = 0) -> Self {
        matchParentWidth(margin: horizontalMargin).matchParentHeight(margin: verticalMargin)
    }

}