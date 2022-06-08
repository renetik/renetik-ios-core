import UIKit
import MaterialComponents.MDCRippleTouchController

extension UIView {
    @discardableResult
    public func addRipple() -> Self {
        interaction(enabled: true)
        let inkTouchController = MDCRippleTouchController(view: self)
        associate("MDCRippleTouchController", inkTouchController)
        inkTouchController.addRipple(to: self)
        return self
    }
}