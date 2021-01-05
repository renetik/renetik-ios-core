//
// Created by Rene Dohan on 12/17/20.
//

import Foundation

public protocol CSEnableableProtocol: AnyObject {
    var isEnabled: Bool { get set }
}

public extension CSEnableableProtocol {

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