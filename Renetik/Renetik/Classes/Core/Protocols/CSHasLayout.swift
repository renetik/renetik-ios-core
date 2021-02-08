//
// Created by Rene Dohan on 2/19/20.
//

import Foundation

public protocol CSHasLayoutProtocol {
    func updateLayout() -> Self
    @discardableResult
    func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) -> View
}

public protocol CSLayoutItemProtocol {
    var isVisibleToLayout: Bool { get }
}

public extension CSHasLayoutProtocol where Self: UIView {
    static func wrap(fixed leftView: UIView, margin: CGFloat = 0, sizedToFit rightView: UIView) -> Self {
        Self.construct().also { container in
            container.layout(container.add(view: leftView).from(left: 0)) {
                $0.centeredVertical()
            }
            container.layout(container.add(view: rightView).fromPrevious(left: margin)) {
                $0.resizeToFit().centeredVertical()
            }
        }.resizeToFit()
    }

    func wrap(fixed leftView: UIView, margin: CGFloat = 0, sizedToFit rightView: UIView) -> UIView {
        CSView.wrap(fixed: leftView, margin: margin, sizedToFit: rightView)
    }

    static func wrap(flexible leftView: UIView, margin: CGFloat = 0, flexible rightView: UIView) -> Self {
        Self.construct().also { container in
            container.layout(container.add(view: leftView).from(left: 0)) {
                $0.width((container.width - margin) / 2).heightToFit()
            }
            container.layout(container.add(view: rightView)) {
                $0.fromPrevious(left: margin).width((container.width - margin) / 2).heightToFit()
            }
        }
    }

    func wrap(flexible leftView: UIView, margin: CGFloat = 0, flexible rightView: UIView) -> CSView {
        CSView.wrap(flexible: leftView, margin: margin, flexible: rightView)
    }

    static func wrap(flexible leftView: UIView, margin: CGFloat = 0, fixed rightView: UIView) -> Self {
        Self.construct().also { container in
            container.add(view: rightView).from(right: 0).centeredVertical()
            container.layout(container.add(view: leftView).from(left: 0).fill(to: rightView, right: margin)) {
                $0.heightToFit().centeredVertical()
            }
        }.resizeToFit()
    }

    func wrap(flexible leftView: UIView, margin: CGFloat = 0, fixed rightView: UIView) -> CSView {
        CSView.wrap(flexible: leftView, margin: margin, fixed: rightView)
    }
}