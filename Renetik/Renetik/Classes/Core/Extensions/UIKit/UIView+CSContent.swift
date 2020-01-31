//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    class func withContent(_ view: UIView = UIView.construct()) -> Self {
        let container = self.withFrame(view.frame)
        container.content(view).matchParent()
        return container
    }

    class func wrap(view: UIView) -> Self {
        let container = self.withFrame(view.frame)
        let center = view.center
        let superview = view.superview
        let autoSize = view.autoresizingMask
        container.content(view).matchParent()
        superview?.add(container).center(center).autoresizingMask = autoSize
        container.backgroundColor = view.backgroundColor
        view.backgroundColor = UIColor.clear
        return container
    }

    class func wrap(view: UIView, padding: CGFloat) -> Self {
        let container = self.withSize(view.width + padding * 2, view.height + padding * 2)
        let center = view.center
        let superview = view.superview
        let autoSize = view.autoresizingMask
        container.content(view).matchParent(margin: padding)
        superview?.add(container).center(center).autoresizingMask = autoSize
        container.backgroundColor = view.backgroundColor
        view.backgroundColor = UIColor.clear
        return container
    }

    func contentVertical(padding: CGFloat) -> Self {
        content!.from(top: padding).height(fromBottom: padding).flexibleWidth()
        return self
    }

    func contentHorizontal(padding: CGFloat) -> Self {
        content!.from(left: padding).width(fromRight: padding).flexibleHeight()
        return self
    }

    func content(padding: CGFloat) -> Self {
        contentHorizontal(padding: padding)
        contentVertical(padding: padding)
        return self
    }
}