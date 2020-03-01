//
// Created by Rene Dohan on 1/4/20.
//

import Foundation
import UIKit
import BlocksKit

public extension UITextField {

    @objc func caretRect(for position: UITextPosition) -> CGRect { CGRect.zero }

    @discardableResult
    func clear() -> Self { invoke { self.text = "" } }

    @discardableResult
    func togglePasswordVisibility() -> Self {
        isSecureTextEntry = !isSecureTextEntry
        let existingText = text
        if isSecureTextEntry {
            deleteBackward()
            text = existingText
        }
        return self
    }

    func leftInsetByLeftView(width: CGFloat) -> Self {
        let leftView = UIView.construct(width: width, height: 1)
        leftView.backgroundColor = backgroundColor
        self.leftView = leftView
        leftViewMode = .always
        return self
    }

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