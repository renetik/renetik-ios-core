//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIView {

    private var isDidLayoutSubviews = false
    private var _onLayoutSubviews: (() -> Void)?

    public func execute(onLayoutSubviews: @escaping () -> Void) {
        _onLayoutSubviews = onLayoutSubviews
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        if !isDidLayoutSubviews {
            isDidLayoutSubviews = true
            onCreateLayout()
            onLayoutSubviewsFirstTime()
        } else {
            onLayoutSubviewsUpdate()
        }
        _onLayoutSubviews?()
        onLayoutSubviews()
    }

    open func onCreateLayout() {
    }

    open func onLayoutSubviewsFirstTime() {
    }

    open func onLayoutSubviewsUpdate() {
    }

    open func onLayoutSubviews() {
    }

}
