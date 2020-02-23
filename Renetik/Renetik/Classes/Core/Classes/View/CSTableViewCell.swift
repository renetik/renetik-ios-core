//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

public protocol CSTableHeightCalculatingCell {
    associatedtype Row
    func height(for data: Row) -> CGFloat
}

open class CSTableViewCell: UITableViewCell {

    private let layoutFunctions: CSEvent<Void> = event()

    public func layout(function: @escaping () -> Void) {
        layoutFunctions.invoke(listener: { _ in function() })
        function()
    }

    public func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) {
        layoutFunctions.invoke(listener: { _ in function(view) })
        function(view)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }

    open func onLayoutSubviews() {
        runLayoutFunctions()
    }

    private func runLayoutFunctions() {
        layoutFunctions.fire()
    }

    override open var reuseIdentifier: String? {
        if super.reuseIdentifier.notNil { return super.reuseIdentifier }
        return type(of: self).description()
    }
}