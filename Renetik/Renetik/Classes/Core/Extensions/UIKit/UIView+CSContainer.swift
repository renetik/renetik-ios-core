//
//  Created by Rene on 11/26/18.
//

import UIKit
import RenetikObjc

public extension UIView {
    @discardableResult
    func add<View: UIView>(view: View) -> View {
        addSubview(view)
        return view
    }

    @discardableResult
    func add(_ view: UIView) -> UIView {
        addSubview(view)
        return view
    }

    @discardableResult
    func add(_ views: UIView...) -> Self {
        views.forEach { view in add(view) }
        return self
    }

    @discardableResult
    public func horizontalLine<View: UIView>(add view: View, margin: CGFloat = 0) -> View {
        horizontalLine(update: add(view: view), margin: margin)
    }

    @discardableResult
    func horizontalLine<View: UIView>(update view: View, margin: CGFloat = 0) -> View {
        horizontalLine(update: subviews.index(of: view)!, view: view, margin: margin)
    }

    @discardableResult
    func horizontalLine<View: UIView>(update position: Int, view: View, margin: CGFloat = 0) -> View {
        view.from(left: subviews.at(position - 1)?.right ?? 0)
        if view.left != 0 { view.left += margin }
        return view
    }

    @discardableResult
    func verticalLine<View: UIView>(add view: View, margin: CGFloat = 0) -> View {
        verticalLine(update: add(view: view), margin: margin)
    }

    @discardableResult
    func verticalLine<View: UIView>(update view: View, margin: CGFloat = 0) -> View {
        verticalLine(update: subviews.index(of: view)!, view: view, margin: margin)
    }

    @discardableResult
    func verticalLine<View: UIView>(update position: Int, view: View, margin: CGFloat = 0) -> View {
        view.from(top: subviews.at(position - 1)?.bottom ?? 0)
        if view.top != 0 { view.top += margin }
        return view
    }

    @discardableResult
    func horizontalLayout<View: UIView>(add view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        horizontalLayout(update: add(view: view), margin: margin, columns: columns)
    }

    @discardableResult
    func horizontalLayout<View: UIView>(update view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
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
    func verticalLayout<View: UIView>(add view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        verticalLayout(update: add(view: view), margin: margin, columns: columns)
    }

    @discardableResult
    func verticalLayout<View: UIView>(update view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
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

    func addBottomSeparator(_ height: CGFloat = 0.5) -> UIView {
        add(view: UIView.construct()).asBottomSeparator(height)
    }
}
