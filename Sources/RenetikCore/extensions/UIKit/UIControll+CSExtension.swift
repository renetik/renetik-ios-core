//
// Created by Rene Dohan on 1/25/20.
//

import UIKit

public extension UIControl {

//    @discardableResult
//    @objc override func onClick(_ block: @escaping Func) -> Self {
//        onTouchUp(block)
//    }

//    @discardableResult
//    @objc override func onTouchUp(_ block: @escaping Func) -> Self {
//        interaction(enabled: true)
//        addEventHandler(controlEvents: .touchUpInside) { block() }
//        return self
//    }
//
//    @discardableResult
//    @objc override func onTouchDown(_ block: @escaping Func) -> Self {
//        interaction(enabled: true)
//        addEventHandler(controlEvents: .touchDown) { block() }
//        return self
//    }
//
//    @discardableResult
//    @objc override func onTouch(_ block: @escaping ArgFunc<Bool>) -> Self {
//        onTouchDown { block(true) }
//        onTouchUp { block(false) }
//        return self
//    }

// Still works after using recognizers in UIView ?
    func touchUp() { sendActions(for: .touchUpInside) }

    // Still works after using recognizers in UIView ?
    func touchDown() { sendActions(for: .touchDown) }
}
