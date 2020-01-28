//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc

public extension UITextView {

    override public func onClick(_ block: @escaping () -> Void) -> Self {
        self.isEditable = false
        self.isSelectable = false
        return super.onClick(block) as! Self
    }
}