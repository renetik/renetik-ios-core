//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIView {

    private var isDidLayoutSubviews = false
    private var onUpdateHeight: (() -> Void)?

    public func execute(toUpdateHeight onUpdateHeight: @escaping () -> Void) {
        self.onUpdateHeight = onUpdateHeight
        self.onUpdateHeight?()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        if !isDidLayoutSubviews {
            isDidLayoutSubviews = true
            onCreateLayout()
            onLayoutSubviewsFirstTime()
        } else {
            onUpdateLayout()
        }
        onUpdateHeight?()
        onLayoutSubviews()
    }

    func onCreateLayout() {
    }

    func onLayoutSubviewsFirstTime() {
    }

    func onUpdateLayout() {
    }

    func onLayoutSubviews() {
    }

}
