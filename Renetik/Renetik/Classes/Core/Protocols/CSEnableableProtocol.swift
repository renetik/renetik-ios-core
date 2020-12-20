//
// Created by Rene Dohan on 12/17/20.
//

import Foundation

public protocol CSEnableableProtocol: AnyObject {
    var isEnabled: Bool { get set }
}

//public typealias EnableableView = UIView & CSEnableableProtocol

public extension CSEnableableProtocol {
//    private var _isEnabled: CSProperty<Bool> {
//        associatedDictionary("isEnabled") {
//            property(true) { isEnabled in
//                self.interaction(enabled: isEnabled)
//                self.alpha = isEnabled ? 1 : 0.5
//            }
//        }
//    }
//
//    var isEnabled: Bool {
//        get { _isEnabled.value }
//        set { _isEnabled.value(newValue) }
//    }

    @discardableResult
    func disabled(if condition: Bool) -> Self { isEnabled = !condition; return self }

    @discardableResult
    func enabled(if condition: Bool) -> Self { isEnabled = condition; return self }

    @discardableResult
    func enabled() -> Self { isEnabled = true; return self }

    @discardableResult
    func disabled() -> Self { isEnabled = false; return self }
}

extension UIControl: CSEnableableProtocol {}