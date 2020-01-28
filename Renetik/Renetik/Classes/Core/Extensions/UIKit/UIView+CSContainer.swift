//
//  Created by Rene on 11/26/18.
//

import UIKit
import RenetikObjc

public extension UIView {
    @discardableResult
    public func add<View: UIView>(view: View) -> View {
        addSubview(view)
        return view
    }

    @discardableResult
    public func add(_ view: UIView) -> UIView {
        addSubview(view)
        return view
    }

    @discardableResult
    public func add(_ views: UIView...) -> Self {
        views.forEach { view in add(view) }
        return self
    }

    @discardableResult
    public func horizontalLine<View: UIView>(add view: View, margin: CGFloat = 0) -> View {
        horizontalLine(update: add(view: view), margin: margin)
    }

    @discardableResult
    public func horizontalLine<View: UIView>(update view: View, margin: CGFloat = 0) -> View {
        horizontalLine(update: subviews.index(of: view)!, view: view, margin: margin)
    }

    @discardableResult
    public func horizontalLine<View: UIView>(update position: Int, view: View, margin: CGFloat = 0) -> View {
        view.from(left: subviews.at(position - 1)?.right ?? 0)
        if view.left != 0 { view.left += margin }
        return view
    }

    @discardableResult
    public func verticalLine<View: UIView>(add view: View, margin: CGFloat = 0) -> View {
        verticalLine(update: add(view: view), margin: margin)
    }

    @discardableResult
    public func verticalLine<View: UIView>(update view: View, margin: CGFloat = 0) -> View {
        verticalLine(update: subviews.index(of: view)!, view: view, margin: margin)
    }

    @discardableResult
    public func verticalLine<View: UIView>(update position: Int, view: View, margin: CGFloat = 0) -> View {
        view.from(top: subviews.at(position - 1)?.bottom ?? 0)
        if view.top != 0 { view.top += margin }
        return view
    }

    @discardableResult
    public func horizontalLayout<View: UIView>(add view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        horizontalLayout(update: add(view: view), margin: margin, columns: columns)
    }

    @discardableResult
    public func horizontalLayout<View: UIView>(update view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        view.width = (self.width - (margin * (CGFloat(columns) + 1))) / CGFloat(columns);
        subviews.previous(of: view).notNil { previous in
            if previous.right + margin + view.width + margin <= width {
                view.from(left: previous.right + margin, top: previous.top + margin)
            } else {
                view.from(left: margin, top: previous.bottom + margin)
            }
        }.elseDo { view.from(left: margin, top: margin) }
        return view
    }

    @discardableResult
    public func verticalLayout<View: UIView>(add view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        verticalLayout(update: add(view: view), margin: margin, columns: columns)
    }

    @discardableResult
    public func verticalLayout<View: UIView>(update view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        view.height = (self.height - (margin * (CGFloat(columns) + 1))) / CGFloat(columns);
        subviews.previous(of: view).notNil { previous in
            if previous.bottom + margin + view.height + margin <= height {
                view.from(left: previous.left + margin, top: previous.bottom + margin)
            } else {
                view.from(left: previous.right + margin, top: margin)
            }
        }.elseDo { view.from(left: margin, top: margin) }
        return view
    }

    public func addBottomSeparator(_ height: CGFloat = 0.5) -> UIView {
        add(view: UIView.construct()).asBottomSeparator(height)
    }

    @discardableResult
    public func heightByLastSubview(padding: Int = 0) -> Self {
        let lastSubViewBottom = content?.subviews.last?.bottom ?? subviews.last?.bottom ?? 0
        height = lastSubViewBottom > 0 ? lastSubViewBottom + CGFloat(padding) : 0
        return self
    }

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

}
