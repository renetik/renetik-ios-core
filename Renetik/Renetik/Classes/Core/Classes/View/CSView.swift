//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIView {

    private var onUpdateHeight: (() -> Void)?

    public func execute(toUpdateHeight onUpdateHeight: @escaping () -> Void) {
        self.onUpdateHeight = onUpdateHeight
        self.onUpdateHeight?()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
        onUpdateHeight?()
    }

    func onLayoutSubviews() {}
}
