//
// Created by Rene Dohan on 2/18/20.
//

import UIKit

open class CSCollectionViewCell: UICollectionViewCell {

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
}