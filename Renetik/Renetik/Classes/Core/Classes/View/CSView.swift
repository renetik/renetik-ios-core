//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIView {

    private let layoutFunctions: CSEvent<Void> = event()

    @discardableResult
    public func layout(function: @escaping Func) -> Self {
        layoutFunctions.invoke(listener: { _ in function() })
        function()
        return self
    }

    @discardableResult
    public func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) -> View {
        layoutFunctions.invoke(listener: { _ in function(view) })
        function(view)
        return view
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }

    open func onLayoutSubviews() {
        runLayoutFunctions()
    }

    public func runLayoutFunctions() {
        layoutFunctions.fire()
    }
}
