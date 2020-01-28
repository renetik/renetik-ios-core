//
// Created by Rene Dohan on 1/22/20.
//

import UIKit

public extension UITableViewCell {

    @discardableResult
    override open func construct() -> Self {
        super.construct()
        selectedBackgroundView = UIView.withColor(UIColor.clear)
        contentView.matchParent()
        return self
    }

    public func setBackgroundViewColor(_ color: UIColor) {
        backgroundView = UIView.withColor(color)
    }

    public func setSelectedBackgroundColor(_ color: UIColor) {
        selectedBackgroundView = UIView.withColor(color)
    }

    public var cellView: UIView? { contentView.content }
}