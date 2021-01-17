//
// Created by Rene Dohan on 12/23/19.
//

import Foundation
import UIKit
import RenetikObjc

public extension UIView {

    @discardableResult
    func margin(horizontal margin: (left: CGFloat, right: CGFloat)) -> Self {
        from(left: margin.left).margin(right: margin.right)
    }

    @discardableResult
    func margin(horizontal margin: CGFloat) -> Self {
        from(left: margin).margin(right: margin)
    }

    func margin(vertical margin: (top: CGFloat, bottom: CGFloat)) -> Self {
        from(top: margin.top).margin(bottom: margin.bottom)
    }

    func margin(vertical margin: CGFloat) -> Self {
        from(top: margin).margin(bottom: margin)
    }

    @discardableResult
    func margin(left margin: CGFloat, flexible: Bool = false) -> Self {
        width = (right - margin).asUnsigned
        if flexible { fixedRight().flexibleWidth() }
        from(left: margin)
        return self
    }

    @discardableResult
    func margin(from: UIView, left: CGFloat, flexible: Bool = false) -> Self {
        self.margin(left: from.right + left, flexible: flexible)
    }

    @discardableResult
    func margin(top margin: CGFloat, flexible: Bool = false) -> Self {
        assert(superview.notNil, "Needs to have superview")
        let bottomCorrected = bottom - margin > 0 ? bottom : superview!.height
        height = (bottomCorrected - margin).asUnsigned
        from(top: margin)
        if flexible { fixedBottom().flexibleHeight() }
        return self
    }

    @discardableResult
    func margin(bottom: CGFloat, flexible: Bool = false) -> Self {
        assert(superview.notNil, "Needs to have superview")
        let bottom = superview!.height - bottom
        heightBy(bottom: bottom.asUnsigned)
        if flexible { fixedTop().flexibleHeight() }
        return self
    }

    @discardableResult
    func margin(bottom: CGFloat, from view: UIView, flexible: Bool = false) -> Self {
        margin(bottom: view.topFromBottom + bottom, flexible: flexible)
    }

    @discardableResult
    func fill(to view: UIView, bottom: CGFloat, flexible: Bool = true) -> Self {
        self.margin(bottom: bottom, from: view, flexible: flexible)
    }

    @discardableResult
    func fillToPrevious(bottom: CGFloat, flexible: Bool = true) -> Self {
        assert(superview.notNil, "Needs to have superview")
        return superview!.findPrevious(of: self)?.get {
            self.margin(bottom: bottom, from: $0, flexible: flexible)
        } ?? self.margin(bottom: bottom, flexible: flexible)
    }

    @discardableResult
    func margin(top: CGFloat, bottom: CGFloat, flexible: Bool = false) -> Self {
        margin(top: top, flexible: flexible).margin(bottom: bottom, flexible: flexible)
    }

    @discardableResult
    func margin(right: CGFloat, flexible: Bool = false) -> Self {
        assert(superview.notNil, "Needs to have superview")
        let right = superview!.width - right
        widthBy(right: right.asUnsigned)
        if flexible { fixedLeft().flexibleWidth() }
        return self
    }

    @discardableResult
    func margin(right: CGFloat, from view: UIView, flexible: Bool = false) -> Self {
        margin(right: view.leftFromRight + right, flexible: flexible)
    }
}