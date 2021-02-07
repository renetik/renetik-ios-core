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
    static func wrap(fixedLeft: UIView, margin: CGFloat = 0, toFitRight: UIView) -> Self {
        Self.construct().also {
            $0.layout($0.add(view: fixedLeft).from(left: 0)) {
                $0.centeredVertical()
            }
            $0.layout($0.add(view: toFitRight)) {
                $0.fromPrevious(left: margin).resizeToFit().centeredVertical()
            }
        }.resizeToFit()
    }
}