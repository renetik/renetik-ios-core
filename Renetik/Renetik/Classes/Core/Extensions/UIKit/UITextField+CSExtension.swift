//
// Created by Rene Dohan on 1/4/20.
//

import Foundation
import UIKit
import BlocksKit

public extension UITextField {

    @discardableResult
    func onChange(_ function: @escaping (UITextField) -> Void) -> Self {
        bk_addObserver(forKeyPath: "text") { argument in function(self) }
        return self
    }

    @discardableResult
    func onClear(_ function: @escaping (UITextField) -> Void) -> Self {
        bk_shouldClearBlock = { _ in
            function(self)
            return true
        }
        return self
    }
}