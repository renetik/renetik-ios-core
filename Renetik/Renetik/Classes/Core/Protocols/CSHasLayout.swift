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