//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSTableViewCell: UITableViewCell {

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

    open func onLayoutSubviews() {
    }

    override open var reuseIdentifier: String? {
        if super.reuseIdentifier.notNil { return super.reuseIdentifier }
        return type(of: self).description()
    }
}