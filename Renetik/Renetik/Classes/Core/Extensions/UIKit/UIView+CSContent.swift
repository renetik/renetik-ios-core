//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc
import BlocksKit

//private var viewContentPropertyKey: UInt8 = 0
private var viewContentPropertyKey: Void?

public extension UIView {

    var content: UIView? {
        get { associatedValue(&viewContentPropertyKey) as? UIView }
        set(view) {
            content?.removeFromSuperview()
            weaklyAssociateValue(&viewContentPropertyKey, view)
            view.notNil { addSubview($0) }
        }
    }

    func content<View: UIView>(_ view: View) -> View { content = view; return view }

    class func withContent(_ view: UIView = CSView.construct()) -> Self {
        let container = self.construct(frame: view.frame)
        container.content(view).matchParent()
        return container
    }

    class func wrap(view: UIView) -> Self {
        let container = self.construct(frame: view.frame)
        let center = view.center
        let superview = view.superview
        let autoSize = view.autoresizingMask
        container.content(view).matchParent()
        superview?.add(view: container).center(center).autoresizingMask = autoSize
        container.backgroundColor = view.backgroundColor
        view.backgroundColor = UIColor.clear
        return container
    }

    class func wrap(view: UIView, padding: CGFloat) -> Self {
        let container = self.construct(width: view.width + padding * 2,
                height: view.height + padding * 2)
        let center = view.center
        let superview = view.superview
        let autoSize = view.autoresizingMask
        container.content(view).matchParent(margin: padding)
        superview?.add(view: container).center(center).autoresizingMask = autoSize
        container.backgroundColor = view.backgroundColor
        view.backgroundColor = UIColor.clear
        return container
    }

    @discardableResult
    func withContent(_ view: UIView = CSView.construct()) -> Self {
        content(view).matchParent()
        return self
    }

    @discardableResult
    func contentVertical(padding: CGFloat) -> Self {
        let mask = content!.autoresizingMask
        content!.autoresizingMask = []
        height = content!.height + 2 * padding
        content!.centeredVertical()
        content!.autoresizingMask = mask
        return self
    }

    @discardableResult
    func contentHorizontal(padding: CGFloat) -> Self {
        let mask = content!.autoresizingMask
        content!.autoresizingMask = []
        width = content!.width + 2 * padding
        content!.centeredHorizontal()
        content!.autoresizingMask = mask
        return self
    }

    @discardableResult
    func content(padding: CGFloat) -> Self {
        contentHorizontal(padding: padding)
        contentVertical(padding: padding)
        return self
    }

    @discardableResult
    func content(padding: (horizontal: CGFloat, vertical: CGFloat)) -> Self {
        contentHorizontal(padding: padding.horizontal)
        contentVertical(padding: padding.vertical)
        return self
    }
}