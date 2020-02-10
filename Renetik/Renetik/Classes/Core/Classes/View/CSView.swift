//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIView {

    private let layoutFunctions: CSEvent<Void> = event()

    public func layout(function: @escaping () -> Void) {
        layoutFunctions.invoke(listener: { _ in function() })
        function()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
        layoutFunctions.fire()
    }

    open func onLayoutSubviews() {
    }

}
