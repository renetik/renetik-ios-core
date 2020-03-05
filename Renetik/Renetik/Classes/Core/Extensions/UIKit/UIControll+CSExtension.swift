//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc
import BlocksKit

public extension UIControl {

    @discardableResult
    @objc override open func onClick(_ block: @escaping () -> ()) -> Self {
        onTouchUp(block)
    }

    @discardableResult
    func onTouchUp(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        bk_addEventHandler({ _ in block() }, for: .touchUpInside)
        return self
    }

    @discardableResult
    func onTouchDown(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        bk_addEventHandler({ _ in block() }, for: .touchDown)
        return self
    }
}