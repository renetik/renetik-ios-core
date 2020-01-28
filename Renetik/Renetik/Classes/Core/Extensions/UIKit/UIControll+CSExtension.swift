//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc

public extension UIControl {

    @discardableResult
    override func onClick(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        onTouchUp { _ in block() }
        return self
    }
}