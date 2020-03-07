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
    func add<View: UIView>(_ view: View) -> View {
        addSubview(view)
        return view
    }

    @discardableResult
    func add(all views: UIView...) -> Self {
        views.forEach { view in add(view) }
        return self
    }

    @discardableResult
    func add(_ view: UIView, index: Int) -> UIView {
        insertSubview(view, at: index)
        return view
    }

    @discardableResult
    func set(_ view: UIView, index: Int) -> UIView {
        subviews.at(index)?.removeFromSuperview()
        return add(view, index: index)
    }

    func findPreviousVisible(of view: UIView) -> UIView? {
        if subviews.index(of: view).isNil {
            fatalError()
        }
        var index = subviews.index(of: view)! - 1
        while index >= 0 {
            let view = self.subviews[index]
            if view.isVisible { return view }
            index -= 1
        }
        return nil
    }

    func findLastSubviewOf(type someType: AnyClass) -> UIView? {
        var index = subviews.count - 1
        while index >= 0 {
            let subView = subviews[index]
            if type(of: subView) === someType { return subView }
            index -= 1
        }
        return nil
    }

    @discardableResult
    func clearSubviews() -> Self { invoke { subviews.each { $0.removeFromSuperview() } } }

    var isEmpty: Bool { subviews.isEmpty }

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
}
